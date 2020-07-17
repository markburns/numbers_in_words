# frozen_string_literal: true

require 'forwardable'
require_relative 'definitions'

module NumbersInWords
  class ExceptionalNumbers
    extend Forwardable
    def_delegators :to_h, :fetch

    def defines?(number)
      to_h.key?(number)
    end

    def to_h
      Definitions::DEFINITIONS.transform_values do |h|
        h[:number]
      end
    end
  end
end
