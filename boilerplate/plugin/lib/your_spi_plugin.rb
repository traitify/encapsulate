require "your_spi_plugin/version"
require "sinatra"

class Web < Sinatra::Base
  get "/your_spi_plugin" do
    "Here I am"
  end
end
