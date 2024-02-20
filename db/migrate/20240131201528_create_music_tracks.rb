class CreateMusicTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :music_tracks do |t|
      t.string :name
      t.string :music_genre
      t.string :geographical_location
      t.string :instrument_wanted

      t.timestamps
    end
  end
end
