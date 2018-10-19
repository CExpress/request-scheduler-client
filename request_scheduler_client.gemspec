
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "request_scheduler_client/version"

Gem::Specification.new do |spec|
  spec.name          = "request_scheduler_client"
  spec.version       = RequestSchedulerClient::VERSION
  spec.authors       = ["Pedro F Steimbruch"]
  spec.email         = ["pedrofsteimbruch@gmail.com"]

  spec.summary       = %q{It provides a generic method to log every request and post them to a datasource of choice.}
  spec.homepage      = "https://www.github.com/pedrofs/request_scheduler_client"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.add_dependency "webmock", "~> 3.4"
  spec.add_dependency "httparty"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "httparty"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency 'sendgrid-ruby'
  spec.add_development_dependency 'webmock', '~> 3.4'
end

