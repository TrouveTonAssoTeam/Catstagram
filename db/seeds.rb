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
Faker::Config.locale= 'fr'

10.times do |i|
    Item.create!(
        name: Faker::Book.title,
        description: Faker::Lorem.paragraph,
        # Price with 1 decimal from 0.5 to 20
        price: Kernel.format("%.1f", rand(0.5..20.0)),
        image_url: "https://picsum.photos/200/300?random=#{i}",
        tag: "img"
    )
end

# Create admin
User.create!(
    first_name: "Admin",
    email: "admin@catstagram.fr",
    password: "admin123",
    admin: true
)