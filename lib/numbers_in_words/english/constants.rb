require_relative 'exceptional_numbers'

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

    def self.powers_of_ten
      {
        0         => "one",
        1         => "ten",
        2         => "hundred",
        3         => "thousand",
        2 * 3     => "million",
        3 * 3     => "billion",
        4 * 3     => "trillion",
        5 * 3     => "quadrillion",
        6 * 3     => "quintillion",
        7 * 3     => "sextillion",
        8 * 3     => "septillion",
        9 * 3     => "octillion",
        10 * 3    => "nonillion",
        11 * 3    => "decillion",
        12 * 3    => "undecillion",
        13 * 3    => "duodecillion",
        14 * 3    => "tredecillion",
        15 * 3    => "quattuordecillion",
        16 * 3    => "quindecillion",
        17 * 3    => "sexdecillion",
        18 * 3    => "septendecillion",
        19 * 3    => "octodecillion",
        20 * 3    => "novemdecillion",
        21 * 3    => "vigintillion",
        22 * 3    => "unvigintillion",
        23 * 3    => "duovigintillion",
        24 * 3    => "trevigintillion",
        25 * 3    => "quattuorvigintillion",
        26 * 3    => "quinvigintillion",
        27 * 3    => "sexvigintillion",
        28 * 3    => "septenvigintillion",
        29 * 3    => "octovigintillion",
        30 * 3    => "novemvigintillion",
        31 * 3    => "trigintillion",
        32 * 3    => "untrigintillion",
        33 * 3    => "duotrigintillion",
        100       => "googol",
        101 * 3   => "centillion",
        10 ** 100 => "googolplex",
      }
    end

    def self.swap_keys(hash)
      hash.each_with_object({}) {|(k,v), h| h[v]=k }
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
      txt.match /^one (#{POWERS_RX})$/
    end

    def self.strip_minus(txt)
      stripped = txt.gsub(/^minus/, "") if txt =~ /^minus/
    end

    def self.check_decimal(txt)
      txt.match(/\spoint\s/)
    end
  end
end
