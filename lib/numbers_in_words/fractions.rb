module NumbersInWords
  class Fractions
    def call
      Definitions::DEFINITIONS.map do |_n, attrs|
        Fraction.new(attrs).call
      end.flatten.compact
    end
  end

  class Fraction
    attr_reader :attributes

    def initialize(attributes)
      @attributes = attributes
    end

    def call
      [singular, plural, ordinal, ordinal_plural].reject { |f| f == false }
    end

    def ordinal_plural
      ordinal + 's'
    end

    def ordinal
      attributes[:ordinal] || (attributes[:number] + 'th')
    end

    def plural
      fraction? && (fraction_plural || singular + 's')
    end

    def fraction_plural
      fraction? && fraction[:plural]
    end

    def singular
      fraction? && fraction[:singular]
    end

    def fraction?
      fraction&.is_a?(Hash)
    end

    def fraction
      attributes[:fraction]
    end
  end
end
