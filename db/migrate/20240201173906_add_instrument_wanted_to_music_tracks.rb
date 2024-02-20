class AddInstrumentWantedToMusicTracks < ActiveRecord::Migration[6.1]
  def change
    add_reference :music_tracks, :instrument_wanted, null: false, foreign_key: true
  end
end
