class Character
  attr_reader :name, :hp, :damage, :initiative
  def initialize(player_set = {})
    @name       = player_set[:name] || random_name
    @hp         = player_set[:hp] || rand(50..100)
    @damage     = player_set[:damage] || rand(10..30)
    @initiative = player_set[:initiative] || rand(5..30)
  end

  def random_name
    rand(3..10).times.with_object([]){|_, arr| arr << rand(97..122).chr}.join.capitalize
  end
end

p ch = Character.new
p ch1 = Character.new(name: 'Ninja-cyborg', hp: 50, damage: 10, initiative: 30)
p ch2 = Character.new(name: 'Alien-mutant', hp: 100, damage: 20, initiative: 5)
