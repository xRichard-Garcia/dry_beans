# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Limpiando BD"
Stop.destroy_all
Trip.destroy_all
Route.destroy_all

puts "Creando rutas..."

route_norte = Route.create!(name: "Ruta Norte - Santiago Centro")

trip1 = route_norte.trips.create!(
  driver_name: "Juan Pérez",
  status: :ongoing,
  scheduled_date: Date.today
)

trip1.stops.create!(
  stop_type: :delivery,
  status: :completed,
  contact_name: "María López",
  contact_phone: "+56912345678",
  address: "Av. Providencia 1234, Providencia",
  latitude: -33.4263,
  longitude: -70.6126,
  scheduled_at: Time.current.beginning_of_day + 9.hours,
  completed_at: Time.current.beginning_of_day + 9.hours + 15.minutes,
  package_count: 3,
  notes: "Entregado en conserjería"
)

trip1.stops.create!(
  stop_type: :delivery,
  status: :in_progress,
  contact_name: "Carlos Soto",
  contact_phone: "+56923456789",
  address: "Av. Apoquindo 5600, Las Condes",
  latitude: -33.4098,
  longitude: -70.5667,
  scheduled_at: Time.current.beginning_of_day + 10.hours,
  package_count: 1,
  notes: "Cliente pidió avisar 10 min antes"
)

trip1.stops.create!(
  stop_type: :pickup,
  status: :pending,
  contact_name: "Tienda Repuestos Sur",
  contact_phone: "+56934567890",
  address: "Av. Vicuña Mackenna 4860, La Florida",
  latitude: -33.5208,
  longitude: -70.5979,
  scheduled_at: Time.current.beginning_of_day + 14.hours,
  package_count: 5,
  notes: "Retiro de mercadería devuelta"
)

# Ruta 2: ya finalizada, 2 viajes
route_sur = Route.create!(name: "Ruta Sur - Concepción")

trip2 = route_sur.trips.create!(
  driver_name: "Ana Torres",
  status: :finished,
  scheduled_date: Date.yesterday
)

trip2.stops.create!(
  stop_type: :delivery,
  status: :completed,
  contact_name: "Pedro Martínez",
  contact_phone: "+56945678901",
  address: "Calle Barros Arana 450, Concepción",
  latitude: -36.8270,
  longitude: -73.0498,
  scheduled_at: Date.yesterday.to_time + 11.hours,
  completed_at: Date.yesterday.to_time + 11.hours + 20.minutes,
  package_count: 2
)

trip2.stops.create!(
  stop_type: :pickup,
  status: :failed,
  contact_name: "Bodega Central Bio Bío",
  contact_phone: "+56956789012",
  address: "Ruta 160, Talcahuano",
  latitude: -36.7249,
  longitude: -73.1169,
  scheduled_at: Date.yesterday.to_time + 16.hours,
  package_count: 8,
  notes: "No había nadie en el punto de retiro"
)

trip3 = route_sur.trips.create!(
  driver_name: "Luis Fernández",
  status: :finished,
  scheduled_date: Date.yesterday
)

trip3.stops.create!(
  stop_type: :delivery,
  status: :completed,
  contact_name: "Farmacia San Rafael",
  contact_phone: "+56967890123",
  address: "Av. Los Carrera 789, Chiguayante",
  latitude: -36.9167,
  longitude: -73.0167,
  scheduled_at: Date.yesterday.to_time + 13.hours,
  completed_at: Date.yesterday.to_time + 13.hours + 10.minutes,
  package_count: 4
)

# Ruta 3: todavía sin iniciar (sin stops completados)
route_valpo = Route.create!(name: "Ruta Valparaíso - Puerto")

trip4 = route_valpo.trips.create!(
  driver_name: "Jorge Ramírez",
  status: :scheduled,
  scheduled_date: Date.tomorrow
)

trip4.stops.create!(
  stop_type: :delivery,
  status: :pending,
  contact_name: "Hostal Mirador",
  contact_phone: "+56978901234",
  address: "Cerro Alegre 234, Valparaíso",
  latitude: -33.0458,
  longitude: -71.6197,
  scheduled_at: Date.tomorrow.to_time + 9.hours,
  package_count: 1
)

trip4.stops.create!(
  stop_type: :pickup,
  status: :pending,
  contact_name: "Importadora Puerto",
  contact_phone: "+56989012345",
  address: "Av. Errázuriz 1100, Valparaíso",
  latitude: -33.0369,
  longitude: -71.6294,
  scheduled_at: Date.tomorrow.to_time + 11.hours,
  package_count: 12,
  notes: "Requiere montacargas"
)

puts "✅ Seeds creados:"
puts "IDs para probar en Postman:"
Route.all.each do |r|
  puts "   Route##{r.id} '#{r.name}' - trips: #{r.trips.pluck(:id).join(', ')}"
end
