# frozen_string_literal: true

require 'forwardable'
require_relative 'parsing/number_parser'
require_relative 'parsing/in_numbers'

module NumbersInWords
  class ToNumber
    extend Forwardable
    def_delegator :that, :to_s

    attr_reader :that

    def initialize(that)
      @that = that
    end

    def in_numbers(only_compress: false)
      InNumbers.new(that, only_compress).call
    end
  end
end
