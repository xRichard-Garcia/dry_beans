# Dry Beans

Sistema de gestión de rutas de reparto.

## Requisitos

- Ruby 3.3.7
- PostgreSQL 9.5+

## Setup

### Docker

```bash
docker compose up
```

### Manual

```bash
# Instalar dependencias
bundle install

# Crear y migrar la base de datos
bin/rails db:create
bin/rails db:migrate

# Levantar el servidor
bin/rails server
```

## Tests

```bash
bundle exec rspec
```

## API

| Verbo | Ruta | Descripción |
|-------|------|-------------|
| GET | `/api/v1/routes/:id` | Obtiene una ruta con sus trips y stops |
| POST | `/api/v1/routes/:route_id/trips/:trip_id/stops` | Crea un stop en un trip |



## Campos del modelo `Stop`

| Campo | Tipo | Razón |
|---|---|---|
| `stop_type` | integer (enum: `delivery` / `pickup`) | Distingue si es una entrega o un retiro, sin duplicar el modelo en dos tablas |
| `status` | integer (enum: `pending` / `in_progress` / `completed` / `failed`) | Permite trackear el estado real de la operación (si se cumplió, está en curso, o falló) |
| `contact_name` | string | Identifica a la persona que recibe o entrega en destino |
| `contact_phone` | string | Permite contactar al destinatario/remitente si hay un problema en terreno |
| `address` | string | Ubicación física donde ocurre la entrega/retiro |
| `latitude` | decimal | Geolocalización precisa, útil para ruteo, mapas o cálculo de distancias |
| `longitude` | decimal | Geolocalización precisa, útil para ruteo, mapas o cálculo de distancias |
| `scheduled_at` | datetime | Ventana horaria planificada para la entrega/retiro |
| `completed_at` | datetime | Timestamp real de cuándo se ejecutó la operación; permite medir cumplimiento vs. lo planificado |
| `package_count` | integer | Cantidad de bultos/paquetes involucrados en esa operación |
| `notes` | text | Observaciones libres (ej. "dejar en conserjería") |

## Modelo `Route`

Representa la ruta general que agrupa los distintos viajes a realizar (por ejemplo, una zona geográfica o un recorrido asignado a un día).

### Campos

| Campo | Tipo | Razón |
|---|---|---|
| `name` | string | Identifica la ruta de forma legible (ej. "Ruta Norte - Santiago Centro"); se usa para listarla y buscarla |
| `status` | integer (enum sugerido: `active` / `completed` / `cancelled`) | Permite saber el estado general de la ruta sin tener que inferirlo revisando el estado de cada viaje individualmente |
| `created_at` | datetime | Timestamp automático de Rails — útil para ordenar rutas por antigüedad o auditar cuándo se creó |
| `updated_at` | datetime | Timestamp automático de Rails — útil para saber la última vez que se modificó la ruta |

---

## Modelo `Trip`

Representa un viaje específico dentro de una ruta — por ejemplo, el recorrido que hace un chofer con un vehículo en una fecha determinada.

### Campos

| Campo | Tipo | Razón |
|---|---|---|
| `route_id` | bigint (FK) | Asocia el viaje a la ruta a la que pertenece |
| `driver_name` | string | Identifica quién realiza el viaje; necesario para seguimiento operativo y responsabilidad sobre las entregas/retiros |
| `vehicle_plate` | string | Identifica el vehículo utilizado; útil para trazabilidad, mantenimiento y resolución de incidentes |
| `status` | integer (enum: `scheduled` / `ongoing` / `finished`) | Permite saber en qué etapa está el viaje (si aún no empieza, está en curso, o ya terminó) |
| `scheduled_date` | date | Fecha planificada del viaje; necesaria para organizar la operación día a día y filtrar viajes por fecha |
| `created_at` | datetime | Timestamp automático de Rails — útil para auditoría |
| `updated_at` | datetime | Timestamp automático de Rails — útil para saber la última modificación del viaje |



## Estructura

- **Route**: ruta de reparto
- **Trip**: viaje asignado a una ruta (conductor, vehículo, fecha)
- **Stop**: parada de pickup/delivery dentro de un viaje
