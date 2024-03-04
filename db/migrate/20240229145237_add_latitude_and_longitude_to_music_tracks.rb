class AddLatitudeAndLongitudeToMusicTracks < ActiveRecord::Migration[6.1]
  def change
    add_column :music_tracks, :latitude, :float
    add_column :music_tracks, :longitude, :float
  end
end
