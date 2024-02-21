class InstrumentsController < ApplicationController
  def index
    instruments = InstrumentWanted.select(:id, :name)

    render json: instruments
  end

  def show
  end

  def new
    @instrument = InstrumentWanted.new
  end

  def create
    @instrument = InstrumentWanted.new(instrument_params)
    
    if @instrument.save
      render json: @instrument, status: :created
    else
      render json: @instrument.errors, status: :unprocessable_entity
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
    params.require(:instrument).permit(:name) # Permit only the 'name' parameter
  end
end
