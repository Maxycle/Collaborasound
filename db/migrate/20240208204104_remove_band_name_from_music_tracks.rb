class RemoveBandNameFromMusicTracks < ActiveRecord::Migration[6.1]
  def change
    remove_column :music_tracks, :band_name, :string
  end
end
