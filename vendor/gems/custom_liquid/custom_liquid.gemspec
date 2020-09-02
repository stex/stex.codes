require_relative 'lib/custom_liquid/version'

Gem::Specification.new do |spec|
  spec.name          = "custom_liquid"
  spec.version       = CustomLiquid::VERSION
  spec.authors       = ["Stefan Exner"]
  spec.email         = ["stex@sterex.de"]

  spec.summary       = "Custom liquid tags for stex.codes"
  spec.description   = spec.summary
  spec.homepage      = "https://stex.codes"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = []
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
