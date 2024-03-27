# == Schema Information
#
# Table name: music_tracks
#
#  id         :bigint           not null, primary key
#  latitude   :float
#  longitude  :float
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  band_id    :integer
#  parent_id  :integer
#  user_id    :bigint           not null
#
# Indexes
#
#  index_music_tracks_on_parent_id  (parent_id)
#  index_music_tracks_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => music_tracks.id) ON DELETE => cascade
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class MusicTrackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
