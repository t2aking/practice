Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'photos#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/oauth/callback', to: 'sessions#callback'
  resource :photo, only: [:new, :create]
  post '/', to: 'photos#tweet'
  direct :oauth do |options|
    uri = URI.parse("http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/oauth/authorize")
    uri.query = options.to_param unless options.empty?
    uri.to_s
  end
end
