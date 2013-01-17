# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'numbers_in_words/version'

Gem::Specification.new do |gem|
  gem.name          = "numbers_in_words"
  gem.description   = "#in_words method for integers and #in_numbers for strings"
  gem.summary       = "Example: 123.in_words # => \"one hundred and twenty three\", \"seventy-five point eight\".in_numbers # = > 75.8"

  gem.version       = NumbersInWords::VERSION
  gem.authors       = ["Mark Burns"]
  gem.email         = ["markthedeveloper@gmail.com"]
  gem.homepage      = "http://github.com/markburns/numbers_in_words"

  gem.add_dependency      "activesupport"
  gem.add_development_dependency      "rspec"
  gem.add_development_dependency      "debugger"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
