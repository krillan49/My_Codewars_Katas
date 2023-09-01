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
    joe_and_nate =
    expect(khabib_vs_tony(joe_and_nate)).to eq khabib_vs_tony_solution(joe_and_nate)
  end

  # it "sample test 2: Tony won by TKO" do
  #   joe_and_nate =
  #   expect(khabib_vs_tony(joe_and_nate)).to eq khabib_vs_tony_solution(joe_and_nate)
  # end
  #
  # it "sample test 3: Khabib won by submition" do
  #   joe_and_nate =
  #   expect(khabib_vs_tony(joe_and_nate)).to eq khabib_vs_tony_solution(joe_and_nate)
  # end
  #
  # it "sample test 4: Tony won by decision" do
  #   joe_and_nate =
  #   expect(khabib_vs_tony(joe_and_nate)).to eq khabib_vs_tony_solution(joe_and_nate)
  # end
  #
  # it "sample test 5: Draw" do
  #   joe_and_nate =
  #   expect(khabib_vs_tony(joe_and_nate)).to eq khabib_vs_tony_solution(joe_and_nate)
  # end

  100.times do
    it "random test" do
      expect(khabib_vs_tony(@joe_and_nate)).to eq khabib_vs_tony_solution(@joe_and_nate)
    end
  end
end
