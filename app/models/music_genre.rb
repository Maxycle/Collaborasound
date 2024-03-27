# == Schema Information
#
# Table name: music_genres
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class MusicGenre < ApplicationRecord
	has_many :music_genre_music_tracks, dependent: :destroy
  has_many :music_tracks, through: :music_genre_music_tracks
end
