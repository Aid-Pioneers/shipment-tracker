class Scan < ApplicationRecord
  belongs_to :shipment

  validates :location, presence: true
  validates :sticker_destroyed, presence: true
end
