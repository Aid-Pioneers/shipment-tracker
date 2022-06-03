class Scan < ApplicationRecord
  belongs_to :shipment

  validates_inclusion_of :sticker_destroyed, in: [true, false]

  reverse_geocoded_by :latitude, :longitude, address: :location
  after_validation :reverse_geocode, if: :will_save_change_to_latitude?
end
