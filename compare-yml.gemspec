
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'compare/version'

Gem::Specification.new do |spec|
  spec.name          = 'compare-yml'
  spec.version       = Compare::VERSION
  spec.authors       = ['Sony Mathew']
  spec.email         = ['sony.mathew.pm@gmail.com']

  spec.summary       = %q{Compare two yml files to find out the differences in keys of both.}
  spec.description   = %q{In case of I18n files or other configuration files which could be usually in yml or json format, you might need to compare the keys of two files and find out the missing ones. This gem is for those occasions, especially when you are working with translation files. This can work with both json and yml files.}
  spec.homepage      = "https://sony-mathew.github.io/compare-yml.html"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    # spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = "https://github.com/sony-mathew/compare-yml"
    spec.metadata['changelog_uri'] = "https://github.com/sony-mathew/compare-yml/blob/master/CHANGELOG.md"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = 'compare_yml'
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
