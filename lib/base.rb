class Spi
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
    Rack::Cascade.new [Web, Collections]
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
  
  def self.omni_auth_config(type)
    if File.exist?(home_folder + "/config/" + type + ".yml")
      YAML.load_file(home_folder + "/config/" + type + ".yml")
    else
      {id: nil, secret: nil}
    end
  end
end