class Pallet < ApplicationRecord
  belongs_to :user
  belongs_to :shipment
end
