# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Cleaning database..."
Flat.destroy_all
User.destroy_all
Booking.destroy_all

puts "Creating 2 users..."
User.create!(email: "user1@email.com", password: "password")
User.create!(email: "user2@email.com", password: "password")
User.create!(email: "user3@email.com", password: "password")

puts "Creating 3 flats..."
Flat.create!(name: "Flat in Paris", description: "Nice flat in Paris", price_per_night: 100, user_id: User.first.id)
Flat.create!(name: "Flat in London", description: "Nice flat in London", price_per_night: 200, user_id: User.last.id)
Flat.create!(name: "Flat in Berlin", description: "Nice flat in Berlin", price_per_night: 150, user_id: User.first.id)

puts "Creating 3 bookings"
Booking.create!(start_date: Date.today, end_date: Date.today + 3, total_price: 300, user_id: User.first.id, flat_id: Flat.first.id)
Booking.create!(start_date: Date.today, end_date: Date.today + 3, total_price: 600, user_id: User.last.id, flat_id: Flat.last.id)
Booking.create!(start_date: Date.today, end_date: Date.today + 3, total_price: 450, user_id: User.first.id, flat_id: Flat.last.id)

puts "Finished!"