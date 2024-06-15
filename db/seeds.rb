# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'httparty'

# Kullanıcı verilerini çekmek için API adresi
users_api_url = 'https://jsonplaceholder.typicode.com/users'

# API'den kullanıcı verilerini çek
response = HTTParty.get(users_api_url)
users = JSON.parse(response.body)

# Her bir kullanıcı için veritabanına kaydet
users.each do |user_data|
    User.create!(
      name: user_data['name'],
      username: user_data['username'],
      email: user_data['email'],
      phone: user_data['phone'],
      website: user_data['website'],
      address: {
        street: user_data['address']['street'],
        suite: user_data['address']['suite'],
        city: user_data['address']['city'],
        zipcode: user_data['address']['zipcode'],
        geo: {
          lat: user_data['address']['geo']['lat'],
          lng: user_data['address']['geo']['lng']
        }
      }
    )
  end

puts "Kullanıcılar başarıyla veritabanına eklendi."
