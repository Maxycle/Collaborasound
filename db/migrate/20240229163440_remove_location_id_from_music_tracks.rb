class RemoveLocationIdFromMusicTracks < ActiveRecord::Migration[6.1]
	def change
    remove_column :music_tracks, :location_id
  end
end
