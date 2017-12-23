namespace :coinmarketcap do
  desc "Load newest prices"
  task get_pairs: :environment do
    url = 'https://api.coinmarketcap.com/v1/ticker/?start=0&limit=500'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    data.each do |entry|
      # Check only once per day
      checkup = Time.at(entry["last_updated"].to_i).to_date.beginning_of_day

      token = Token.where(ticker: entry["symbol"], name: entry["name"]).first_or_create
      stat = token.cmc_stats.where(created_at: checkup).first_or_create
      stat.update(
        rank: entry["rank"].to_i,
        price_usd: entry["price_usd"].to_f,
        price_btc: entry["price_btc"].to_f,
        market_cap_usd: entry["market_cap_usd"].to_f,
        daily_volume: entry["24h_volume_usd"].to_f,
        percent_change_1h: entry["percent_change_1h"].to_f,
        percent_change_24h: entry["percent_change_24h"].to_f,
        percent_change_7d: entry["percent_change_7d"].to_f
      )
    end
  end

end
