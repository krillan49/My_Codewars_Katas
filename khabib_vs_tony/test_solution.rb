KHABIB = %w[jab overhand takedown нammerfist submission]
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
  habib_points, tony_points = 0, 0
  habib_hp, tony_hp = 100, 100
  position = 'standing'
  joe_and_nate.scan(/#{(KHABIB + TONY).join('!?|')}/i).each do |action|
    # p tony_hp
    # p habib_hp
    upcase = action == action.upcase ? true : false
    exclamation = action[-1] == '!' ? true : false
    action = action.downcase.tr('!', '')
    position = 'ground' if %w[takedown нammerfist imanary].include?(action)
    position = 'standing' if %w[jab overhand punch kick].include?(action)
    ap = action_power(upcase, exclamation)
    if action == 'submission' && habib_hp > tony_hp && tony_hp < 20
      habib_points += action_points(upcase, exclamation)
      return 'Khabib won by submission' if habib_hp - tony_hp > (position == 'standing' ? 10 : 5)
    elsif action == 'submission' && habib_hp < tony_hp && habib_hp < 20
      tony_points += action_points(upcase, exclamation)
      return 'Tony won by submission' if tony_hp - habib_hp > (position == 'standing' ? 10 : 5)
    elsif %w[elbow punch kick].include?(action)
      return 'Tony won by KO' if habib_hp < (position == 'standing' ? 30 : 20) && ap == 10
      habib_hp -= ap
    elsif %w[jab overhand нammerfist].include?(action)
      return 'Khabib won by KO' if tony_hp < (position == 'standing' ? 20 : 30) && ap == 10
      tony_hp -= ap
    end
    return 'Tony won by TKO' if habib_hp == 0
    return 'Khabib won by TKO' if tony_hp == 0
    habib_points += action_points(upcase, exclamation) if %w[jab overhand нammerfist takedown].include?(action)
    tony_points += action_points(upcase, exclamation) if %w[elbow punch kick imanary].include?(action)
  end
  return 'Khabib won by decision' if habib_points > tony_points
  return 'Tony won by decision' if habib_points < tony_points
  'Draw'
end

'elbow punch kick imanary submission jab overhand takedown нammerfist submission'
"elbow! punch! kick! imanary! submission! jab! overhand! takedown! нammerfist! submission!"
"ELBOW PUNCH KICK IMANARY SUBMISSION JAB OVERHAND TAKEDOWN НAMMERFIST SUBMISSION"
"ELBOW! PUNCH! KICK! IMANARY! SUBMISSION! JAB! OVERHAND! TAKEDOWN! НAMMERFIST! SUBMISSION!"

# res = "Khabib tries to pull Tony to the cage, hits the jab, but misses. ELBOW! from the turn, how did he catch him! Khabib backs away like he's shocked and got a cut above his eye, blood starts to fill his eye, Tony is chasing, kick! More KICK, PUNCH! ELBOW! More PUNCH, Khabib got another cut, his whole face is in blood, he can't see anything. Khabib does a takedown and Tony closes the guard. Khabib tries to hit, but he sees almost nothing, bumps into an ELBOW! ELBOW! ELBOW! Another ELBOW! New cuts, Khabib's face becomes like a bloody mask. Tony throws a triangle, tightens, it looks like Khabib passed out, excellent submission. Yes, Tony is horrendous, the real El Cucuy."
#
# p khabib_vs_tony(res)
