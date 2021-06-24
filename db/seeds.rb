# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Result.destroy_all
Listing.destroy_all

puts 'Creating 25 users/listings...'

25.times do |i|
 user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    username: Faker::GreekPhilosophers.name,
    email: Faker::Internet.unique.email,
    password: 123456
    )
 Listing.create!(
    user: user,
    band: Faker::Name.last_name,
    location: Faker::Address.city,
    instrument: Faker::Music.instrument ,
    style: Faker::Music.genre,
    comment: Faker::GreekPhilosophers.quote
    )
 puts "#{i + 1} - #{user.first_name} - #{user.listings.first.instrument} - #{user.listings.first.style} - #{user.listings.first.location}"
 end
      puts 'Finished!'