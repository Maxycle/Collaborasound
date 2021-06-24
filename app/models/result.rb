class Result < ApplicationRecord
    belongs_to :user
    belongs_to :listing
    has_one_attached :result_song
end
