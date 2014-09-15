class Collections < Sinatra::Base
  before do
    content_type 'application/json'
  end
  
  before "/api/collections/:resource" do
    unless current_user
      pass
    end
  end
  
  post "/api/collections/:resource" do
    resource = params[resource_name.singularize].to_hash
    resource["userId"] = current_user["_id"]
    resourceId = current_resource.insert(resource)
    json = process_json current_resource.find("_id" => resourceId).to_a.first
    Spi.faye_client.publish("/#{params[:resource]}", 'json' => json )
  	json
  end

  get "/api/collections/:resource" do
    resource_array = Array.new
    
    current_resource.find({userId: current_user["_id"]}).to_a.each do |resource|
      resource_array.push(fix_id(resource))
    end
    
    resource_array.to_json
  end

  get "/api/collections/:resource/:id" do
    oid = BSON::ObjectId.from_string(params[:id])
    resource_array = Array.new
    
    process_json current_resource.find({userId: current_user["_id"], "_id" => oid}).to_a.first
  end
  
  delete "/api/collections/:resource/:id" do
    oid = BSON::ObjectId.from_string(params[:id])
    json = process_json current_resource.remove({userId: current_user["_id"], "_id" => oid})
    Spi.faye_client.publish("/#{params[:resource]}", 'json' => json )
  	json
  end

  put "/api/collections/:resource/:id" do
    oid = BSON::ObjectId.from_string(params[:id])
    resource = params[resource_name.singularize].to_hash
    json = process_json current_resource.update({"userId" => current_user["_id"], "_id" => oid}, {"$set" => resource})
    Spi.faye_client.publish("/#{params[:resource]}", 'json' => json )
  	json
  end

  def pass
    halt [ 401, {error: "Not Found"}.to_json ]
  end

  def resource_name
    params[:resource]
  end
  
  def current_resource  
    Spi.db[resource_name]
  end
  
  def fix_id(local_object)
    local_object["_id"] = local_object["_id"].to_s
    local_object
  end
  def process_json(local_object)
    fix_id(local_object).to_json
  end
  
  def current_user
    Spi.db["users"].find(_id: session[:user_id]).to_a.first
  end
end