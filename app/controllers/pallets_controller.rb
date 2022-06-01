class PalletsController < ApplicationController
  before_action :set_shipment

  def new
    @pallet = Pallet.new
    authorize @pallet
  end

  def create
    @pallet = Pallet.new(pallet_params)
    authorize @pallet
    @pallet.shipment = @shipment
    if @pallet.save
      redirect_to shipment_path(@shipment)
    else
      render :new
    end
  end

  private

  def set_shipment
    @shipment = Shipment.find(params[:shipment_id])
  end

  def pallet_params
    params.require(:pallet).permit(:user_id, :content, :content_category)
  end
end
