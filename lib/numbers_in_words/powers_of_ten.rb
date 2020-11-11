# frozen_string_literal: true

module NumbersInWords
  GOOGOL = 10**100

  POWERS_OF_TEN = {
    0 => 'one',
    1 => 'ten',
    2 => 'hundred',
    1 * 3 => 'thousand',
    2 * 3 => 'million',
    3 * 3 => 'billion',
    4 * 3 => 'trillion',
    5 * 3 => 'quadrillion',
    6 * 3 => 'quintillion',
    7 * 3 => 'sextillion',
    8 * 3 => 'septillion',
    9 * 3 => 'octillion',
    10 * 3 => 'nonillion',
    11 * 3 => 'decillion',
    12 * 3 => 'undecillion',
    13 * 3 => 'duodecillion',
    14 * 3 => 'tredecillion',
    15 * 3 => 'quattuordecillion',
    16 * 3 => 'quindecillion',
    17 * 3 => 'sexdecillion',
    18 * 3 => 'septendecillion',
    19 * 3 => 'octodecillion',
    20 * 3 => 'novemdecillion',
    21 * 3 => 'vigintillion',
    22 * 3 => 'unvigintillion',
    23 * 3 => 'duovigintillion',
    24 * 3 => 'trevigintillion',
    25 * 3 => 'quattuorvigintillion',
    26 * 3 => 'quinvigintillion',
    27 * 3 => 'sexvigintillion',
    28 * 3 => 'septenvigintillion',
    29 * 3 => 'octovigintillion',
    30 * 3 => 'novemvigintillion',
    31 * 3 => 'trigintillion',
    32 * 3 => 'untrigintillion',
    33 * 3 => 'duotrigintillion',
    100 => 'googol',
    101 * 3 => 'centillion',
    GOOGOL => 'googolplex'
  }.freeze

  POWERS_RX = Regexp.union(POWERS_OF_TEN.values[1..-1]).freeze
end
