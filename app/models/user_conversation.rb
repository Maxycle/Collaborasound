# == Schema Information
#
# Table name: user_conversations
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :integer          not null
#  user_id         :integer          not null
#
# Indexes
#
#  index_user_conversations_on_conversation_id  (conversation_id)
#  index_user_conversations_on_user_id          (user_id)
#
# Foreign Keys
#
#  conversation_id  (conversation_id => conversations.id)
#  user_id          (user_id => users.id)
#
# app/models/user_conversation.rb
class UserConversation < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  # You can also add validations or additional methods here if needed
end