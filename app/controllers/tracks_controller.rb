class TracksController < ApplicationController
  def index
    @listings = MusicTrack.order(created_at: :desc).where(parent_id: nil)
  
    if params[:instrument].present?
      @listings = @listings.joins(:instruments).where("instruments.name LIKE ?", "%#{params[:instrument]}%")
      if params[:genre].present? 
        @listings = @listings.joins(:music_genres).where("music_genres.name LIKE ?", "%#{params[:genre]}%")
      end
    elsif params[:genre].present?
      @listings = @listings.joins(:music_genres).where("music_genres.name LIKE ?", "%#{params[:genre]}%")
    elsif params[:location].present?
      @listings = @listings.joins(:locations).where("locations.name LIKE ?", "%#{params[:location]}%")
    end

    @listings = @listings.select(:id)
    render json: @listings
  end  

  def index_results
    @parent_track = MusicTrack.find(params[:id])

    @children_tracks = @parent_track.children

    @children_tracks = @children_tracks.select(:id, :parent_id)
    render json: @children_tracks
  end

	def myTracks
    @listingss = MusicTrack.order(created_at: :desc).where(user_id: current_user.id, parent_id: nil)
    @listingss = @listingss.select(:id)

    render json: @listingss
	end

  def show
    @music_track = MusicTrack.find(params[:id])
		@music_genre_names = @music_track.music_genres.select(:id, :name)
    @instruments = @music_track.instruments.select(:id, :name)
    @author = @music_track.user.first_name
    @band_name = @music_track.band&.name || 'Krugh o marrons'
    @result = !@music_track.parent_id.nil?

    render json: {
      id: @music_track.id,
      title: @music_track.title,
      created_at: @music_track.created_at,
      updated_at: @music_track.updated_at,
      author: @author,
      music_genres: @music_genre_names,
      instruments: @instruments,
      band: @band_name,
      isResult: @result
    }
  end

  def new
    @music_track = MusicTrack.new
  end

  def create
    @music_track = MusicTrack.new(track_params)
		@music_track.user_id = current_user.id

    if @music_track.save
      render json: @music_track, status: :created
    else
      render json: @music_track.errors, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def track_params
		params.require(:music_track).permit(:title, :location_id, :band_id, :parent_id, instrument_ids: [], music_genre_ids: [])
	end
end
