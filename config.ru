Bundler.require
require 'grape'
require 'sinatra'
require 'sinatra/asset_pipeline'

Dir[File.dirname(__FILE__) + '/api/*.rb'].each {|file| require file.gsub(".rb", "") }
require File.dirname(__FILE__) + '/capsule/main.rb'

class Web < Sinatra::Base
  register Sinatra::AssetPipeline
  
  get '/' do
    File.read('index.html')
  end
  
  get '/capsule.js' do
    content_type :js
    File.new('capsule/js/finch.min.js').readlines + File.new('capsule/js/main.js').readlines
  end
end

use Rack::Session::Cookie
run Rack::Cascade.new [App, Web, Collections]