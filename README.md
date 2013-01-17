Installation
============

```
gem 'numbers_in_words'

require 'numbers_in_words'
require 'numbers_in_words/duck_punch' #see why later
```

This project was created for a test for a job interview. I haven't really used
it myself, but I saw it mentioned somewhere so I thought I'd tidy it up a bit.

I'm going to hopefully preempt some support queries by predicting this will happen:

You've got one of:

```
NoMethodError: undefined method `in_words' for 123:Fixnum
NoMethodError: undefined method `in_numbers' for "123":String
```

Here's why
==========

Previous versions of this gem duckpunched Fixnum and String with a whole bunch
of methods. This gem will now only add methods if you specifically tell it to
with:

```
require 'numbers_in_words'
require 'numbers_in_words/duck_punch'
```

Plus it now only adds a single `#in_words` method to `Numeric` and an `#in_numbers`
method to `String` instead of a whole bunch of them.

Usage
=========

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

---------------

Whilst creating this project I realized that in English:

* Numbers are grouped in groups of threes
* Numbers less than 1,000 are grouped by hundreds and then by tens
* There are specific rules for when we put an "and" in between numbers

It makes sense to manage the numbers by these groups, so
I created a method groups_of which will split any integer into
groups of a certain size. It returns a hash with the power of ten
as the key and the multiplier as the value. E.g:

```ruby
31245.groups_of(3)
#=> {0=>245,3=>31} #i.e. 31 thousands, and 245 ones

245.group_of(2)
#=> {0=>45,2=>2}    #i.e. 2 hundreds, and 45 ones
```

(In Japanese numbers are grouped in groups of 4, so it makes sense to try and
separate the language related stuff from the number grouping related stuff)

Example of usage:

```ruby
245.group_words(2,"English") do |power, name, digits|
  puts "#{digits}*10^#{power} #{digits} #{name}s"
end


2  * 10^2 =  2 hundreds
45 * 10^0 = 45 ones

 ```

Future plans
============

* Handle complex numbers
* Option for outputting punctuation
* Reject invalid numbers
* Support for other languages
