class AddBandNameToMusicTracks < ActiveRecord::Migration[6.1]
  def change
    add_column :music_tracks, :band_name, :string
  end
end
