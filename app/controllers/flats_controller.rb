class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @flats = Flat.all
    if params[:query].present?
      @flats = @flats.where("name LIKE ? OR address LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end

    if params[:guest].present?
      @flats = @flats.where("guest >= ?", params[:guest])
    end

    if params[:sort].present?
      case params[:sort]
      when 'price_asc'
        @flats = @flats.order(price_per_night: :asc)
      when 'price_desc'
        @flats = @flats.order(price_per_night: :desc)
      when 'guests_asc'
        @flats = @flats.order(guest: :asc)
      when 'guests_desc'
        @flats = @flats.order(guest: :desc)
      end
    end


    # The `geocoded` scope filters only flats with coordinates
    @markers = @flats.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
    end 

    # This is to respond to the AJAX request
    respond_to do |format|
      # Follow regular flow of Rails if the request is HTML
      format.html 
      # This will render the partial `flats/list.html.erb` with the locals `flats` and `formats` as `html` if the request is JS (AJAX)
      format.text { render partial: 'flats/list', locals: { flats: @flats },  formats: :html }
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
