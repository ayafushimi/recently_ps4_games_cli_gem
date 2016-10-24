# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'recently_ps4_games_cli_gem/version'

Gem::Specification.new do |spec|
  spec.name          = "recently_ps4_games_cli_gem"
  spec.version       = RecentlyPs4GamesCliGem::VERSION
  spec.authors       = ["ayafushimi"]
  spec.email         = ["aya.fushimi@gmail.com"]

  spec.summary       = %q{Recently PS4 Games}
  spec.description   = %q{With this gem, you can see the lists of new and upcoming PS4 games and inquire the details in CLI.}
  spec.homepage      = "https://github.com/ayafushimi/recently_ps4_games_cli_gem"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
