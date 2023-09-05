require './khabib_vs_tony'
require './khabib_vs_tony_solution'
require './test_solution'

include Kata
include Solution

describe JoeAndNate do
  before do
    @joe_and_nate = JoeAndNate.new.comments
  end

  it "sample test 1: Khabib won by KO" do
    joe_and_nate = "First round! The fighters are in the center, Khabib delivers a power jab! and immediately OVERHAND! Tony felt it. Ferguson tries to break the distance with a kick, but another OVERHAND! Tony staggers. Takedown, Khabib easily moved the shocked opponent, trying to make a submission, but Tony's jiujitsu works. Hammerfist, HAMMERFIST, HAMMERFIST! Tony's doing bad, he can only try to survive. Hammerfist! HAMMERFIST! HAMMERFIST! HAMMERFIST! HAMMERFIST! Ferguson sweeps and slides out, all is not lost for him! He is shaking, can he survive until the end of the round? Khabib clamps down on his jab. Jab!, OVERHAND! Knockout!!! Incredible domination, I did not expect such an easy victory for Khabib."
    expect(khabib_vs_tony(joe_and_nate)).to eq 'Khabib won by KO'
  end

  it "sample test 2: Tony won by submission" do
    joe_and_nate = "Khabib tries to pull Tony to the cage, hits the jab, but misses. ELBOW! from the turn, how did he catch him! Khabib backs away like he's shocked and got a cut above his eye, blood starts to fill his eye, Tony is chasing, kick! More KICK, PUNCH! ELBOW! More PUNCH, Khabib got another cut, his whole face is in blood, he can't see anything. Khabib does a takedown and Tony closes the guard. Khabib tries to hit, but he sees almost nothing, bumps into an ELBOW! ELBOW! ELBOW! Another ELBOW! New cuts, Khabib's face becomes like a bloody mask. Tony throws a triangle, tightens, it looks like Khabib passed out, excellent submission. Yes, Tony is horrendous, the real El Cucuy."
    expect(khabib_vs_tony(joe_and_nate)).to eq 'Tony won by submission'
  end

  it "sample test 3: Khabib won by TKO" do
    joe_and_nate = "Khabib starts with a jab, Tony kicks back, another jab, OVERHAND! Tony backs to the cage. Khabib corners Ferguson, takedown. Tony tries to get out but gives back, hammerfist, HAMMERFIST, HAMMERFIST! Tony rolls over and Khabib keeps hitting him with the mount, hammerfist, HAMMERFIST, HAMMERFIST! Ferguson hits with an elbow, tries to twist and improve his position, but to no avail, hammerfist, HAMMERFIST, HAMMERFIST! Siren round is over. Khabib confidently took him 10 - 9.
    Second round. Tony starts with a kick, punch, another kick, not a bad start. Imanari roll!? Why did he do it? Tony is on the bottom again, that was stupid. Khabib went back to hammering hammerfist after hammerfist, more HAMMERFIST! It looks like the error was critical. HAMMERFIST, HAMMERFIST, HAMMERFIST, HAMMERFIST, HAMMERFIST, HAMMERFIST. Tony doesn't actively defend, Big John stops the fight."
    expect(khabib_vs_tony(joe_and_nate)).to eq 'Khabib won by TKO'
  end

  # it "sample test 4: Tony won by decision" do
  #   joe_and_nate =
  #   expect(khabib_vs_tony(joe_and_nate)).to eq khabib_vs_tony_solution(joe_and_nate)
  # end
  #
  # it "sample test 5: Draw" do
  #   joe_and_nate =
  #   expect(khabib_vs_tony(joe_and_nate)).to eq khabib_vs_tony_solution(joe_and_nate)
  # end

  # 100.times do
  #   it "random test" do
  #     expect(khabib_vs_tony(@joe_and_nate)).to eq khabib_vs_tony_solution(@joe_and_nate)
  #   end
  # end
end
