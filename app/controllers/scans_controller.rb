class ScansController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new, :create ]

  def new
    @scan = Scan.new
    @shipment = Shipment.find(params[:shipment_id])
    authorize @scan
  end

  def create
    @scan = Scan.new(scan_params)
    @shipment = Shipment.find(params[:shipment_id])
    @scan.shipment = @shipment
    @scan.date = DateTime.now
    authorize @scan
    if @scan.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def scan_params
    params.require(:scan).permit(:sticker_destroyed, :latitude, :longitude)
  end
end
