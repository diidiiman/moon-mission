class LandingController < ApplicationController
  def index
  end

  def pair
    @token = Token.where(:ticker => params[:token].upcase).first
    @stats = @token.cmc_stats.order(created_at: :desc).limit(10)
  end
end
