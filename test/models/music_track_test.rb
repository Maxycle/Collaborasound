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
require "test_helper"

class MusicTrackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
