class ChangeMusicGenreIdNullableInMusicTracks < ActiveRecord::Migration[6.1]
	def change
    change_column_null :music_tracks, :music_genre_id, true
  end
end
