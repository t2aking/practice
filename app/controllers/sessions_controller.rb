require 'net/http'
require 'uri'

class SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    @session = Session.new(user_id: session_params[:user_id], password: session_params[:password])
    if @session.valid? &&
      if (@user = User.find_by(user_id: session_params[:user_id])) && @user.authenticate(session_params[:password])
        login @user
        redirect_to root_url
      else
        @session.errors.add(:base, "ユーザーIDまたはパスワードに誤りがあります。")
        render :new,  status: :unprocessable_entity
      end
    else
      render :new,  status: :unprocessable_entity
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_url
  end

  def callback
    data = {
      code: params[:code],
      client_id: 'UqVzVstuP0OwobC9zM3QGzmN7_MvfW30qEabZodUSPY',
      client_secret: 'mCIO-62AyxhCDsDWlY5Ad-Xl-rDwIyGsiyaS_LBtk3c',
      redirect_uri: 'http://localhost:3000/oauth/callback',
      grant_type: 'authorization_code'
    }
    query = data.to_query
    uri = URI("http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/oauth/token?" + query)
    http = Net::HTTP::new(uri.host, uri.port)
    http.use_ssl = false
    req = Net::HTTP::Post.new(uri)
    req = http.request(req)
    token = JSON.parse(req.body)
    session[:access_token] = token[:access_token]
    redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit(:user_id, :password)
  end
end
