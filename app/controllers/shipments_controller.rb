require 'rqrcode'
class ShipmentsController < ApplicationController
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
    @shipment = Shipment.includes(:scans, :pallets).find(params[:id])
    authorize @shipment
    @markers = @shipment.scans.map do |scan|
      {
        lat: scan.latitude,
        lng: scan.longitude
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
        lng: scan.longitude
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
