# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

puts "Cleaning database..."
Flat.destroy_all
User.destroy_all
Booking.destroy_all

puts "Creating 2 users..."
User.create!(email: "user1@email.com", password: "password")
User.create!(email: "user2@email.com", password: "password")
User.create!(email: "user3@email.com", password: "password")

puts "Creating 23 flats..."
Flat.create!(name: "Flat in Paris", description: "Nice flat in Paris", price_per_night: 100, user_id: User.first.id, address: "Paris", guest: 4)
Flat.create!(name: "Flat in London", description: "Nice flat in London", price_per_night: 150, user_id: User.first.id, address: "London", guest: 6)
Flat.create!(name: "Flat in New York", description: "Nice flat in New York", price_per_night: 80, user_id: User.first.id, address: "New York", guest: 2)
20.times do
  Flat.create!(
    name: "#{Faker::Name.name}'s House", 
    description: Faker::Lorem.paragraph, 
    price_per_night: rand(50..300), 
    user_id: User.all.sample.id, 
    address: "#{Faker::Address.street_address}, #{Faker::Address.city}", 
    guest: rand(1..10)
  )
end

puts "Creating 3 bookings"
Booking.create!(start_date: Date.today, end_date: Date.today + 3, total_price: 300, user_id: User.first.id, flat_id: Flat.first.id, status: "pending")
Booking.create!(start_date: Date.today, end_date: Date.today + 3, total_price: 600, user_id: User.last.id, flat_id: Flat.first.id, status: "confirmed")
Booking.create!(start_date: Date.today, end_date: Date.today + 3, total_price: 450, user_id: User.first.id, flat_id: Flat.last.id, status: "confirmed")

puts "Finished!"