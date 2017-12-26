class Token < ApplicationRecord
  has_many :cmc_stats
  has_many :day_tweets
  has_many :tweet_stats
end
