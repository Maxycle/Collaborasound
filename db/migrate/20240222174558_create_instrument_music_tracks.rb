class CreateInstrumentMusicTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :instrument_music_tracks do |t|
      t.references :instrument, null: false, foreign_key: true
      t.references :music_track, null: false, foreign_key: true

      t.timestamps
    end
  end
end
