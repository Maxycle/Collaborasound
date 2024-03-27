# == Schema Information
#
# Table name: music_genre_music_tracks
#
#  id             :bigint           not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  music_genre_id :bigint           not null
#  music_track_id :bigint           not null
#
# Indexes
#
#  index_music_genre_music_tracks_on_music_genre_id  (music_genre_id)
#  index_music_genre_music_tracks_on_music_track_id  (music_track_id)
#
# Foreign Keys
#
#  fk_rails_...  (music_genre_id => music_genres.id)
#  fk_rails_...  (music_track_id => music_tracks.id)
#
class MusicGenreMusicTrack < ApplicationRecord
  belongs_to :music_genre
  belongs_to :music_track
end
