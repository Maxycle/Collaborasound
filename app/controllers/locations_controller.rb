class LocationsController < ApplicationController
  def index
      locations = Location.select(:id, :name)

      render json: locations
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
