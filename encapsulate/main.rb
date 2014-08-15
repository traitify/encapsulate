class Collections < Grape::API
  resource :api do
    format :json
    
    post "/collections/:resource" do
      resource_name = params[:resource]
      Encapsulate.db[resource_name].insert(params[resource_name.singularize].to_hash)
    end
    
    get "/collections/:resource" do
      resource_name = params[:resource]
      Encapsulate.db[resource_name].find().to_a
    end
    
    delete "/collections/:resource" do
      {
        "#{params[:resource]}" =>{
          deleted: "here"
        }
      }
    end
    
    put "/collections/:resource" do
      {
        "#{params[:resource]}" =>{
          puted: "here"
        }
      }
    end
  end
end