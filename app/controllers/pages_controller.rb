class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :about, :new ]

  def home
  end

  def about
  end
end
