# Dry Beans

Sistema de gestión de rutas de reparto.

Proyecto creado como aplicación **API-only** (`rails new dry_beans --api`).

## Requisitos

- Ruby 3.3.7
- Rails 8.1.3
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

# (opcional) cargar datos de prueba
bin/rails db:seed

# agregamos las variables de entorno
cp .env.example .env

# Levantar el servidor
bin/rails server

```

## Tests

```bash
bundle exec rspec
```

## API

### Autenticación

El enunciado no exige autenticación, pero se agregó JWT como buena práctica de seguridad para una API expuesta. Todos los endpoints, excepto `/api/v1/login`, requieren un token JWT en el header `Authorization: Bearer <token>`.

**Obtener token:**

```bash
POST /api/v1/login
Content-Type: application/json

{
  "api_key": "tu_api_key"
}
```

Respuesta:
```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9..."
}
```

Los tokens expiran en **24 horas**.

### Endpoints

| Verbo | Ruta | Descripción |
|-------|------|-------------|
| POST | `/api/v1/login` | Obtiene token JWT |
| GET | `/api/v1/routes/:id` | Obtiene una ruta con sus trips y stops |
| POST | `/api/v1/routes/:route_id/trips/:trip_id/stops` | Crea un stop en un trip |


## Estructura

<img width="1301" height="613" alt="dbdesign_screen(1)" src="https://github.com/user-attachments/assets/7f8fb46f-d6a9-4a94-8fd0-65570aae3c22" />

- **Route**: ruta de reparto
- **Trip**: viaje asignado a una ruta (conductor, vehículo, fecha)
- **Stop**: parada de pickup/delivery dentro de un viaje

## Modelo `Route`

Representa la ruta general que agrupa los distintos viajes a realizar (por ejemplo, una zona geográfica o un recorrido asignado a un día).

### Campos

| Campo | Tipo | Razón |
|---|---|---|
| `name` | string | Identifica la ruta de forma legible (ej. "Ruta Norte - Santiago Centro") se usa para listarla y buscarla |
| `status` | integer (enum: `active` / `completed` / `cancelled`) | Permite saber el estado general de la ruta sin tener que inferirlo revisando el estado de cada viaje individualmente |
| `created_at` | datetime | Timestamp automático de Rails |
| `updated_at` | datetime | Timestamp automático de Rails |

---

## Modelo `Trip`

Representa un viaje específico dentro de una ruta — por ejemplo, el recorrido que hace un chofer con un vehículo en una fecha determinada.

### Campos

| Campo | Tipo | Razón |
|---|---|---|
| `route_id` | bigint (FK) | Asocia el viaje a la ruta a la que pertenece |
| `driver_name` | string | Identifica quién realiza el viaje necesario para seguimiento operativo y responsabilidad sobre las entregas/retiros |
| `vehicle_plate` | string | Identifica el vehículo utilizado |
| `status` | integer (enum: `scheduled` / `ongoing` / `finished`) | Permite saber en qué etapa está el viaje (si aún no empieza, está en curso, o ya terminó) |
| `scheduled_date` | date | Fecha planificada del viaje necesaria para organizar la operación día a día y filtrar viajes por fecha |
| `created_at` | datetime | Timestamp automático de Rails|
| `updated_at` | datetime | Timestamp automático de Rails|

---

## Modelo `Stop`

Representa una entrega o un retiro dentro de un viaje. Se diferencia mediante `stop_type` en lugar de usar dos modelos separados (`Delivery` y `Pickup`), ya que ambos comparten casi todos los atributos (dirección, contacto, horario, estado) y esto evita duplicar lógica y validaciones.

## Campos del modelo `Stop`

| Campo | Tipo | Razón |
|---|---|---|
| `stop_type` | integer (enum: `delivery` / `pickup`) | Distingue si es una entrega o un retiro, sin duplicar el modelo en dos tablas |
| `status` | integer (enum: `pending` / `in_progress` / `completed` / `failed`) | Permite trackear el estado real de la operación (si se cumplió, está en curso, o falló) |
| `contact_name` | string | Identifica a la persona que recibe o entrega en destino |
| `contact_phone` | string | Permite contactar al destinatario/remitente si hay un problema en terreno |
| `address` | string | Ubicación física donde ocurre la entrega/retiro |
| `latitude` | decimal | Geolocalización precisa, para ruteo, mapas o cálculo de distancias |
| `longitude` | decimal | Geolocalización precisa,para ruteo, mapas o cálculo de distancias |
| `scheduled_at` | datetime | Ventana horaria planificada para la entrega/retiro |
| `completed_at` | datetime | Timestamp real de cuándo se ejecutó la operación permite medir cumplimiento vs. lo planificado |
| `package_count` | integer | Cantidad de bultos/paquetes involucrados en esa operación |
| `notes` | text | Observaciones libres (ej. "dejar en conserjería") |
