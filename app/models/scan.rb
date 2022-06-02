class Scan < ApplicationRecord
  belongs_to :shipment

  validates :location, presence: true
  validates_inclusion_of :sticker_destroyed, in: [true, false]

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
