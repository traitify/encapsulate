require 'bundler'
Bundler.require

#######################
# REQUIRE SINATRA
#######################
require 'sinatra'
require 'sinatra/asset_pipeline'

#######################
# REQUIRE SOCIAL AUTH
#######################
require 'omniauth'
require 'omniauth-github'
require 'omniauth-facebook'
require 'omniauth-twitter'

#######################
# SUPPORTING FILES
#######################
require 'yaml'

##################################
# REQUIRE MONGO JSON INFLECTOR
##################################
require 'mongo'
require 'json'
require 'active_support/inflector'

#################################
# REQUIRE BASE AND COLLECTIONS
#################################
require_relative 'collections'

###############################
# REQUIRE MAIN LIB
###############################
require_relative 'base'

###############################
# REQUIRE MAIN LIB
###############################
require_relative 'auths/fb'
require_relative 'auths/twitter'

###############################
# REQUIRE MAIN LIB
###############################
require_relative 'web'

###############################
# REQUIRE API FILES
###############################
Dir[File.dirname(Spi.home_folder) + '/api/*.rb'].each do |file| 
  require file.gsub(".rb", "")
end