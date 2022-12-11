$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "araa/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "ARAA"
  spec.version     = Araa::VERSION
  spec.authors     = ["John Turknett"]
  spec.email       = ["johnturknett@gmail.com"]
  spec.homepage    = "http://www.johnturknett.com/ruby/gems/araa"
  spec.summary     = "ActiveRecord Auto Associate"
  spec.description = "Automatically build ActiveRecord relations for models based on Rails conventions"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir[
    "{araa,config,db,lib}/**/*",
    "MIT-LICENSE",
    "Rakefile",
    "README.md"
  ]

  spec.add_dependency "rails", "~> 7.0.0"

  spec.add_development_dependency "sqlite3"
end
