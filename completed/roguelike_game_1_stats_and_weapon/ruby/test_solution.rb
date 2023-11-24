class Character
  def initialize(**kwargs)
    @name         = kwargs[:name] || 'Hero'
    @strength     = kwargs[:strength] || 10
    @dexterity    = kwargs[:dexterity] || 10
    @intelligence = kwargs[:intelligence] || 10
    @bag          = {'limbs' => [1, 1, 1, 0, @strength + @dexterity + @intelligence]}
    @enhanced     = []
    @weapon       = 'limbs'
    @log          = []
  end

  def character_info
    e = @enhanced.include?(@weapon) ? '(enhanced)' : ''
    "#{@name}\nstr #{@strength}\ndex #{@dexterity}\nint #{@intelligence}\n#{@weapon}#{e} #{@bag[@weapon][4]} dmg"
  end

  def event_log
    @log.join("\n")
  end

  def method_missing(method, *args)
    name = method.to_s.split('_').join(' ').capitalize
    method.to_s.include?('_of_') ? weapon(name, args) : stats(name, args)
  end

  private

  def weapon(weapon_name, dmg)
    if @bag[weapon_name] # берем макс характеристики из обоих если попалось одинаковое оружие
      old = @bag[weapon_name]
      dmg = old[0..-2].zip(dmg).map(&:max)
      @enhanced << weapon_name
    end
    @bag[weapon_name] = dmg + [dmg[0] * @strength + dmg[1] * @dexterity + dmg[2] * @intelligence + dmg[3]]
    best_weapon
    @log << "#{@name} finds '#{weapon_name}'"
  end

  def stats(event_name, stats)
    @strength     += stats[0]
    @dexterity    += stats[1]
    @intelligence += stats[2]
    weapons_adjustment
    best_weapon
    changes = [['strength', stats[0]], ['dexterity', stats[1]], ['intelligence', stats[2]]]
    .reject{|a| a[1] == 0}.map{|a| a[1].positive? ? a.join(' +') : a.join(' ')}.join(', ')
    @log << "#{event_name}: #{changes}"
  end

  def weapons_adjustment
    @bag.each{|k, v| @bag[k] = v[0..3] + [v[0] * @strength + v[1] * @dexterity + v[2] * @intelligence + v[3]]}
  end

  def best_weapon # при одинаковом уроне, берем по названию в алфавитном порядке
    @weapon = @bag.min_by{|k, v| [-v[4], k]}[0]
  end
end

# ch = Character.new(name: 'Kroker', strength: 15, intelligence: 7)
# p ch.character_info
# ch.axe_of_fire(3, 1, 0, 20)
# p ch.character_info
# p '---------'
# ch.staff_of_water(1, 0, 2, 60)
# p ch.character_info
# p '---------'
# ch.axe_of_fire(1, 2, 1, 10)
# p ch.character_info
# p '---------'
# ch.strange_fruit(-2, 0, 2)
# p ch.bag
# p ch.character_info
# p '---------'
# p ch.event_log

# def random_word
#   rand(3..10).times.with_object([]){|_, arr| arr << rand(97..122).chr}.join
# end
#
# stats, char_start = [:strength, :dexterity, :intelligence], []
# rand(1..3).times do
#   stats.shuffle!
#   char_start << stats.pop
# end
# char_start = char_start.map{|st| [st, rand(5..15)]}.to_h
# char_start[:name] = random_word.capitalize
# p @test = Character.new(**char_start)
#
# events = rand(5..10).times.with_object([]) do |_, arr|
#   event = %w[weapon stats].sample
#   if event == 'weapon'
#     type = %w[sword axe mace spear staff].sample
#     element = (%w[fire water ice light dark] + [random_word]).sample
#     res = type + '_of_' + element
#     values = [rand(6), rand(6), rand(6), rand(100)]
#   else
#     res = (%w[strange_fruit blessing curse ancient_book elixir] + [random_word]).sample
#     values = [rand(-2..2), rand(-2..2), rand(-2..2)]
#   end
#   arr << [res, values]
# end
#
# p events
#
# events.each{|event, values| @test.send(event, *values)}
#
# puts @test.character_info
# p '----------------'
# puts @test.event_log
