class ResultsController < ApplicationController
  before_action :set_listing
  
    def index
      @results = @listing.results
    end

    def new
      @result = Result.new
    end
     
    def create
      @result = Result.new(result_params)
      @result.user = current_user
      @result.listing = @listing
      if @result.save
        # redirect_to listing_path
        redirect_to listing_results_path
      else
        flash.alert = "Please check your form for any errors and try again."
        render :new
      end
    end

    private

    def result_params
      params.require(:result).permit(:comment, :result_song)
    end

    def set_listing
      @listing = Listing.find(params[:listing_id])
    end
end