class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def donations
    @shipments = current_user.donations.includes(shipment: :scans).order(shipment_id: :desc).map(&:shipment).uniq
    @donations = current_user.donations
  end
end
