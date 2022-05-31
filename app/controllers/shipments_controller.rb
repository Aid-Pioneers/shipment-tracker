class ShipmentsController < ApplicationController
  before_action :set_shipment

  def show
    authorize @shipment
  end

  private

  def set_shipment
    @shipment = Shipment.find(params[:id])
  end
end
