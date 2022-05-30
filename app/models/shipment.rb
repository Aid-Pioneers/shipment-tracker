class Shipment < ApplicationRecord
  belongs_to :user
  belongs_to :project

  has_many :scans
  has_many :pallets

  enum transport_type: [:truck, :train, :plane, :ship]
  enum qr_code_type: [:authentic_network, :regular]

  validates :qr_code_type, presence: true
end
