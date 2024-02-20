class RenameNameToTitleInMusicTracks < ActiveRecord::Migration[6.1]
  def change
    rename_column :music_tracks, :name, :title
  end
end
