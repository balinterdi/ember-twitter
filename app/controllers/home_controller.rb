class HomeController < ApplicationController
  respond_to :json, :html

  def index
    respond_to do |format|
      format.html
      format.json do
        cached_home_timeline = cache(cache_key) { home_timeline }
        respond_with cached_home_timeline
      end
    end
  end

private
  def home_timeline
    logger.info "TWITTER/HOME_TIMELINE"
    twitter_client.home_timeline
  end

end

