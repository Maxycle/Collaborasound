# == Schema Information
#
# Table name: music_genre_music_tracks
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  music_genre_id :integer          not null
#  music_track_id :integer          not null
#
# Indexes
#
#  index_music_genre_music_tracks_on_music_genre_id  (music_genre_id)
#  index_music_genre_music_tracks_on_music_track_id  (music_track_id)
#
# Foreign Keys
#
#  music_genre_id  (music_genre_id => music_genres.id)
#  music_track_id  (music_track_id => music_tracks.id)
#
# app/models/Instrument_music_track.rb
class MusicGenreMusicTrack < ApplicationRecord
  belongs_to :music_genre
  belongs_to :music_track
end
