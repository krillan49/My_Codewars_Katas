class Character
  attr_reader :name, :hp, :damage, :block_power, :initiative, :skills
  def initialize(player_set = {})
    @name        = player_set[:name] || random_name
    @hp          = player_set[:hp] || rand(50..100)
    @damage      = player_set[:damage] || rand(10..30)
    @block_power = player_set[:block_power] || rand(5..15)
    @initiative  = player_set[:initiative] || rand(1..20)
    @skills      = player_set[:skills] || random_skills
  end

  def random_name
    rand(3..10).times.with_object([]){|_, arr| arr << rand(97..122).chr}.join.capitalize
  end

  def random_skills
    arr = []
    arr << :fast_attack if rand(2) == 1
    arr << :fast_attack if rand(2) == 1
  end
end

p ch = Character.new
p ch1 = Character.new(name: 'Ninja-cyborg', hp: 50, damage: 10, block_power: 10, initiative: 20)
p ch2 = Character.new(name: 'Alien-mutant', hp: 100, damage: 20, block_power: 5, initiative: 5)
