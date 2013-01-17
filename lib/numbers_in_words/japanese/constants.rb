#encoding: utf-8
module NumbersInWords
  module Japanese
    def self.exceptions
      {
        0 => "〇",
        1 => "一",
        2 => "二",
        3 => "三",
        4 => "四",
        5 => "五",
        6 => "六",
        7 => "七",
        8 => "八",
        9 => "九",
        10 => "十"
      }
    end

    def self.swap_keys hsh
      hsh.inject({}){|h,(k,v)| h[v]=k; h}
    end

    def self.powers_of_ten
      {
        0   => "一",
        1   => "十",
        2   => "百",
        3   => "千",
        4   => "万",
        8   => "億",
        12  => "兆",
        16  => "京",
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
