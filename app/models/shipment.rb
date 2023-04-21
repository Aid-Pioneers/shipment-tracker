class Shipment < ApplicationRecord
  belongs_to :user
  belongs_to :project

  has_many :scans, -> { order(date: :desc) }
  has_many :pallets

  enum transport_type: [:truck, :train, :plane, :ship]
  enum status: [:in_preparation, :in_transit, :delivered, :problematic]

  validates :qr_code_type, presence: true

  SHIPMENT_STATUS = { "in_preparation" => "location_in_preparation.svg", "in_transit" => "location_in_transit.svg", "delivered" => "location_delivered.svg", "problematic" => "location_problem.svg" }

  def all_donors
    donors = pallets.map do |pallet|
      pallet.donor.full_name
    end

    if donors.uniq.size < 2
      donors.first
    elsif donors.size < 1
      ""
    else
      donors.uniq.join(", ")[0..20] + "..."
    end
  end
end
