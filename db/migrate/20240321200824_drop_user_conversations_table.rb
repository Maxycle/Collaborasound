class DropUserConversationsTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :user_conversations
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
