#  Если зарандомится одинаковое оружие итд ??
#  Перераспределение урона оружий в сумке в зависимости от апов

class Character
  attr_reader :name, :strength, :dexterity, :intelligence, :bag, :weapon # это уберется, тк смотрим через инфо

  def initialize(**kwargs)
    @name         = kwargs[:name]
    @strength     = kwargs[:strength] || 10
    @dexterity    = kwargs[:dexterity] || 10
    @intelligence = kwargs[:intelligence] || 10
    @bag          = {'limbs' => [1, 1, 1, 0, @strength + @dexterity + @intelligence]}
    @weapon       = 'limbs'
  end

  def character_info
    "#{@name}\nstr #{@strength}\ndex #{@dexterity}\nint #{@intelligence}\n#{@weapon} #{@bag[@weapon][4]}dmg"
  end

  def method_missing(method, *args)
    event = method.to_s.split('_')
    event_name = event[1..-1].join(' ').capitalize
    send(event[0], event_name, args)
  end

  private

  def weapon(weapon_name, dmg)
    @bag[weapon_name] = dmg + [dmg[0] * @strength + dmg[1] * @dexterity + dmg[2] * @intelligence + dmg[3]]
    # p @bag
    @weapon = @bag.max_by{|k, v| v[4]}[0]
    "#{@name} find '#{weapon_name}'"
  end
end

ch = Character.new(name: 'Kroker', strength: 15, dexterity: 8, intelligence: 7)
# p [ch.name, ch.strength, ch.dexterity, ch.intelligence]
p ch.weapon_axe_of_fire(3, 1, 0, 20)
puts ch.character_info
