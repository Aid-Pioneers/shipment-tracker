class PalletsController < ApplicationController
  before_action :set_shipment

  def new
    @pallet = Pallet.new
    authorize @pallet
  end

  def create
    if params[:count].present? && params[:count].to_i.positive?
      params[:count].to_i.times do
        @pallet = Pallet.new(pallet_params)
        authorize @pallet
        @pallet.shipment = @shipment
        unless @pallet.save
          render :new
          return
        end
      end
      redirect_to shipment_path(@shipment)
    else
      @pallet = Pallet.new(pallet_params)
      authorize @pallet
      @pallet.shipment = @shipment
      if @pallet.save
        redirect_to shipment_path(@shipment)
      else
        render :new
      end
    end
  end

  def edit

  end

  def update
    @pallet.update(pallet_params)
    @pallet.shipment = @shipment
    if @pallet.save
      redirect_to shipment_path(@shipment), notice: 'Your item was successfully updated.'
    else
      render :edit, notice: 'Error, your item was not properly edited, try again.'
    end
  end

  def destroy
    @pallet.destroy
    redirect_to shipment_path(@shipment)
  end

  private

  def set_shipment
    @shipment = Shipment.find(params[:shipment_id])
  end

  def pallet_params
    params.require(:pallet).permit(:user_id, :content, :content_category)
  end
end
