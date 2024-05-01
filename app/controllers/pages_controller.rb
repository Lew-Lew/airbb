class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @flats = Flat.order(price_per_night: :desc).limit(4)
  end
end
