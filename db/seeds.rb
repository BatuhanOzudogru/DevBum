require 'httparty'

# Kullanıcı verilerini çekmek için API adresi
users_api_url = 'https://jsonplaceholder.typicode.com/users'

# API'den kullanıcı verilerini çek
response = HTTParty.get(users_api_url)
users = JSON.parse(response.body)

# Her bir kullanıcı için veritabanına kaydet
users.each do |user_data|
  user = User.find_or_initialize_by(email: user_data['email'])
  user.update!(
    name: user_data['name'],
    username: user_data['username'],
    phone: user_data['phone'],
    website: user_data['website']
  )
  
  user.create_address!(
    street: user_data['address']['street'],
    suite: user_data['address']['suite'],
    city: user_data['address']['city'],
    zipcode: user_data['address']['zipcode'],
    latitude: user_data['address']['geo']['lat'],
    longitude: user_data['address']['geo']['lng']
  )
end

puts "Kullanıcılar başarıyla veritabanına eklendi."
