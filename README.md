# DevBum Rails Application

## Introduction
This repository contains a Ruby on Rails application called DevBum. DevBum is a simple web application designed to manage user information and their albums using JSONPlaceholder API.

## Application Overview
DevBum allows users to perform CRUD operations on user data including their address information. It also integrates with JSONPlaceholder API to fetch albums and associated photos for each user.

## Technologies and Gems Used
- Ruby on Rails
- PostgreSQL (as the database)
- HTTParty gem (for making HTTP requests)
- Tailwind CSS (for styling)
- Turbo (for seamless navigation)

## Installation
To run this application locally, follow these steps:

1. Clone the repository:
```bash
   git clone https://github.com/BatuhanOzudogru/DevBum
```

2. Install gems
```bash
bundle install
```
 
3. Set up the database:
```bash
rails db:create
rails db:seed
```

4. Start the Rails server:
```bash
bin/dev
```

5. Access the application in your browser at `http://localhost:3000`

## Acknowledgements
- This application uses data from [JSONPlaceholder](https://jsonplaceholder.typicode.com/) for demonstrating album fetching functionality.
- Tailwind CSS and Font Awesome icons are utilized for styling and UI components.
- Internationalization (i18n) is implemented for multiple languages (English and Turkish).

---
### Author
Batuhan Özüdoğru