namespace :twitter do
  desc "Load 7 day mentions for all tickers"
  task get_tweets: :environment do

    # Set credentials for the request
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "0u02DsvTvlrGgPfhC6ntp3Ph7"
      config.consumer_secret     = "9QRxKPIJTazlk4ZlZcr7jN0OlmrFd8vhcIzKaSQF5tguXxvDq9"
      config.access_token        = "3331697303-jpRmadgvPoZ5l3mDlnBtq1Upbm4FuLvYOS8poad"
      config.access_token_secret = "BW1EiBtW8u071C6oKLMtq1jFAUXYDg8s6JF6f8abcoqGd"
    end

    # Get most recent available tweets
    Token.all.each do |token|
      ap "#{token.id}: Getting stats for #{token.name}"

      symbol = "$"+token.ticker.downcase
      # Get the most recent ID for the tweets
      recent_tw = token.day_tweets.last

      # Skip checkup if the most recent tweet is less than 4h old
      if recent_tw.present? and recent_tw.created_at > Time.now-4.hours
        ap "Skipping this token, since we have quite recent information"
        next
      end

      if recent_tw.nil?
        oldest_id = 0
      else
        oldest_id = recent_tw.tw_id
      end

      begin
        # Get new collection of tweets
        client.search(symbol,
          result_type: "recent",
          since_id: oldest_id
        ).take(10000).collect do |tweet|
          existing = token.day_tweets.where(tw_id: tweet.id).first
          # If tweet does not exist then increase the daily mentions number
          if existing.nil?
            token.day_tweets.create(tw_id: tweet.id, created_at: tweet.created_at)
            day_stats = token.tweet_stats.where(date: tweet.created_at.beginning_of_day).first_or_create
            day_stats.update(count: day_stats.count + 1)
          end
        end

        # Rate limit - 20 requests per minute max
        sleep(15)
      rescue => e
        ap "#{token.name} query was not completed - #{e.message}"
        e.inspect
        sleep(15)
      end
    end
  end
end
