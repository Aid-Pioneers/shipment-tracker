class Scan < ApplicationRecord
  include Hashid::Rails
  belongs_to :shipment

  validates :location, presence: true
  validates_inclusion_of :sticker_destroyed, in: [true, false]
end
