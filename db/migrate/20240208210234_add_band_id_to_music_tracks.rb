class AddBandIdToMusicTracks < ActiveRecord::Migration[6.1]
  def change
    add_column :music_tracks, :band_id, :integer
  end
end
