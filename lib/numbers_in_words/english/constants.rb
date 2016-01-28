module NumbersInWords
  module English

    def self.canonize(w)
      aliases = {
        "oh" => "zero",
        "fourth" => "quarter"
      }
      canon = aliases[w]
      return canon ? canon : w
    end

    def self.exceptions
      {
        0.50 => "half",
        0.33 => "third",
        0.25 => "quarter",
        0.20 => "fifth",

        0 => "zero",
        1 => "one",
        2 => "two",
        3 => "three",
        4 => "four",
        5 => "five",
        6 => "six",
        7 => "seven",
        8 => "eight",
        9 => "nine",

        10 => "ten",
        11 => "eleven",
        12 => "twelve",

        13 => "thirteen",
        14 => "fourteen",
        15 => "fifteen",
        16 => "sixteen" ,
        17 => "seventeen",
        18 => "eighteen",
        19 => "nineteen",

        20 => "twenty",
        30 => "thirty",
        40 => "forty",
        50 => "fifty",
        60 => "sixty",
        70 => "seventy",
        80 => "eighty",
        90 => "ninety"
      }
    end

    def self.swap_keys hsh
      hsh.inject({}){|h,(k,v)| h[v]=k; h}
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

    def self.exceptions_to_i
      swap_keys exceptions
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
