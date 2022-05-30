class Pallet < ApplicationRecord
  belongs_to :donor, class_name: "User", foreign_key: "user_id"
  belongs_to :shipment
end
