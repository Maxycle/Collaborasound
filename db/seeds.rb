# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# In your Rails console
require 'faker'

# Creating fake users
5.times do
  User.create(
    first_name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
end

10.times do
  unique_genre = nil

  # Keep generating a genre until a non-empty, non-nil name is obtained
  while unique_genre.nil? || MusicGenre.exists?(name: unique_genre)
    unique_genre = Faker::Music.genre
  end

  MusicGenre.create(name: unique_genre)

end

6.times do
  unique_band_name = nil
  while unique_band_name.nil? || Band.exists?(name: unique_band_name)
    unique_band_name = Faker::Music::RockBand.name
  end

  Band.create(name: unique_band_name)
end

10.times do
  unique_instrument = nil
  while unique_instrument.nil? || Instrument.exists?(name: unique_instrument)
    unique_instrument = Faker::Music.instrument
  end

  Instrument.create(name: unique_instrument)
end

15.times do
  unique_location = nil
  while unique_location.nil? || Location.exists?(name: unique_location)
    unique_location = Faker::Address.city
  end

  Location.create(name: unique_location)
end

10.times do
  music_genre_ids = MusicGenre.pluck(:id).sample(4)
  instrument_ids = Instrument.pluck(:id).sample(4)

  music_track = MusicTrack.create(
    title: Faker::Lorem.words(number: 3).join(' '),
    location_id: Location.pluck(:id).sample,
    band_id: Band.pluck(:id).sample,
    user_id: User.pluck(:id).sample
  )

  music_genre_ids.each do |genre_id|
    music_track.music_genres << MusicGenre.find(genre_id)
  end

  instrument_ids.each do |instrument_id|
    music_track.instruments << Instrument.find(instrument_id)
  end
end


# 4.times do
#   MusicTrack.create(
#     title:MusicTrack.find(3).title,
#     music_genre_id:MusicTrack.find(3).music_genre_id,
#     Instrument_id:MusicTrack.find(3).Instrument_id,
#     location_id:MusicTrack.find(3).location_id,
#     band_id:MusicTrack.find(3).band_id,
#     user_id: MusicTrack.find(3).user_id,
#     parent_id: 3
#   )
# end
# 3.times do
#   MusicTrack.create(
#     title:Faker::Lorem.words(number: 3).join(' '),
#     music_genre_id:MusicGenre.pluck(:id).sample,
#     Instrument_id:Instrument.pluck(:id).sample,
#     location_id:Location.pluck(:id).sample,
#     band_id:Band.pluck(:id).sample,
#     user_id: User.pluck(:id).sample
#   )
# end