class RenameMessagesToTrackMessages < ActiveRecord::Migration[6.1]
  def change
		rename_table :messages, :track_messages
  end
end
