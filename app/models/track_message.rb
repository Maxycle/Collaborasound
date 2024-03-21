# == Schema Information
#
# Table name: track_messages
#
#  id                    :integer          not null, primary key
#  content               :text
#  deleted               :boolean          default(FALSE)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  track_conversation_id :integer          not null
#  user_id               :integer          not null
#
# Indexes
#
#  index_track_messages_on_track_conversation_id  (track_conversation_id)
#  index_track_messages_on_user_id                (user_id)
#
# Foreign Keys
#
#  track_conversation_id  (track_conversation_id => track_conversations.id)
#  user_id                (user_id => users.id)
#
class TrackMessage < ApplicationRecord
    belongs_to :track_conversation, dependent: :destroy
    belongs_to :user, dependent: :destroy
end
