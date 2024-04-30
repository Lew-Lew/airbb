class BookingsController < ApplicationController

  def create
    @flat = Flat.find(params[:flat_id])
    @booking = Booking.new(booking_params)
    @booking.flat = @flat
    @booking.save
    redirect_to flat_path(@flat)
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
