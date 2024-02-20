class AddParentIdToMusicTracks < ActiveRecord::Migration[6.1]
  def change
    add_column :music_tracks, :parent_id, :integer
    add_index :music_tracks, :parent_id
    add_foreign_key :music_tracks, :music_tracks, column: :parent_id, on_delete: :cascade
  end
end
