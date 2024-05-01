class FlatsController < ApplicationController
  def index
    @flats = Flat.all

    # The `geocoded` scope filters only flats with coordinates
    @markers = @flats.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
    end
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
