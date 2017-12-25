#!/usr/bin/env python

import pymysql.cursors
import tweepy
import requests
from time import gmtime, strftime
from urllib.parse import urlencode
import json
import sys
import pprint

pp = pprint.PrettyPrinter(indent=4)

# Tickers to filter tweets by
check_for_tickers = [
  'UBQ', 'CTR', 'TNB', 'ADX',
  'DATA', 'PPP', 'SNM', 'GRS'
]
ticker_array = []
for a in check_for_tickers:
  ticker_array.append('$'+a)

moonMissionUrl = 'http://localhost:3000/tweet'

# @d3 pls don't :D
consumer_key = "YHiyxEZi7GkRBHazOZSThi1AP"
consumer_secret = "GA1xfpKc6u0nGwjPSEJXbdKcItNdyjxp7kB3zSnJ5J4tBunSsA"
access_token = "109958390-joMxnLnwqpvE1DBP4FTUtkHfYD55gajgRaYws3Gv"
access_token_secret = "2dwfhGZGpAStdIYePrBB8Mj7UQuazyJyMpVdcEC2P17PS"

# Keyword to search for
# keyword = '$btc'
ticker = 'ubq'

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)


def store_tweet(text, symbol):
  data = {
    "tweet": text,
    "keywords": symbol.lower(),
    "ticker": symbol.lower()
  }

  r = requests.post(moonMissionUrl, data);



#override tweepy.StreamListener to add logic to on_status
class MyStreamListener(tweepy.StreamListener):
  def on_status(self, status):
    # pp.pprint(status)
    for symbol in status.entities['symbols']:
      if symbol['text'].upper() in check_for_tickers:
        print(symbol['text'])
        print("_______________________________________________________")
        store_tweet(status.text, symbol['text'])


myStreamListener = MyStreamListener()

def start_streaming():
  try:
    myStream = tweepy.Stream(auth = api.auth, listener=myStreamListener)
    myStream.filter(track=ticker_array)
  except:
    # Trying to restart script on failure
    print("restarting")
    os.execv('/Users/eduards/projects/moon-mission/twitter-streamer.py')

start_streaming()