class Web < Sinatra::Base
  use Rack::Session::Pool
  set :session_secret, 'your secret'
  register Sinatra::AssetPipeline

  use OmniAuth::Builder do
    github = Spi.omni_auth_config("github")
    github_id = ENV["github_id"] || github["id"]
    github_secret = ENV["github_secret"] || github["secret"]
    
    facebook = Spi.omni_auth_config("facebook")
    facebook_id = ENV["facebook_id"] || facebook["id"]
    facebook_secret = ENV["facebook_secret"] || facebook["secret"]
    
    twitter = Spi.omni_auth_config("twitter")
    twitter_id = ENV["twitter_id"] || twitter["id"]
    twitter_secret = ENV["twitter_secret"] || twitter["secret"]
    
    provider :facebook, facebook_id, facebook_secret
    provider :github, github_id, github_secret
    provider :twitter, twitter_id, twitter_secret
  end
  
  get '/spi.js' do
    content_type :js
    Spi.file('/spi/js/finch.min.js') + Spi.file('/spi/js/main.js')
  end

  get '/' do
    send_file File.join(settings.public_folder, 'index.html')
  end
 
  get '/auth/:provider/callback' do
    
    case params[:provider]
    when "facebook"
      user = FBAuth.store(request.env['omniauth.auth'])
    when "twitter"
      user = TwitterAuth.store(request.env['omniauth.auth'])
    end
    
    session[:user_id] = user["_id"]
    redirect "/"
  end
  
  get '/me' do
    Spi.db["users"].find(_id: session[:user_id]).to_a.first.to_json
  end
  
  set :public_folder, 'public'
end