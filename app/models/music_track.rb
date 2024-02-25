# == Schema Information
#
# Table name: music_tracks
#
#  id          :integer          not null, primary key
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  band_id     :integer
#  location_id :integer          not null
#  parent_id   :integer
#  user_id     :integer          not null
#
# Indexes
#
#  index_music_tracks_on_location_id  (location_id)
#  index_music_tracks_on_parent_id    (parent_id)
#  index_music_tracks_on_user_id      (user_id)
#
# Foreign Keys
#
#  location_id  (location_id => locations.id)
#  parent_id    (parent_id => music_tracks.id) ON DELETE => cascade
#  user_id      (user_id => users.id)
#
class MusicTrack < ApplicationRecord
    belongs_to :user  
    has_many :instrument_music_tracks, dependent: :destroy
  	has_many :instruments, through: :instrument_music_tracks, source: :instrument
		has_many :music_genre_music_tracks, dependent: :destroy
  	has_many :music_genres, through: :music_genre_music_tracks
    belongs_to :location, class_name: "Location", foreign_key: "location_id"
    belongs_to :band, class_name: "Band", foreign_key: "band_id", optional: true
    belongs_to :parent, class_name: "MusicTrack", foreign_key: "parent_id", optional: true
    has_many :children, class_name: "MusicTrack", foreign_key: "parent_id", dependent: :destroy
end

