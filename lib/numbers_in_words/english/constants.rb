module NumbersInWords
  module English

    def self.canonize(w)
      aliases = {
        "oh" => "zero"
      }
      canon = aliases[w]
      return canon ? canon : w
    end

    def self.exceptional_numbers
      @exceptional_numbers ||= ExceptionalNumbers.new
    end

    class ExceptionalNumbers
      DEFINITIONS = {
        0  => {number: "zero"     , ordinal: "zeroth", fraction: ->{DivideByZeroError} } ,
        1  => {number: "one"      , ordinal: "first" } ,
        2  => {number: "two"      , ordinal: "second", fraction: {singular: "half", plural: "halves"} } ,
        3  => {number: "three"    , ordinal: "third"  } ,
        4  => {number: "four"     , ordinal: "fourth", fraction: {singular: ["fourth" "quarter"] }} ,
        5  => {number: "five"     , ordinal: "fifth",  } ,
        6  => {number: "six"       } ,
        7  => {number: "seven"      } ,
        8  => {number: "eight"    , ordinal: "eighth", } ,
        9  => {number: "nine"     , ordinal: "ninth", } ,
        10 => {number: "ten"        } ,
        11 => {number: "eleven"   } ,
        12 => {number: "twelve"   , ordinal: "twelfth" } ,
        13 => {number: "thirteen"  } ,
        14 => {number: "fourteen"  } ,
        15 => {number: "fifteen"  } ,
        16 => {number: "sixteen"  } ,
        17 => {number: "seventeen"} ,
        18 => {number: "eighteen" } ,
        19 => {number: "nineteen" } ,
        20 => {number: "twenty"   , ordinal: "twentieth"} ,
        30 => {number: "thirty"   , ordinal: "thirtieth" } ,
        40 => {number: "forty"    , ordinal: "fortieth" } ,
        50 => {number: "fifty"    , ordinal: "fiftieth"} ,
        60 => {number: "sixty"    , ordinal: "sixtieth"} ,
        70 => {number: "seventy"  , ordinal: "seventieth"} ,
        80 => {number: "eighty"   , ordinal: "eightieth"} ,
        90 => {number: "ninety"   , ordinal: "ninetieth"}
      }

      def defines?(number)
        to_h.key?(number)
      end

      def to_h
        DEFINITIONS.each_with_object({}) do |(i,h), out|
          out[i]=h[:number]
        end
      end
      def fetch(number)
        DEFINITIONS[number][:number]
      end
    end

    def self.swap_keys(hash)
      hash.each_with_object({}) {|(k,v), h| h[v]=k }
    end

    def self.powers_of_ten
      {
        0   => "one",
        1   => "ten",
        2   => "hundred",
        3   => "thousand",
        6   => "million",
        9   => "billion",
        12  => "trillion",
        15  => "quadrillion",
        18  => "quintillion",
        21  => "sextillion",
        24  => "septillion",
        27  => "octillion",
        30  => "nonillion",
        33  => "decillion",
        36  => "undecillion",
        39  => "duodecillion",
        42  => "tredecillion",
        45  => "quattuordecillion",
        48  => "quindecillion",
        51  => "sexdecillion",
        54  => "septendecillion",
        57  => "octodecillion",
        60  => "novemdecillion",
        63  => "vigintillion",
        66  => "unvigintillion",
        69  => "duovigintillion",
        72  => "trevigintillion",
        75  => "quattuorvigintillion",
        78  => "quinvigintillion",
        81  => "sexvigintillion",
        84  => "septenvigintillion",
        87  => "octovigintillion",
        90  => "novemvigintillion",
        93  => "trigintillion",
        96  => "untrigintillion",
        99  => "duotrigintillion",
        100 => "googol"
      }
    end

    def self.exceptional_numbers_to_i
      swap_keys exceptional_numbers.to_h
    end

    def self.powers_of_ten_to_i
      swap_keys powers_of_ten
    end

    POWERS_RX = Regexp.union(powers_of_ten.values[1..-1])

    def self.check_mixed(txt)
      mixed = txt.match /^(-?\d+(.\d+)?) (#{POWERS_RX}s?)$/
      if mixed && mixed[1] && mixed[3]
        matches = [mixed[1], mixed[3]].map{ |m| NumbersInWords.in_numbers m }
        return matches.reduce(&:*)
      end
    end

    def self.check_one(txt)
      one = txt.match /^one (#{POWERS_RX})$/
    end

    def self.strip_minus(txt)
      stripped = txt.gsub(/^minus/, "") if txt =~ /^minus/
    end

    def self.check_decimal(txt)
      txt.match(/\spoint\s/)
    end
  end
end
