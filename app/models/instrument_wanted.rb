# == Schema Information
#
# Table name: instrument_wanteds
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class InstrumentWanted < ApplicationRecord
	has_many :instrument_wanted_music_tracks, dependent: :destroy
  has_many :music_tracks, through: :instrument_wanted_music_tracks
end
