class AddUserIdToMusicTracks < ActiveRecord::Migration[6.1]
  def change
    add_reference :music_tracks, :user, null: false, foreign_key: true
  end
end
