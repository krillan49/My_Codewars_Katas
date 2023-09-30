# require './khabib_vs_tony'
require './rc1_solution'
require './test_solution'

# include Kata
# include Solution

# ch = Character.new(name: 'Kroker', strength: 15, intelligence: 7)
# p ch.weapon_axe_of_fire(3, 1, 0, 20)
# puts ch.character_info
# p ch.weapon_staff_of_water(1, 0, 2, 50)
# puts ch.character_info
# p ch.stats_strange_fruit(0, 2, -1)
# puts ch.character_info
# ch.weapon_axe_of_fire(1, 2, 1, 10)
# p ch.bag
# puts ch.character_info
# puts ch.event_log

describe "Sample tests" do
  before do
    @sol = Solution::Character.new(name: 'Kroker', strength: 15, intelligence: 7)
    @test = Character.new(name: 'Kroker', strength: 15, intelligence: 7)
  end

  def test2
    @sol.weapon_axe_of_fire(3, 1, 0, 20)
    @test.weapon_axe_of_fire(3, 1, 0, 20)
  end

  def test3
    test2
    @sol.weapon_staff_of_water(1, 0, 2, 50)
    @test.weapon_staff_of_water(1, 0, 2, 50)
  end

  def test4
    test3
    @sol.stats_strange_fruit(0, 2, -1)
    @test.stats_strange_fruit(0, 2, -1)
  end

  def test5
    test4
    @sol.weapon_axe_of_fire(1, 2, 1, 10)
    @test.weapon_axe_of_fire(1, 2, 1, 10)
  end

  it "sample test 1: New character" do
    expect(@sol.character_info).to eq @test.character_info
  end

  it "sample test 2: Character find weapon" do
    test2
    expect(@sol.character_info).to eq @test.character_info
  end

  it "sample test 3: Character find second weapon" do
    test3
    expect(@sol.character_info).to eq @test.character_info
  end

  it "sample test 4: Character stats modifer" do
    test4
    expect(@sol.character_info).to eq @test.character_info
  end

  it "sample test 5: Character enchanced weapon" do
    test5
    expect(@sol.character_info).to eq @test.character_info
  end

  it "sample test 6: Show event log" do
    test5
    expect(@sol.event_log).to eq @test.event_log
  end
end
