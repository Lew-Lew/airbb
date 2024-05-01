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

puts "Creating 20 flats..."
Flat.create!(name: "Flat in Paris", description: "Nice flat in Paris", price_per_night: 100, user_id: User.first.id, address: "48 rue marguerite de rochechouart, Paris")
Flat.create!(name: "Flat in London", description: "Nice flat in London", price_per_night: 200, user_id: User.last.id, address: "49 rue marguerite de rochechouart, London")
Flat.create!(name: "Flat in Berlin", description: "Nice flat in Berlin", price_per_night: 150, user_id: User.first.id, address: "47 rue marguerite de rochechouart, Berlin")
Flat.create!(name: "Flat in New York", description: "Nice flat in New York", price_per_night: 180, user_id: User.first.id, address: "123 Main St, New York")
Flat.create!(name: "Flat in Tokyo", description: "Nice flat in Tokyo", price_per_night: 250, user_id: User.last.id, address: "456 Tokyo St, Tokyo")
Flat.create!(name: "Flat in Sydney", description: "Nice flat in Sydney", price_per_night: 180, user_id: User.first.id, address: "789 Sydney St, Sydney")
Flat.create!(name: "Flat in Rome", description: "Nice flat in Rome", price_per_night: 220, user_id: User.last.id, address: "321 Rome St, Rome")
Flat.create!(name: "Flat in Los Angeles", description: "Nice flat in Los Angeles", price_per_night: 190, user_id: User.first.id, address: "654 LA St, Los Angeles")
Flat.create!(name: "Flat in Shanghai", description: "Nice flat in Shanghai", price_per_night: 210, user_id: User.last.id, address: "987 Shanghai St, Shanghai")
Flat.create!(name: "Flat in Dubai", description: "Nice flat in Dubai", price_per_night: 300, user_id: User.first.id, address: "654 Dubai St, Dubai")
Flat.create!(name: "Flat in Istanbul", description: "Nice flat in Istanbul", price_per_night: 170, user_id: User.last.id, address: "321 Istanbul St, Istanbul")
Flat.create!(name: "Flat in Mumbai", description: "Nice flat in Mumbai", price_per_night: 160, user_id: User.first.id, address: "789 Mumbai St, Mumbai")
Flat.create!(name: "Flat in Seoul", description: "Nice flat in Seoul", price_per_night: 230, user_id: User.last.id, address: "456 Seoul St, Seoul")
Flat.create!(name: "Flat in Moscow", description: "Nice flat in Moscow", price_per_night: 200, user_id: User.first.id, address: "123 Moscow St, Moscow")
Flat.create!(name: "Flat in Cape Town", description: "Nice flat in Cape Town", price_per_night: 150, user_id: User.last.id, address: "987 Cape Town St, Cape Town")
Flat.create!(name: "Flat in Buenos Aires", description: "Nice flat in Buenos Aires", price_per_night: 140, user_id: User.first.id, address: "654 Buenos Aires St, Buenos Aires")
Flat.create!(name: "Flat in Toronto", description: "Nice flat in Toronto", price_per_night: 180, user_id: User.last.id, address: "321 Toronto St, Toronto")
Flat.create!(name: "Flat in Vancouver", description: "Nice flat in Vancouver", price_per_night: 190, user_id: User.first.id, address: "789 Vancouver St, Vancouver")
Flat.create!(name: "Flat in Barcelona", description: "Nice flat in Barcelona", price_per_night: 210, user_id: User.last.id, address: "456 Barcelona St, Barcelona")
Flat.create!(name: "Flat in Amsterdam", description: "Nice flat in Amsterdam", price_per_night: 220, user_id: User.first.id, address: "123 Amsterdam St, Amsterdam")



puts "Creating 3 bookings"
Booking.create!(start_date: Date.today, end_date: Date.today + 3, total_price: 300, user_id: User.first.id, flat_id: Flat.first.id, status: "pending")
Booking.create!(start_date: Date.today, end_date: Date.today + 3, total_price: 600, user_id: User.last.id, flat_id: Flat.first.id, status: "confirmed")
Booking.create!(start_date: Date.today, end_date: Date.today + 3, total_price: 450, user_id: User.first.id, flat_id: Flat.last.id, status: "confirmed")

puts "Finished!"