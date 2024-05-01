class BookingsController < ApplicationController

  def my_bookings
    @bookings = Booking.all
    @bookings_per_user = @bookings.where(user_id: current_user)
  end

  def create
    @flat = Flat.find(params[:flat_id])
    @booking = Booking.new(booking_params)
    @booking.flat = @flat
    @booking.user = current_user
    @booking.status = "pending"
    @booking.total_price = @booking.flat.price_per_night * (@booking.end_date - @booking.start_date).to_i
    if @booking.save
      redirect_to flats_path
    else
      render "flats/show"
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status, :total_price, :user_id, :flat_id)
  end
end
