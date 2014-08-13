Gem::Specification.new do |s|
  s.name        = 'capsule'
  s.version     = '0.0.0'
  s.date        = '2014-08-12'
  s.summary     = "Capsule Framework"
  s.description = "Capsule Framework Gem"
  s.authors     = ["Carson Wright"]
  s.email       = 'carsonnwright@gmail.com'
  s.files       = ["api"]
  s.files       = Dir["capsule/**/*"] + Dir["config.ru"] + ["index.html", "README.md"]
  s.homepage    = 'localhost:3000'
  s.license     = 'MIT'
end