class RemoveFieldFromMusicTrack < ActiveRecord::Migration[6.1]
  def change
    remove_column :music_tracks, :geographical_location, :string
    remove_column :music_tracks, :instrument_wanted, :string
    remove_column :music_tracks, :music_genre, :string
  end
end
