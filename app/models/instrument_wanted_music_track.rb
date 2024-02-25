# == Schema Information
#
# Table name: instrument_wanted_music_tracks
#
#  id                   :integer          not null, primary key
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  instrument_wanted_id :integer          not null
#  music_track_id       :integer          not null
#
# Indexes
#
#  index_instrument_wanted_music_tracks_on_instrument_wanted_id  (instrument_wanted_id)
#  index_instrument_wanted_music_tracks_on_music_track_id        (music_track_id)
#
# Foreign Keys
#
#  instrument_wanted_id  (instrument_wanted_id => instrument_wanteds.id)
#  music_track_id        (music_track_id => music_tracks.id)
#
# app/models/instrument_wanted_music_track.rb
class InstrumentWantedMusicTrack < ApplicationRecord
  belongs_to :instrument_wanted
  belongs_to :music_track
end
