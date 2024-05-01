class BookingsController < ApplicationController

  def index
    @flat = Flat.find(params[:flat_id])
    @bookings_per_flat = @flat.bookings
  end

  def my_bookings
    @bookings_per_user = current_user.bookings
  end

  def create
    if !user_signed_in?
      flash[:error] = "You need to sign in to book a flat"
      redirect_to new_user_session_path
      return
    end
    
    @flat = Flat.find(params[:flat_id])
    @booking = Booking.new(booking_params)
    @booking.flat = @flat
    @booking.user = current_user
    @booking.status = "pending"
    @booking.total_price = @booking.flat.price_per_night * (@booking.end_date - @booking.start_date).to_i
    if @booking.save
      redirect_to flats_path
    else
      flash[:error] = @booking.errors.full_messages.join(", ")
      # TODO fix flash.now to use with render
      # render "flats/show"
      redirect_to flat_path(@flat)
    end 
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def update_status
    logger.debug "CEST ICIIIIIII"

    @booking = Booking.find(params[:id])
    logger.debug @booking
    @booking.update(status: params[:status])
    redirect_to flat_bookings_path(@booking.flat)
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status, :total_price)
  end
end
