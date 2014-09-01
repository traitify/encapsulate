class Collections < Sinatra::Base
  before do
    content_type 'application/json'
  end
  
  post "/api/collections/:resource" do
    resource_name = params[:resource]
    Spi.db[resource_name].insert(params[resource_name.singularize].to_hash)
  end

  get "/api/collections/:resource" do
    resource_name = params[:resource]
    Spi.db[resource_name].find().to_a.to_json
  end

  delete "/api/collections/:resource" do
    {
      "#{params[:resource]}" =>{
        deleted: "here"
      }
    }
  end

  put "/api/collections/:resource" do
    {
      "#{params[:resource]}" =>{
        puted: "here"
      }
    }
  end
end