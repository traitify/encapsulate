Bundler.require
require 'grape'
require 'sinatra'
require 'sinatra/asset_pipeline'
require 'mongo'
require 'linguistics'

Linguistics.use(:en)

class Encapsulate
  include Mongo
  @@home_folder = ""
  def self.file(filename)
    local_path = File.expand_path("..", File.dirname(__FILE__))
    project_path = File.expand_path(self.home_folder)
    
    file_contents = nil
    full_file_name = project_path + filename
    if File.file?(full_file_name)
      file_contents = File.new(full_file_name).readlines
    elsif File.file?(local_path + filename)
      full_file_name = local_path + filename
      file_contents = File.new(full_file_name).readlines
    end
    
    file_contents
  end
  
  def self.application
    Rack::Cascade.new [App, Web, Collections]
  end
  
  def self.set_home_folder(home)
    @@home_folder = home
  end
  
  def self.home_folder
    @@home_folder
  end
  
  def self.set_db(options)
    client = MongoClient.new
    db_name = "example project" || options[:name]
    @@db = client['example-db'] 
  end
  
  def self.db
    @@db
  end
end

class App < Grape::API
end

Dir[File.dirname(Encapsulate.home_folder) + '/api/*.rb'].each do |file| 
  require file.gsub(".rb", "")
end
require_relative('../encapsulate/main.rb')

class Web < Sinatra::Base
  register Sinatra::AssetPipeline
  
  get '/' do
    Encapsulate.file('/index.html')
  end
  
  get '/encapsulate.js' do
    content_type :js
    Encapsulate.file('/encapsulate/js/finch.min.js') + Encapsulate.file('/encapsulate/js/main.js')
  end

  get '/pages/:page' do
    content_type :html
    Encapsulate.file('/pages/' + params[:page])
  end
end



use Rack::Session::Cookie