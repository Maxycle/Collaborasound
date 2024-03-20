class RenameConversationIdToTrackConversationIdInMessages < ActiveRecord::Migration[6.1]
  def change
		rename_column :messages, :conversation_id, :track_conversation_id
  end
end
