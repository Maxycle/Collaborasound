# == Schema Information
#
# Table name: instrument_music_tracks
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  instrument_id  :integer          not null
#  music_track_id :integer          not null
#
# Indexes
#
#  index_instrument_music_tracks_on_instrument_id   (instrument_id)
#  index_instrument_music_tracks_on_music_track_id  (music_track_id)
#
# Foreign Keys
#
#  instrument_id   (instrument_id => instruments.id)
#  music_track_id  (music_track_id => music_tracks.id)
#
class InstrumentMusicTrack < ApplicationRecord
  belongs_to :instrument
  belongs_to :music_track
end
