class Shipment < ApplicationRecord
  belongs_to :user
  belongs_to :project

  has_many :scans, -> { order(date: :desc) }
  has_many :pallets

  enum transport_type: [:truck, :train, :plane, :ship]
  enum qr_code_type: [:authentic_network, :regular]
  enum status: [:in_preparation, :in_transit, :delivered, :problematic]

  validates :qr_code_type, presence: true

  def all_donors
    donors = pallets.map do |pallet|
      pallet.donor.full_name
    end

    if donors.uniq.size < 2
      donors.first
    else
      donors.uniq.join(", ")[0..20] + "..."
    end
  end
end
