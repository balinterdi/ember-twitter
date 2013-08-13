Twitter.configure do |config|
  config.consumer_key = ENV['EMBER_TWITTER_CONSUMER_KEY']
  config.consumer_secret = ENV['EMBER_TWITTER_CONSUMER_SECRET']
end
