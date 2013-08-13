Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['EMBER_TWITTER_CONSUMER_KEY'], ENV['EMBER_TWITTER_CONSUMER_SECRET']
end

