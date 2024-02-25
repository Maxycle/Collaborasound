# == Schema Information
#
# Table name: instruments
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Instrument < ApplicationRecord
	has_many :instrument_music_tracks, dependent: :destroy
  has_many :music_tracks, through: :instrument_music_tracks
end
