require 'rqrcode'
class ShipmentsController < ApplicationController
  before_action :set_shipment, only: [:show ]

  def new
    @shipment = Shipment.new
    authorize @shipment
  end

  def create
    @shipment = Shipment.new(shipment_params)
    authorize @shipment
    if @shipment.save
      redirect_to shipment_path(@shipment)
    else
      render :new
    end
  end

  def show
    authorize @shipment
    @markers = @shipment.scans.map do |scan|
      {
        lat: scan.latitude,
        lng: scan.longitude,
        image_url: helpers.asset_url("location_in_transit.svg")
      }
    end
  end

  def index # missing some stuff
    @shipments = policy_scope(Shipment)
    scans = @shipments.map do |shipment|
      shipment.scans
    end.flatten
    @markers = scans.map do |scan|
      {
        lat: scan.latitude,
        lng: scan.longitude,
        image_url: helpers.asset_url(Shipment::SHIPMENT_STATUS[scan.shipment.status]),
        href: shipment_path(scan.shipment)
      }
    end
  end

  def qr
    @shipment = Shipment.find(params[:shipment_id])
    authorize @shipment
    send_data RQRCode::QRCode.new(new_shipment_scan_url(@shipment)).as_png(size: 800), type: 'image/png', disposition: 'attachment'
  end

  private

  def shipment_params
    params.require(:shipment).permit(:project_id, :user_id, :start_date, :expected_arrival_date, :transport_type,
                                     :starting_location, :destination_location, :qr_code_type, :status)
  end

  def set_shipment
    @shipment = Shipment.find(params[:id])
  end
end
