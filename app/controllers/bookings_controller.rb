class BookingsController < ApplicationController

  def index
    @bookings = Booking.all
    @bookings_per_user = @bookings.where(user_id: current_user)
  end

  def create
    @flat = Flat.find(params[:flat_id])
    @booking = Booking.new(booking_params)
    @booking.flat = @flat
    @booking.user = current_user
    if @booking.save
      redirect_to flats_path
    else
      render "flats/show"
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
