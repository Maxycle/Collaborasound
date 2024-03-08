# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :integer          not null
#  user_id         :integer          not null
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#  index_messages_on_user_id          (user_id)
#
# Foreign Keys
#
#  conversation_id  (conversation_id => conversations.id)
#  user_id          (user_id => users.id)
#
class Message < ApplicationRecord
    belongs_to :conversation, dependent: :destroy
    belongs_to :user, dependent: :destroy
end
