# == Schema Information
#
# Table name: instrument_music_tracks
#
#  id             :bigint           not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  instrument_id  :bigint           not null
#  music_track_id :bigint           not null
#
# Indexes
#
#  index_instrument_music_tracks_on_instrument_id   (instrument_id)
#  index_instrument_music_tracks_on_music_track_id  (music_track_id)
#
# Foreign Keys
#
#  fk_rails_...  (instrument_id => instruments.id)
#  fk_rails_...  (music_track_id => music_tracks.id)
#
class InstrumentMusicTrack < ApplicationRecord
  belongs_to :instrument
  belongs_to :music_track
end
