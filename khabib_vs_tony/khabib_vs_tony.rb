module Kata
  
  class JoeAndNate
    KHABIB = %w[jab overhand takedown нammerfist submission]
    TONY = %w[punch elbow kick imanary submission]
    JOE = ["Oooh!!"]
    NATE = ["I'm not surprised motherfuckers!"]

    attr_reader :comments

    def initialize
      @comments = rand(50..150).times.with_object([]) { |i, res|
        str = (KHABIB + TONY + JOE + NATE).sample
        rand1, rand2 = rand(3), rand(5)
        str.capitalize! if rand1 == 1
        str.upcase! if rand1 == 2
        str += '!' if rand2 == 0
        res << str
      }.join(' ')
    end
  end

end
