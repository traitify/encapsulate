Gem::Specification.new do |s|
  s.name        = 'spi'
  s.version     = '0.0.1'
  s.date        = '2014-08-12'
  s.summary     = "Spi Framework"
  s.description = "Spi Framework Gem"
  s.authors     = ["Carson Wright"]
  s.email       = 'carsonnwright@gmail.com'
  s.files       = Dir["lib/**/*"] + Dir["spi/**/*"] + Dir["boilerplate/**/*"] + ["Rakefile", "README.md"]
  s.require_paths = ["lib"]
  s.executables << 'spi'
  s.homepage    = 'localhost:3000'
  s.add_dependency "sinatra", ["= 1.4.5"]
  s.add_dependency "sinatra-asset-pipeline", ["= 0.4.0"]
  s.add_dependency "puma", ["= 2.9.0"]
  s.add_dependency 'bson_ext', ['= 1.10.2']
  s.add_dependency 'mongo', ['= 1.10.2']
  s.add_dependency 'i18n', ["= 0.6.11"]
  s.add_dependency 'json', ['= 1.8.1']
  s.add_dependency 'activesupport-inflector', ['= 0.1.0']
  
  s.add_dependency 'omniauth', ['= 1.2.2']
  s.add_dependency 'omniauth-oauth2', ['= 1.2.0']
  s.add_dependency 'omniauth-github', ['= 1.1.2']
  s.add_dependency 'omniauth-facebook', ['= 2.0.0']
  s.add_dependency 'omniauth-twitter', ['= 1.0.1']
  
  s.add_development_dependency 'pry', ['= 2.0.3']
  
  s.license     = 'MIT'
end
