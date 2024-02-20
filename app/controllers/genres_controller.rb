class GenresController < ApplicationController
  def index
    genres = MusicGenre.select(:id, :name)

    render json: genres
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
