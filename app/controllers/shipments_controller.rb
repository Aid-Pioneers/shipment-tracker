require 'rqrcode'
class ShipmentsController < ApplicationController
  def new
    @shipment = Shipment.new
    authorize @shipment
  end

  def create
    @shipment = Shipment.new(shipment_params)
    authorize @shipment

    @shipment.start_lat = Geocoder.search(@shipment.starting_location).first.latitude
    @shipment.start_lon = Geocoder.search(@shipment.starting_location).first.longitude

    @shipment.destination_lat = Geocoder.search(@shipment.destination_location).first.latitude
    @shipment.destination_lon = Geocoder.search(@shipment.destination_location).first.longitude

    if @shipment.save
      redirect_to shipment_path(@shipment)
    else
      render :new
    end
  end

  def show
    @shipment = Shipment.includes(:scans, :pallets).find(params[:id])
    authorize @shipment
    @markers = @shipment.scans.sort.map do |scan|
      {
        lat: scan.latitude,
        lng: scan.longitude,
        image_url: helpers.asset_url("location.svg")
      }
    end
    @markers.unshift({ lat: @shipment.start_lat, lng: @shipment.start_lon, image_url: helpers.asset_url("location_start.svg")})
    @markers.push({ lat: @shipment.destination_lat, lng: @shipment.destination_lon, image_url: helpers.asset_url("location_destination.svg")})
  end

  def index
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
