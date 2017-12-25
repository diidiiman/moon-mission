class LandingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:tweet]

  def index
  end

  def pair
    @token = Token.where(:ticker => params[:token].upcase).first
    @stats = @token.cmc_stats.order(created_at: :asc)
  end


  def tweet
    @token = Token.where(ticker: params[:ticker].upcase).first
    @tweet = Tweet.new(tweet_params)
    @tweet.token_id = @token.id
    @tweet.save
  end


  private

  def tweet_params
    params.permit(
      :tweet, :keywords
    )
  end
end
