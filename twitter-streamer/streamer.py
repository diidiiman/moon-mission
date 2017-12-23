import tweepy

# @d3 pls don't :D
consumer_key = "YHiyxEZi7GkRBHazOZSThi1AP"
consumer_secret = "GA1xfpKc6u0nGwjPSEJXbdKcItNdyjxp7kB3zSnJ5J4tBunSsA"
access_token = "109958390-joMxnLnwqpvE1DBP4FTUtkHfYD55gajgRaYws3Gv"
access_token_secret = "2dwfhGZGpAStdIYePrBB8Mj7UQuazyJyMpVdcEC2P17PS"

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)

public_tweets = api.home_timeline()
for tweet in public_tweets:
  print(tweet.text)