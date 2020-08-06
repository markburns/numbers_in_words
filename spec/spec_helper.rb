# frozen_string_literal: true

if ENV['CC_TEST_REPORTER_ID']
  require 'simplecov'
  SimpleCov.start
end

unless Kernel.method_defined?(:silence_warnings)
  module Kernel
    def silence_warnings
      with_warnings(nil) { yield }
    end

    def with_warnings(flag)
      old_verbose = $VERBOSE
      $VERBOSE = flag
      yield
    ensure
      $VERBOSE = old_verbose
    end
  end
end

require 'numbers_in_words'
require 'numbers_in_words/duck_punch'
require 'byebug'
