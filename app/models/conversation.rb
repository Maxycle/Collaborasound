# == Schema Information
#
# Table name: conversations
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  music_track_id :integer          not null
#
# Indexes
#
#  index_conversations_on_music_track_id  (music_track_id)
#
# Foreign Keys
#
#  music_track_id  (music_track_id => music_tracks.id)
#
class Conversation < ApplicationRecord
		has_many :user_conversations
		has_many :users, through: :user_conversations
    belongs_to :music_track
		has_many :messages, dependent: :destroy
end
