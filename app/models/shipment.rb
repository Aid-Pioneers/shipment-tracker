class Shipment < ApplicationRecord
  belongs_to :user
  belongs_to :project

  has_many :scans, -> { order(date: :desc) }
  has_many :pallets

  enum transport_type: [:truck, :train, :plane, :ship]
  enum qr_code_type: [:authentic_network, :regular]
  enum status: [:in_preparation, :in_transit, :delivered, :problematic]

  validates :qr_code_type, presence: true

  SHIPMENT_STATUS = { "in_preparation" => "location_in_preparation.svg", "in_transit" => "location_in_transit.svg", "delivered" => "location_delivered.svg", "problematic" => "location_problem.svg" }
end
