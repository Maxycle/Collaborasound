class AddDeletedToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :deleted, :boolean, default: false
  end
end
