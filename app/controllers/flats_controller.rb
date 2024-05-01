class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @flats = Flat.all
    if params[:query].present?
      @flats = @flats.where("name LIKE ? OR address LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end

    # The `geocoded` scope filters only flats with coordinates
    @markers = @flats.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
    end
  end

  def my_flats
    @my_flats = current_user.flats    
  end

  def show
    @flat = Flat.find(params[:id])
    @booking = Booking.new
    @markers = [{
      lat: @flat.latitude,
      lng: @flat.longitude
    }]
  end
end
