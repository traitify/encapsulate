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
  
  def self.home_folder
    Dir.pwd
  end
  
  def self.faye_client
    @@faye_client ||= Faye::Client.new('http://localhost:9292/faye')
  end
  
  def self.set_db
    client = MongoClient.new

    db_name = ENV["DB_NAME"] || Spi.load_configuration("database")["name"]

    @@db = client[db_name]
  end
  
  def self.db
    @@db
  end

  def self.load_collection(file)
    if File.exist?(home_folder + "/collections/" + file + ".yml")
      YAML.load_file(home_folder + "/collections/" + file + ".yml")
    else
      Hash.new
    end
  end
  
  def self.load_configuration(file)
    if File.exist?(home_folder + "/config/" + file + ".yml")
      YAML.load_file(home_folder + "/config/" + file + ".yml")
    else
      Hash.new
    end
  end
  
  def self.omni_auth_config(type)
    configuration = self.load_configuration(type)
    configuration[:id] ||= nil
    configuration[:secret] ||= nil
      
    configuration
  end
  
  def self.start
    Dir["/api/*.rb"].each {|file| require file }
    self.set_db
  end
end