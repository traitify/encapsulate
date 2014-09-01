Bundler.require
Dir["/api/*.rb"].each {|file| require file }

#Set Database
Spi.set_db({name: :book_project})

#Set Home Folder
Spi.set_home_folder(File.dirname(__FILE__))

run Spi.application
