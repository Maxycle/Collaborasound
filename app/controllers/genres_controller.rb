class GenresController < ApplicationController
  def index
    genres = MusicGenre.select(:id, :name)

    render json: genres
  end

  def show
  end

  def new
    @genre = MusicGenre.new
  end

  def create
    @genre = MusicGenre.new(instrument_params)
    
    if @genre.save
      render json: @genre, status: :created
    else
      render json: @genre.errors, status: :unprocessable_entity
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
    params.require(:genre).permit(:name) # Permit only the 'name' parameter
  end
end
