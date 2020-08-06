# frozen_string_literal: true
if ENV['CI']
  require 'simplecov'
  SimpleCov.start
end

require 'numbers_in_words'
require 'numbers_in_words/duck_punch'
require 'byebug'
