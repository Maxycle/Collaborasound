class CreateMusicGenreMusicTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :music_genre_music_tracks do |t|
      t.references :music_track, null: false, foreign_key: true
      t.references :music_genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
