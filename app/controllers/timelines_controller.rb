class TimelinesController < ApplicationController
  respond_to :json

  def show
    cached_user_timeline = cache(cache_key(params[:id])) do
      logger.info "TWITTER/USER_TIMELINE"
      user_timeline(params[:id])
    end
    respond_with cached_user_timeline
  end

private
  def user_timeline(screen_name)
    twitter_client.user_timeline(screen_name)
  end
end

