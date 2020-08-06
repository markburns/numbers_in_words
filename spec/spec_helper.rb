# frozen_string_literal: true
if ENV['CC_TEST_REPORTER_ID']
  require 'simplecov'
  SimpleCov.start
end

require 'numbers_in_words'
require 'numbers_in_words/duck_punch'
require 'byebug'
