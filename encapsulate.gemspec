Gem::Specification.new do |s|
  s.name        = 'encapsulate'
  s.version     = '0.0.1'
  s.date        = '2014-08-12'
  s.summary     = "Capsule Framework"
  s.description = "Capsule Framework Gem"
  s.authors     = ["Carson Wright"]
  s.email       = 'carsonnwright@gmail.com'
  s.files       = Dir["lib/**/*"] + Dir["encapsulate/**/*"] + ["Rakefile", "index.html", "README.md"]
  s.require_paths = ["lib"]
  s.homepage    = 'localhost:3000'
  s.add_dependency "grape", ["= 0.8.0"]
  s.add_dependency "sinatra", ["= 1.4.5"]
  s.add_dependency "sinatra-asset-pipeline", ["= 0.4.0"]
  s.add_dependency "puma", ["= 2.9.0"]
  s.add_dependency 'mongo', ['= 1.10.2']
  s.add_dependency 'bson_ext', ['= 1.10.2']
  s.add_dependency 'linguistics'

  s.license     = 'MIT'
end