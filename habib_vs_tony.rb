HABIB = %w[jab overhand takedown нammerfist submission]
TONY = %w[elbow punch kick imanary submission]

def action_power(upcase, exclamation)
  return 10 if upcase && exclamation
  return 5 if upcase
  return 3 if exclamation
  1
end

def action_points(upcase, exclamation)
  res = 1
  res += 1 if upcase && exclamation
  res
end

def habib_vs_tony(joe_and_nate)
  habib_points, tony_points = 0, 0
  habib_hp, tony_hp = 100, 100
  position = 'standing'
  joe_and_nate.scan(/#{(HABIB + TONY).join('!?|')}/i).each do |action|
    upcase = action == action.upcase ? true : false
    exclamation = action[-1] == '!' ? true : false
    action = action.downcase.tr('!', '')
    position = 'ground' if %w[takedown нammerfist imanary].include?(action)
    position = 'standing' if %w[jab overhand punch kick].include?(action)
    if action == 'submission' && habib_hp > tony_hp && tony_hp < 20
      habib_points += action_points(upcase, exclamation)
      return 'Habib win by submition' if habib_hp - tony_hp > (position == 'standing' ? 10 : 5)
    elsif action == 'submission' && habib_hp < tony_hp && habib_hp < 20
      tony_points += action_points(upcase, exclamation)
      return 'Tony win by submition' if tony_hp - habib_hp > (position == 'standing' ? 10 : 5)
    end
    habib_points += action_points(upcase, exclamation) if %w[jab overhand нammerfist takedown].include?(action)
    tony_points += action_points(upcase, exclamation) if %w[elbow punch kick imanary].include?(action)
    if %w[elbow punch kick].include?(action)
      ap = action_power(upcase, exclamation)
      return 'Tony win by KO' if habib_hp < (position == 'standing' ? 20 : 10) && ap == 10
      habib_hp -= ap
    end
    if %w[jab overhand нammerfist].include?(action)
      ap = action_power(upcase, exclamation)
      return 'Habib win by KO' if tony_hp < (position == 'standing' ? 10 : 20) && ap == 10
      tony_hp -= ap
    end
    return 'Tony win by TKO' if habib_hp == 0
    return 'Habib win by TKO' if tony_hp == 0
  end
  return 'Habib win by decision' if habib_points > tony_points
  return 'Tony win by decision' if habib_points < tony_points
  'Draw'
end

class JoeAndNate
  HABIB = %w[jab overhand takedown нammerfist submission]
  TONY = %w[punch elbow kick imanary submission]
  JOE = ["Oooh!!"]
  NATE = ["I'm not surprised motherfuckers!"]

  attr_reader :comments

  def initialize
    @comments = rand(50..150).times.with_object([]) { |i, res|
      str = (HABIB + TONY + JOE + NATE).sample
      rand1, rand2 = rand(3), rand(5)
      str.capitalize! if rand1 == 1
      str.upcase! if rand1 == 2
      str += '!' if rand2 == 0
      res << str
    }.join(' ')
  end
end


100.times do
  joe_and_nate = JoeAndNate.new.comments
  p habib_vs_tony(joe_and_nate)
end
