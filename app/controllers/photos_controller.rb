require 'net/http'
require 'uri'
require 'json'

class PhotosController < ApplicationController
  before_action :logged_in_user
  def index
    @photos = Photo.where(user_id: current_user.id).order(updated_at: :desc)
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.create(photo_params)
    @photo.user_id = current_user.id
    if @photo.save
      redirect_to root_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def tweet
    @photo = Photo.find_by(id: params[:photo_id])
    content = {
      'text' => @photo.title,
      'url' => url_for(@photo.image)
    }
    uri = URI.parse("http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/api/tweets")
    http = Net::HTTP::new(uri.host, uri.port)
    http.use_ssl = false
    req = Net::HTTP::Post.new(uri.path)
    req['Content-Type'] = 'application/json'
    req['Authorization'] = 'Bearer ' + session[:access_token]
    req.body = content.to_json
    res = http.request(req)
    case res
    when Net::HTTPCreated
      redirect_to root_url
    else
      raise 'ツイートに失敗しました。'
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :image)
  end
end
