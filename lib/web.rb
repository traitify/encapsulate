class Web < Sinatra::Base
  use Rack::Session::Pool
  use Faye::RackAdapter, :mount => '/faye', :timeout => 25
  set :session_secret, ENV['SESSION_SECRET'] || Spi.load_collection('app')["session_secret"]
  register Sinatra::AssetPipeline

  use OmniAuth::Builder do
    github = Spi.omni_auth_config("github")
    github_id = ENV["GITHUB_ID"] || github["id"]
    github_secret = ENV["GITHUB_SECRET"] || github["secret"]
    
    facebook = Spi.omni_auth_config("facebook")
    facebook_id = ENV["FACEBOOK_ID"] || facebook["id"]
    facebook_secret = ENV["FACEBOOK_SECRET"] || facebook["secret"]
    
    twitter = Spi.omni_auth_config("twitter")
    twitter_id = ENV["TWITTER_ID"] || twitter["id"]
    twitter_secret = ENV["TWITTER_SECRET"] || twitter["secret"]
    
    provider :facebook, facebook_id, facebook_secret
    provider :github, github_id, github_secret
    provider :twitter, twitter_id, twitter_secret
  end
  
  get '/spi.js' do
    content_type :js
    if current_user
      user = current_user
      user["_id"] = user["_id"].to_s
      current_user_json = user.to_json
    else
      current_user_json = {}.to_json
    end
    
    Spi.file('/spi/js/finch.min.js') + Spi.file('/spi/js/main.js') + ["\n"] + ["currentUser = #{current_user_json};"]
  end

  get '/' do
    send_file File.join(settings.public_folder, 'index.html')
  end
  
  get '/pages/:page' do
    send_file File.join(settings.public_folder, "pages/#{params[:page]}.html")
  end
 
  get '/auth/:provider/callback' do
    
    case params[:provider]
    when "facebook"
      user = FBAuth.store(request.env['omniauth.auth'])
    when "twitter"
      user = TwitterAuth.store(request.env['omniauth.auth'])
    end
    if user
      session[:user_id] = user["_id"]
    end
    redirect "/"
  end
  
  get '/me' do
    content_type :json

    current_user.to_json
  end

  get '/friends' do
    content_type :json

    current_user.friends.to_json
  end
  

  def current_user
    user = Spi.db["users"].find(_id: session[:user_id]).to_a.first
    user["friends"] = Array.new
  end
  set :public_folder, 'public'
end