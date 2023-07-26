# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Customer.destroy_all
Tea.destroy_all
Subscription.destroy_all
CustomerSubscription.destroy_all
SubscriptionTea.destroy_all

Customer.create!(first_name: "Ollie", last_name: "Herbert", email: "123@gmail.com", address: "404 Not Found Avenue, Space, Universe")
Customer.create!(first_name: "Melvin", last_name: "Beaver", email: "12@gmail.com", address: "200 Found Avenue, Space, Universe")
Tea.create!(title: "Green Tea", description: "classic green hue tea", temperature: 110, brew_time: 600)
Tea.create!(title: "Black Tea", description: "classic black hue tea", temperature: 130, brew_time: 800)
Tea.create!(title: "White Tea", description: "classic white hue tea", temperature: 140, brew_time: 500)
Tea.create!(title: "Earl Grey", description: "oil and bergamot flavored", temperature: 200, brew_time: 600)
Tea.create!(title: "Herbal Tea", description: "herbal infustion and spices", temperature: 180, brew_time: 900)
Tea.create!(title: "Hibiscus Tea", description: "crimson & magenta calyces", temperature: 135, brew_time: 550)
Subscription.create!(title: "Silver", price: 700, frequency: 0)
Subscription.create!(title: "Gold", price: 1200, frequency: 2)