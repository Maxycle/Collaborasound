class AddLocationIdToMusicTracks < ActiveRecord::Migration[6.1]
  def change
    add_reference :music_tracks, :location, null: false, foreign_key: true
  end
end
