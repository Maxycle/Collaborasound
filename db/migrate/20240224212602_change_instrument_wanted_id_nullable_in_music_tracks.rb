class ChangeInstrumentWantedIdNullableInMusicTracks < ActiveRecord::Migration[6.1]
	def change
    change_column_null :music_tracks, :instrument_wanted_id, true
  end
end
