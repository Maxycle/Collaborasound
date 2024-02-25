class CreateInstrumentWantedMusicTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :instrument_wanted_music_tracks do |t|
      t.references :instrument_wanted, null: false, foreign_key: true
      t.references :music_track, null: false, foreign_key: true

      t.timestamps
    end
  end
end
