class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @flats = Flat.all
    if params[:query].present?
      @flats = @flats.where("name LIKE ? OR address LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'flats/list', locals: { flats: @flats },  formats: :html }
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

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    if @flat.save
      redirect_to flat_path(@flat)
    else
      render :new
      # TODO -> voir pourquoi les erreurs ne s'affichent pas
    end
  end

  private

  def flat_params
    params.require(:flat).permit(:name, :description, :price_per_night, :address)
  end
end
