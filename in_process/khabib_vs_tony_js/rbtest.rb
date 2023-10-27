KHABIB = %w[jab overhand takedown hammerfist submission]
TONY = %w[elbow punch kick imanary submission]

def action_power(upcase, exclamation)
  return 10 if upcase && exclamation
  return 5 if upcase
  return 3 if exclamation
  1
end

def action_points(upcase, exclamation)
  res = 1
  res += 1 if upcase || exclamation
  res
end

def khabib_vs_tony(joe_and_nate)
  @habib_points, @tony_points = 0, 0
  @habib_hp, @tony_hp = 100, 100
  @position = 'standing'
  joe_and_nate.scan(/#{(KHABIB + TONY).join('!?|')}/i).each do |action|
    upcase = action == action.upcase ? true : false
    exclamation = action[-1] == '!' ? true : false
    action = action.downcase.tr('!', '')
    @position = 'ground' if %w[takedown hammerfist imanary].include?(action)
    @position = 'standing' if %w[jab overhand punch kick].include?(action)
    ap = action_power(upcase, exclamation)
    if action == 'submission' && @habib_hp > @tony_hp && @tony_hp < 20
      @habib_points += action_points(upcase, exclamation)
      return 'Khabib won by submission' if @habib_hp - @tony_hp > (@position == 'standing' ? 10 : 5)
    elsif action == 'submission' && @habib_hp < @tony_hp && @habib_hp < 20
      @tony_points += action_points(upcase, exclamation)
      return 'Tony won by submission' if @tony_hp - @habib_hp > (@position == 'standing' ? 10 : 5)
    elsif %w[elbow punch kick].include?(action)
      return 'Tony won by KO' if @habib_hp < (@position == 'standing' ? 30 : 20) && ap == 10
      @habib_hp -= ap
    elsif %w[jab overhand hammerfist].include?(action)
      return 'Khabib won by KO' if @tony_hp < (@position == 'standing' ? 20 : 30) && ap == 10
      @tony_hp -= ap
    end
    return 'Tony won by TKO' if @habib_hp <= 0
    return 'Khabib won by TKO' if @tony_hp <= 0
    @habib_points += action_points(upcase, exclamation) if %w[jab overhand hammerfist takedown].include?(action)
    @tony_points += action_points(upcase, exclamation) if %w[elbow punch kick imanary].include?(action)
  end
  return 'Khabib won by decision' if @habib_points > @tony_points
  return 'Tony won by decision' if @habib_points < @tony_points
  'Draw'
end

joe_and_nate = "First round! The fighters are in the center, Khabib delivers a power jab! and immediately OVERHAND! Tony felt it. Ferguson tries to break the distance with a kick, but another OVERHAND! Tony staggers. Takedown, Khabib easily moved the shocked opponent, trying to make a submission, but Tony's jiujitsu works. Hammerfist, HAMMERFIST, HAMMERFIST! Tony's doing bad, he can only try to survive. Hammerfist! HAMMERFIST! HAMMERFIST! HAMMERFIST! HAMMERFIST! Ferguson sweeps and slides out, all is not lost for him! He is shaking, can he survive until the end of the round? Khabib clamps down on his jab. Jab!, OVERHAND! Knockout!!! Incredible domination, I did not expect such an easy victory for Khabib."
p khabib_vs_tony(joe_and_nate) # 'Khabib won by KO'
#
# joe_and_nate = "Khabib tries to pull Tony to the cage, hits the jab, but misses. ELBOW! from the turn, how did he catch him! Khabib backs away like he's shocked and got a cut above his eye, blood starts to fill his eye, Tony is chasing, kick! More KICK, PUNCH! ELBOW! More PUNCH, Khabib got another cut, his whole face is in blood, he can't see anything. Khabib does a takedown and Tony closes the guard. Khabib tries to hit, but he sees almost nothing, bumps into an ELBOW! ELBOW! ELBOW! Another ELBOW! New cuts, Khabib's face becomes like a bloody mask. Tony throws a triangle, tightens, it looks like Khabib passed out, excellent submission. Yes, Tony is horrendous, the real El Cucuy."
# p khabib_vs_tony(joe_and_nate) # 'Tony won by submission'
#
# joe_and_nate = "Khabib starts with a jab, Tony kicks back, another jab, OVERHAND! Tony backs to the cage. Khabib corners Ferguson, takedown. Tony tries to get out but gives back, hammerfist, HAMMERFIST, HAMMERFIST! Tony rolls over and Khabib keeps hitting him with the mount, hammerfist, HAMMERFIST, HAMMERFIST! Ferguson hits with an elbow, tries to twist and improve his position, but to no avail, hammerfist, HAMMERFIST, HAMMERFIST! Siren round is over. Khabib confidently took him 10 - 9.
# Second round. Tony starts with a kick, punch, another kick, not a bad start. Imanari roll!? Why did he do it? Tony is on the bottom again, that was stupid. Khabib went back to hammering hammerfist after hammerfist, more HAMMERFIST! It looks like the error was critical. HAMMERFIST, HAMMERFIST, HAMMERFIST, HAMMERFIST, HAMMERFIST, HAMMERFIST. Tony doesn't actively defend, Big John stops the fight."
# p khabib_vs_tony(joe_and_nate) # 'Khabib won by TKO'
#
# joe_and_nate = "It looks like the score is equal, everything will be decided by the last round. Khabib comes up with a jab, Tony hits back with a kick, another kick, Khabib catches his leg, he can’t go down, Tony hits with an elbow, another elbow. Khabib makes another attempt to move into the fight, again unsuccessfully, it seems Tony retained more strength at the end of the fight. Jab, kick, punch. These middle exchanges are clearly in favor of Tony. Khabib closes in, takedown, Tony in guard, he defends well, gets a hammerfist, but immediately responds with an elbow. Siren, let's see what the judges say."
# p khabib_vs_tony(joe_and_nate) # 'Tony won by decision'
#
# joe_and_nate = "It looks like the score is equal, everything will be decided by the last round. Khabib comes up with a jab, Tony hits back with a kick, another kick, Khabib catches his leg, he can’t go down, Tony hits with an elbow, another elbow. Khabib makes another attempt to move into the fight, again unsuccessfully, it seems Tony retained more strength at the end of the fight. Jab, kick, punch. These middle exchanges are clearly in favor of Tony. Khabib closes in, takedown, Tony is on guard, he defends well but gets a hammerfist, and another HAMMERFIST. Siren, let's see what the judges say."
# p khabib_vs_tony(joe_and_nate) # 'Draw'
