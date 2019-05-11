[![Build Status](http://img.shields.io/travis/markburns/numbers_in_words.svg)](https://travis-ci.org/markburns/numbers_in_words)
[![Maintainability](https://api.codeclimate.com/v1/badges/a51210488896b798af20/maintainability)](https://codeclimate.com/github/markburns/numbers_in_words/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/a51210488896b798af20/test_coverage)](https://codeclimate.com/github/markburns/numbers_in_words/test_coverage)
[![Gem Version](http://img.shields.io/gem/v/numbers_in_words.svg)](https://rubygems.org/gems/numbers_in_words)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://markburns.mit-license.org)

Installation
============

```ruby
gem 'numbers_in_words'
```

Usage
=========

```ruby
require 'numbers_in_words'

NumbersInWords.in_words(112)
#=> one hundred and twelve

NumbersInWords.in_numbers("one googol")
#=>10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

NumbersInWords.in_numbers("Seventy million, five-hundred and fifty six thousand point eight nine three")
#=> 70556000.893

NumbersInWords.in_numbers("nineteen sixty five")
#=> 1965
```


Monkey patch version

```ruby
require 'numbers_in_words'
require 'numbers_in_words/duck_punch'
112.in_words
#=> one hundred and twelve

"one googol".in_numbers
#=>10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

"Seventy million, five-hundred and fifty six thousand point eight nine three".in_numbers
#=> 70556000.893
```
