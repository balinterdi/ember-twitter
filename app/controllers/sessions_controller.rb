class SessionsController < ApplicationController
  skip_before_filter :authenticate_with_twitter

  def new
  end

  def create
    user = update_user
    session[:current_user_id] = user.id
    redirect_to root_path
  end

private

  def update_user
    user = User.first(conditions: { nickname: auth_hash.info.nickname })
    unless user
      user = User.new
    end
    user.update_attributes(user_attributes)
    user
  end

  def user_attributes
    info = auth_hash.info
    creds = auth_hash.credentials
    {
      oauth_token: creds.token,
      oauth_token_secret: creds.secret,
      nickname: info.nickname,
      name: info.name,
      avatar_url: info.image,
      location: info.location,
      website: info.urls.Website,
      description: info.description
    }
  end

  def auth_hash
    request.env['omniauth.auth']
  end


end
