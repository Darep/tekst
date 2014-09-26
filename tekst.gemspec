# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tekst/version'

Gem::Specification.new do |spec|
  spec.name          = "tekst"
  spec.version       = Tekst::VERSION
  spec.authors       = ['Antti-Jussi Kovalainen']
  spec.email         = ['ajk@ajk.fi']
  spec.summary       = %q{Ruby gem for common HTML and text operations.}
  spec.homepage      = "http://github.com/Darep/tekst"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"

  # Syntax hilighting
  spec.add_runtime_dependency 'coderay', '1.1.0'

  # Truncate HTML strings http://rubygems.org/gems/html_truncator
  spec.add_runtime_dependency 'html_truncator', '0.4.0'

  # Auto link URLs in text
  spec.add_runtime_dependency 'rinku', '1.7.3'

  # Strip HTML tags and such
  spec.add_runtime_dependency 'sanitize', '3.0.2'

  # Beautify text with smart quotes and such
  spec.add_runtime_dependency 'typogruby', '1.0.16'
end
