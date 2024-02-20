class AddMusicGenreToMusicTracks < ActiveRecord::Migration[6.1]
  def change
    add_reference :music_tracks, :music_genre, null: false, foreign_key: true
  end
end
