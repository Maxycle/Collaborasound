class Listing < ApplicationRecord
    belongs_to :user
    has_many :results, dependent: :destroy
    has_one_attached :original_song

      include PgSearch::Model
      pg_search_scope :search_by_instrument,
        against: [ :instrument ],
        using: {
          tsearch: { prefix: true }
        }
      pg_search_scope :search_by_band,
      against: [ :band ],
      using: {
        tsearch: { prefix: true }
      }
      pg_search_scope :search_by_location,
      against: [ :location ],
      using: {
        tsearch: { prefix: true }
      }
      pg_search_scope :search_by_style,
      against: [ :style ],
      using: {
        tsearch: { prefix: true }
      }
end
