class LocationsController < ApplicationController
  def index
      locations = Location.select(:id, :name)

      render json: locations
  end

  def show
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(instrument_params)
    
    if @location.save
      render json: @location, status: :created
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def instrument_params
    params.require(:location).permit(:name) # Permit only the 'name' parameter
  end
end