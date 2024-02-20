class AddResultToMusicTracks < ActiveRecord::Migration[6.1]
  def change
    add_column :music_tracks, :result, :boolean
  end
end
