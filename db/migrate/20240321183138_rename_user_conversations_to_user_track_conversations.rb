class RenameUserConversationsToUserTrackConversations < ActiveRecord::Migration[6.1]
  def change
		rename_table :user_conversations, :user_track_conversations
  end
end
