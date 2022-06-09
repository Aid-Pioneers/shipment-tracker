require 'rqrcode'
class ShipmentsController < ApplicationController
  def new
    @shipment = Shipment.new
    authorize @shipment
  end

  def create
    @shipment = Shipment.new(shipment_params)
    authorize @shipment

    result_start = Geocoder.search(@shipment.starting_location)
    result_destination = Geocoder.search(@shipment.destination_location)

    @shipment.start_lat = result_start.first.latitude
    @shipment.start_lon = result_start.first.longitude

    @shipment.destination_lat = result_destination.first.latitude
    @shipment.destination_lon = result_destination.first.longitude

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
    if @markers.size.positive?
      @markers.last[:image_url] = helpers.asset_url("location_in_transit.svg")
    end
    @markers.unshift({ lat: @shipment.start_lat, lng: @shipment.start_lon, image_url: helpers.asset_url("location_start.svg")})
    @markers.push({ lat: @shipment.destination_lat, lng: @shipment.destination_lon, image_url: helpers.asset_url("location_destination.svg")})

    unless @shipment.pallets.nil?
      @markers_pallets = @shipment.pallets.map do |pallet|
        if pallet.pallet_scans.last.nil?
          unless @shipment.scans.last.nil?
            {
              lat: @shipment.scans.last.latitude,
              lng: @shipment.scans.last.longitude,
              image_url: helpers.asset_url("location_pallet.svg")
            }
          else
            {
              lat: @shipment.start_lat,
              lng: @shipment.start_lon,
              image_url: helpers.asset_url("location_pallet.svg")
            }
          end
        else
          {
            lat: pallet.pallet_scans.last.latitude,
            lng: pallet.pallet_scans.last.longitude,
            image_url: helpers.asset_url("location_pallet.svg")
          }
        end
      end
    end
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

    if params[:query].present? && params[:query] != "all"
      @shipments = @shipments.where(status: params[:query])
    end

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'shipments/shipment_card_admin_index', locals: { shipments: @shipments }, formats: [:html] }
    end

  end

  def edit
    @shipment = Shipment.find(params[:id])
    authorize @shipment
  end

  def update
    @shipment = Shipment.find(params[:id])
    authorize @shipment
    if @shipment.update(shipment_params)
      redirect_to shipment_path(@shipment)
    else
      render :edit
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
end
