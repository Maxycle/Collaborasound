class AddBandToListing < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :band, :string
  end
end
