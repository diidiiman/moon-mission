namespace :twitter do
  desc "Load 7 day mentions for all tickers"
  task get_tweets: :environment do


    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "0u02DsvTvlrGgPfhC6ntp3Ph7"
      config.consumer_secret     = "9QRxKPIJTazlk4ZlZcr7jN0OlmrFd8vhcIzKaSQF5tguXxvDq9"
      config.access_token        = "3331697303-jpRmadgvPoZ5l3mDlnBtq1Upbm4FuLvYOS8poad"
      config.access_token_secret = "BW1EiBtW8u071C6oKLMtq1jFAUXYDg8s6JF6f8abcoqGd"
    end

    tweets = []
    client.search("$btx",
      result_type: "recent"
    ).take(10).collect do |tweet|
      tweets << tweet
    end

    ap tweets

    # url = 'https://api.coinmarketcap.com/v1/ticker/?start=0&limit=500'
    # uri = URI(url)
    # response = Net::HTTP.get(uri)
    # data = JSON.parse(response)
    # data.each do |entry|
    #   # ...
    # end
  end
end
