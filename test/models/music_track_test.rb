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
require "test_helper"

class MusicTrackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
