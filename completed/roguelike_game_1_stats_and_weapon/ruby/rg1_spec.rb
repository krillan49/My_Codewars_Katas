require './rg1_solution'
require './test_solution'


describe "Sample tests" do
  before do
    @test = Character.new(name: 'Kroker', strength: 15, intelligence: 7)
  end

  def test2
    @test.axe_of_fire(3, 1, 0, 20)
  end

  def test3
    test2
    @test.staff_of_water(1, 0, 2, 60)
  end

  def test4
    test3
    @test.axe_of_fire(1, 2, 1, 10)
  end

  def test5
    test4
    @test.strange_fruit(-2, 0, 2)
  end

  it "sample test 1: New character" do
    res = "Kroker\nstr 15\ndex 10\nint 7\nlimbs 32 dmg"
    expect(@test.character_info).to eq res
  end

  it "sample test 2: Character finds weapon" do
    test2
    res = "Kroker\nstr 15\ndex 10\nint 7\nAxe of fire 75 dmg"
    expect(@test.character_info).to eq res
  end

  it "sample test 3: Character finds second weapon" do
    test3
    res = "Kroker\nstr 15\ndex 10\nint 7\nStaff of water 89 dmg"
    expect(@test.character_info).to eq res
  end

  it "sample test 4: Character enchanced weapon" do
    test4
    res = "Kroker\nstr 15\ndex 10\nint 7\nAxe of fire(enhanced) 92 dmg"
    expect(@test.character_info).to eq res
  end

  it "sample test 5: Character stats modifer" do
    test5
    res = "Kroker\nstr 13\ndex 10\nint 9\nStaff of water 91 dmg"
    expect(@test.character_info).to eq res
  end

  it "sample test 6: Show event log" do
    test5
    res = "Kroker finds 'Axe of fire'\nKroker finds 'Staff of water'\nKroker finds 'Axe of fire'\nStrange fruit: strength -2, intelligence +2"
    expect(@test.event_log).to eq res
  end

  it "sample test 7: Pick the correct weapon in case of equal damages" do
    ch = Character.new(name: 'Porky', strength: 15, intelligence: 7)
    ch.pillar_of_water(4, 1, 2, 60)
    ch.axe_of_fire(3, 1, 2, 20)
    ch.dunder_of_water(0, 2, 0, 1)
    ch.axe_of_fire(4, 0, 1, 60)
    ch.staff_of_water(4, 1, 2, 60)
    res = "Porky\nstr 15\ndex 10\nint 7\nAxe of fire(enhanced) 144 dmg"
    expect(ch.character_info).to eq res
  end
end

def random_word
  rand(3..10).times.with_object([]){|_, arr| arr << rand(97..122).chr}.join
end

def start_char
  stats, char_start = [:strength, :dexterity, :intelligence], []
  rand(1..3).times do
    stats.shuffle!
    char_start << stats.pop
  end
  char_start = char_start.map{|st| [st, rand(5..15)]}.to_h
  char_start[:name] = random_word.capitalize if rand(6) < 5
  char_start
end

def events
  events = rand(5..20).times.with_object([]) do |_, arr|
    event = %w[weapon stats].sample
    if event == 'weapon'
      type = %w[sword axe mace spear staff].sample
      element = (%w[fire water ice light dark] + [random_word]).sample
      res = type + '_of_' + element
      values = [rand(6), rand(6), rand(6), rand(100)]
    else
      type = %w[strange horrible ancient magical].sample
      element = (%w[fruit blessing curse book elixir] + [random_word]).sample
      res = type + '_' + element
      values = [rand(-2..2), rand(-2..2), rand(-2..2)]
    end
    arr << [res, values]
  end
end

describe "Random tests" do

  # before do
  #   # start stats
  #   stats, char_start = [:strength, :dexterity, :intelligence], []
  #   rand(1..3).times do
  #     stats.shuffle!
  #     char_start << stats.pop
  #   end
  #   char_start = char_start.map{|st| [st, rand(5..15)]}.to_h
  #   # name
  #   # char_start[:name] = random_word.capitalize
  #   char_start[:name] = random_word.capitalize if rand(6) < 5
  #   # obj
  #   @sol = Solution::Character.new(**char_start)
  #   @test = Character.new(**char_start)
  #   # hash of events
  #   events = rand(5..20).times.with_object([]) do |_, arr|
  #     event = %w[weapon stats].sample
  #     if event == 'weapon'
  #       type = %w[sword axe mace spear staff].sample
  #       element = (%w[fire water ice light dark] + [random_word]).sample
  #       res = type + '_of_' + element
  #       values = [rand(6), rand(6), rand(6), rand(100)]
  #     else
  #       type = %w[strange horrible ancient magical].sample
  #       element = (%w[fruit blessing curse book elixir] + [random_word]).sample
  #       res = type + '_' + element
  #       values = [rand(-2..2), rand(-2..2), rand(-2..2)]
  #     end
  #     arr << [res, values]
  #   end
  #   # start events
  #   events.each do |event, values|
  #     @sol.send(event, *values)
  #     @test.send(event, *values)
  #   end
  # end
  #
  # 50.times do |n|
  #   it "info test #{n+1}" do
  #     expect(@test.character_info).to eq @sol.character_info
  #   end
  #   it "log test #{n+1}" do
  #     expect(@test.event_log).to eq @sol.event_log
  #   end
  # end

  50.times do |n|
    describe "Character #{n+1}" do
      before(:all) do
        char_start = start_char
        @sol = Solution::Character.new(**char_start)
        @test = Character.new(**char_start)
      end

      events.each.with_index(1) do |(event, values), i|
        it "info test #{i}" do
          @sol.send(event, *values)
          @test.send(event, *values)
          # if n > 40 && rand(10) == 0
          #   dmgs = @sol.bag.max_by{|_,v| v[4]}[1][0..3]
          #   wname = ['ahlspiess_of_abc', 'voulge_of_abc'].sample
          #   @sol.send(wname, *dmgs)
          #   @test.send(wname, *dmgs)
          # end
          expect(@test.character_info).to eq @sol.character_info
        end
      end

      it "log test" do
        expect(@test.event_log).to eq @sol.event_log
      end
    end
  end

end
