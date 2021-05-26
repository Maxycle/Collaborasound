class ListingsController < ApplicationController

  def index

    @listings = Listing.all.sort_by { |listing| listing.created_at }.reverse!

    if params[:instrument].present?
      @listings = Listing.where("instrument ILIKE? ", "%#{params[:instrument]}%")
      if params[:style].present? 
        @listings = @listings.where("style ILIKE? ", "%#{params[:style]}%")
        if params[:location].present?
            @listings = @listings.where("location ILIKE? ", "%#{params[:location]}%")
            if params[:band].present?
              @listings = @listings.where("band ILIKE? ", "%#{params[:band]}%")
            end
        end
      end
    elsif params[:style].present?
      @listings = Listing.where("style ILIKE? ", "%#{params[:style]}%")
        if params[:location].present?
            @listings = @listings.where("location ILIKE? ", "%#{params[:location]}%")
            if params[:band].present?
              @listings = @listings.where("band ILIKE? ", "%#{params[:band]}%")
            end
        end
      elsif if params[:location].present?
        @listings = Listing.where("location ILIKE? ", "%#{params[:location]}%")
          if params[:band].present?
            @listings = @listings.where("band ILIKE? ", "%#{params[:band]}%")
          end
        elsif params[:band].present?
          @listings = Listing.where("band ILIKE? ", "%#{params[:band]}%")
        end
    end
  end 

  def show
    @listing = Listing.find(params[:id])
  end

  def new
    @listing = Listing.new
  end
 
  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    # @listing.user.first_name = current_user.first_name
    if @listing.save
      redirect_to listings_path
    else
      flash.alert = "Please check your form for any errors and try again."
      render :new
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:style, :instrument, :band, :location)
  end
end