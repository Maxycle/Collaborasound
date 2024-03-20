class RenameConversationsToTrackConversations < ActiveRecord::Migration[6.1]
  def change
		rename_table :conversations, :track_conversations
  end
end
