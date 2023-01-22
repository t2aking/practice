module SessionsHelper
  def login(user)
    session[:user_key] = user.id
  end

  def current_user
    if session[:user_key]
      @current_user ||= User.find_by(id: session[:user_key])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def logout
    session.delete(:user_key)
    @current_user = nil
  end

  def auth_tweet_app?
    session.has_key?('access_token')
  end
end
