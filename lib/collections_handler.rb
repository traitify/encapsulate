class CollectionsHandler
  attr_accessor :resource, :request, :collection_config, :current_user

  def initialize(options)
    self.resource = options[:params][:resource]
    self.request = options[:request]
    self.current_user = options[:current_user]
  end
  
  def is_accessable?  
    self.collection_config = Spi.load_collection(resource)
    if !resource.empty? && collection_config["public"] && check_verb(request.request_method)
      true
    else
      false
    end
  end
  
  def check_verb(method)
    if (collection_config["public"] && method == "GET" ) || (collection_config["public"] && method == collection_config[method])
      true
    else
      false
    end
  end
end