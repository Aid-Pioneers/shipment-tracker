class Pallet < ApplicationRecord
  CATEGORIES = ["Food", "Medicine", "Hygiene", "Clothes", ]

  belongs_to :donor, class_name: "User", foreign_key: "user_id"
  belongs_to :shipment

  validates :content, presence: true
end
