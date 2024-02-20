# == Schema Information
#
# Table name: music_tracks
#
#  id                   :integer          not null, primary key
#  result               :boolean
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  band_id              :integer
#  instrument_wanted_id :integer          not null
#  location_id          :integer          not null
#  music_genre_id       :integer          not null
#  parent_id            :integer
#  user_id              :integer          not null
#
# Indexes
#
#  index_music_tracks_on_instrument_wanted_id  (instrument_wanted_id)
#  index_music_tracks_on_location_id           (location_id)
#  index_music_tracks_on_music_genre_id        (music_genre_id)
#  index_music_tracks_on_parent_id             (parent_id)
#  index_music_tracks_on_user_id               (user_id)
#
# Foreign Keys
#
#  instrument_wanted_id  (instrument_wanted_id => instrument_wanteds.id)
#  location_id           (location_id => locations.id)
#  music_genre_id        (music_genre_id => music_genres.id)
#  parent_id             (parent_id => music_tracks.id) ON DELETE => cascade
#  user_id               (user_id => users.id)
#
class MusicTrack < ApplicationRecord
    belongs_to :user  
    belongs_to :instrument_wanted, class_name: "InstrumentWanted", foreign_key: "instrument_wanted_id"
    belongs_to :music_genre, class_name: "MusicGenre", foreign_key: "music_genre_id"
    belongs_to :location, class_name: "Location", foreign_key: "location_id"
    belongs_to :band, class_name: "Band", foreign_key: "band_id", optional: true
    belongs_to :parent, class_name: "MusicTrack", foreign_key: "parent_id", optional: true
    has_many :children, class_name: "MusicTrack", foreign_key: "parent_id", dependent: :destroy
end

