module NumbersInWords
  module English
    def self.exceptions
      {
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
  end
end
