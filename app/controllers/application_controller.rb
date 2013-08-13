class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  #TODO: For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :oauth_token

  before_filter :authenticate_with_twitter

private

  def authenticate_with_twitter
    unless oauth_token
      redirect_to new_session_path
    end
  end

  def twitter_client
    Twitter::Client.new(
      oauth_token: current_user.oauth_token,
      oauth_token_secret: current_user.oauth_token_secret
    )
  end

  def current_user
    if session[:current_user_id]
      User.find(session[:current_user_id])
    end
  end

  def oauth_token
    current_user.try(:oauth_token)
  end

  def cache_key(*fragments)
    common_fragments = [oauth_token, params[:controller], params[:action]]
    logger.info "Cache key: #{fragments.concat(common_fragments)}"
    fragments.concat(common_fragments)
  end

end
