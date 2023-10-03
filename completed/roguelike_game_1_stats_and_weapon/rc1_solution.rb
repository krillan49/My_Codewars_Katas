module Solution

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
      @log << "#{@name} find '#{weapon_name}'"
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

    def best_weapon # при одинаковом уроне, берем то у которого длиннее название(включая пробелы) тк круче звучит
      @weapon = @bag.max_by{|k, v| [v[4], k.size]}[0]
    end
  end

end
