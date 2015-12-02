[![Build Status](http://img.shields.io/travis/markburns/numbers_in_words.svg)](https://travis-ci.org/markburns/numbers_in_words)
[![Dependency Status](http://img.shields.io/gemnasium/markburns/numbers_in_words.svg)](https://gemnasium.com/markburns/numbers_in_words)
[![Code Climate](http://img.shields.io/codeclimate/github/markburns/numbers_in_words.svg)](https://codeclimate.com/github/markburns/numbers_in_words)
[![Test Coverage](https://codeclimate.com/github/markburns/numbers_in_words/badges/coverage.svg)](https://codeclimate.com/github/markburns/numbers_in_words/coverage)
[![Gem Version](http://img.shields.io/gem/v/numbers_in_words.svg)](https://rubygems.org/gems/numbers_in_words)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://markburns.mit-license.org)
[![Badges](http://img.shields.io/:badges-7/7-ff6799.svg)](https://github.com/badges/badgerbadgerbadger)

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
