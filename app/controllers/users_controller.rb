class UsersController < ApplicationController
    def dashboard
        @listings = current_user.listings
    end
end
