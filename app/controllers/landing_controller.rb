class LandingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:tweet]

  def index
  end

  def pair
    days_const = 30

    @token = Token.where(:ticker => params[:token].upcase).first
    raw_stats = @token.cmc_stats.order(created_at: :asc).where('created_at > ?', Time.now - days_const.days)
    pre_tw_stats = @token.tweet_stats.order(date: :asc).where('date > ?', Time.now - days_const.days)
    @tw_stats = []
    @stats_usd = []
    @stats_btc = []
    @stats_dates = []


    for d in 0..days_const
      tw = raw_stats.select{ |stat| stat.created_at.beginning_of_day < Time.now - d.days && stat.created_at.beginning_of_day > Time.now - (d+1).days }
      @stats_usd << tw.inject(0.0){ |sum, el| sum + el.price_usd }.to_f / tw.size
      @stats_btc << tw.inject(0.0){ |sum, el| sum + el.price_btc }.to_f / tw.size
      @stats_dates << (Time.now - d.days).to_date

      tw = pre_tw_stats.select{ |tw| tw.date < Time.now - d.days && tw.date > Time.now - (d+1).days  }.first

      if tw.present?
        @tw_stats << tw.count
      else
        @tw_stats << 0
      end
    end

    @tw_stats.reverse!
    @stats_usd.reverse!
    @stats_btc.reverse!
    @stats_dates.reverse!
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
