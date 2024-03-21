# == Schema Information
#
# Table name: track_conversations
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  music_track_id :integer          not null
#
# Indexes
#
#  index_track_conversations_on_music_track_id  (music_track_id)
#
# Foreign Keys
#
#  music_track_id  (music_track_id => music_tracks.id)
#
class TrackConversation < ApplicationRecord
	has_and_belongs_to_many :users, join_table: :user_track_conversations
	belongs_to :music_track
	has_many :track_messages, dependent: :destroy
end
