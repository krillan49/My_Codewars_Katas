require './rc1_solution'
require './test_solution'


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


describe "Random tests" do
  def random_word
    rand(3..10).times.with_object([]){|_, arr| arr << rand(97..122).chr}.join
  end

  before do
    # start stats
    stats, char_start = [:strength, :dexterity, :intelligence], []
    rand(1..3).times do
      stats.shuffle!
      char_start << stats.pop
    end
    char_start = char_start.map{|st| [st, rand(5..15)]}.to_h
    # name
    char_start[:name] = random_word.capitalize
    # obj
    @sol = Solution::Character.new(**char_start)
    @test = Character.new(**char_start)
    # hash of events
    events = rand(5..20).times.with_object([]) do |_, arr|
      event = %w[weapon stats].sample
      if event == 'weapon'
        type = %w[sword axe mace spear staff].sample
        element = (%w[fire water ice light dark] + [random_word]).sample
        res = type + '_of_' + element
        values = [rand(6), rand(6), rand(6), rand(100)]
      else
        res = (%w[strange_fruit blessing curse ancient_book elixir] + [random_word]).sample
        values = [rand(-2..2), rand(-2..2), rand(-2..2)]
      end
      arr << [res, values]
    end
    # start events
    events.each do |event, values|
      @sol.send(event, *values)
      @test.send(event, *values)
    end
  end

  50.times do |n|
    it "info test #{n+1}" do
      expect(@sol.character_info).to eq @test.character_info
    end
    it "log test #{n+1}" do
      expect(@sol.event_log).to eq @test.event_log
    end
  end
end
