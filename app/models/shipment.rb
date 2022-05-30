class Shipment < ApplicationRecord
  belongs_to :user
  belongs_to :project

  enum transport_type: [:truck, :train, :plane, :ship]
  enum qr_code_type: [:authentic_network, :regular]
end
