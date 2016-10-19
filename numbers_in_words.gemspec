# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'numbers_in_words/version'

Gem::Specification.new do |gem|
  gem.name          = "numbers_in_words"
  gem.description   = "convert written numbers into Integers and vice-versa"
  gem.summary       = "Example: NumbersInWords.in_words(123) # => \"one hundred and twenty three\", NumbersInWords.in_numbers(\"seventy-five point eight\") # = > 75.8"

  gem.version       = NumbersInWords::VERSION
  gem.authors       = ["Mark Burns", "Dimid Duchovny"]
  gem.email         = ["markthedeveloper@gmail.com", "dimidd@gmail.com"]
  gem.homepage      = "http://github.com/markburns/numbers_in_words"

  gem.add_development_dependency      "rspec", "~> 3.4.0"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
