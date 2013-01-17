module NumbersInWords::NumberParser
  # Example: 364,895,457,898
  #three hundred and sixty four billion eight hundred and ninety five million
  #four hundred and fifty seven thousand eight hundred and ninety eight
  #
  #3 100 60 4 10^9, 8 100 90 5 10^6, 4 100 50 7 1000, 8 100 90 8
  #                                                                    memory answer
  #x1. 3 add to memory because answer and memory are zero                 3     0
  #x2. memory * 100 (because memory<100)                                  300   0
  #x3. 60 add to memory because memory > 60                               360   0
  #x3. 4 add to memory because memory > 4                                364    0
  #x4. multiply memory by 10^9 because memory < power of ten          364*10^9  0
  #x5. add memory to answer  (and reset)memory > 8 (memory pow of ten > 2) 0   364*10^9
  #x6. 8 add to memory because not finished                                8    ''
  #x7. multiply memory by 100 because memory < 100                        800   ''
  #x8. add 90 to memory because memory > 90                               890   ''
  #x9. add 5 to memory because memory > 5                                 895   ''
  #x10. multiply memory by 10^6 because memory < power of ten        895*10^6    ''
  #x11. add memory to answer (and reset) because memory power ten > 2       0    364895 * 10^6
  #x12. 4 add to memory because not finished                                4    ''
  #x13. memory * 100 because memory < 100                                 400    ''
  #x14. memory + 50 because memory > 50                                   450    ''
  #x15. memory + 7  because memory > 7                                    457    ''
  #x16. memory * 1000 because memory < 1000                            457000    ''
  #x17. add memory to answer  (and reset)memory > 8 (memory pow of ten > 2) 0   364895457000
  #x18. 8 add to memory because not finished                                8    ''
  #x19. memory * 100 because memory < 100                                 800    ''
  #x14. memory + 90 because memory > 90                                   890    ''
  #x15. memory + 8  because memory > 8                                    898    ''
  #16. finished so add memory to answer

  #Example
  #2001
  #two thousand and one
  #2 1000 1
  #                                                        memory answer
  #1. add 2 to memory because first                          2       0
  #2. multiply memory by 1000 because memory < 1000        2000      0
  #3. add memory to answer,reset,  because power of ten>2    0      2000
  #4. add 1 to memory                                        1      2000
  #5. finish - add memory to answer                          0      2001
  def parse(integers)
    memory = 0
    answer = 0
    reset = true #reset each time memory is reset
    integers.each_with_index do |integer, index|
      if reset
        reset = false
        memory += integer
      else
        #x4. multiply memory by 10^9 because memory < power of ten
        if power_of_ten?(integer)
          if power_of_ten(integer)> 2
            memory *= integer
            #17. add memory to answer  (and reset) (memory pow of ten > 2)
            answer += memory
            memory = 0
            reset = true
          end
        end

        if memory < integer
          memory *= integer
        else
          memory += integer
        end
      end
    end
    answer += memory
  end

  def power_of_ten integer
    Math.log10(integer)
  end

  def power_of_ten? integer
    power_of_ten(integer) == power_of_ten(integer).to_i
  end

  extend self
end
