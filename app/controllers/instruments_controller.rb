class InstrumentsController < ApplicationController
  def index
    instruments = InstrumentWanted.select(:id, :name)

    render json: instruments
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
