class AddCommentToListings < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :comment, :text
  end
end
