[![Build Status](http://img.shields.io/travis/markburns/numbers_in_words.svg)](https://travis-ci.org/markburns/numbers_in_words)
[![Dependency Status](http://img.shields.io/gemnasium/markburns/numbers_in_words.svg)](https://gemnasium.com/markburns/numbers_in_words)
[![Code Climate](http://img.shields.io/codeclimate/github/markburns/numbers_in_words.svg)](https://codeclimate.com/github/markburns/numbers_in_words)
[![Gem Version](http://img.shields.io/gem/v/numbers_in_words.svg)](https://rubygems.org/gems/numbers_in_words)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://markburns.mit-license.org)
[![Badges](http://img.shields.io/:badges-6/6-ff6799.svg)](https://github.com/badges/badgerbadgerbadger)

Installation
============

```ruby
gem 'numbers_in_words'

require 'numbers_in_words'
require 'numbers_in_words/duck_punch' #see why later
```

This project was created for a test for a job interview. I haven't really used
it myself, but I saw it mentioned somewhere so I thought I'd tidy it up a bit.

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


NoMethodError `in_words` or `in_numbers`
----------
I'm going to hopefully preempt some support queries by predicting this will happen:

You've got one of:

```
NoMethodError: undefined method `in_words' for 123:Fixnum
NoMethodError: undefined method `in_numbers' for "123":String
```

Previous versions of this gem duckpunched Fixnum and String with a whole bunch
of methods. This gem will now only add methods if you specifically tell it to
with:

```ruby
require 'numbers_in_words'
require 'numbers_in_words/duck_punch'
```

Plus it now only adds a single `#in_words` method to `Numeric` and an `#in_numbers`
method to `String` instead of a whole bunch of them.


Future plans
============

* Handle complex numbers
* Option for outputting punctuation
* Reject invalid numbers
* Support for other languages
