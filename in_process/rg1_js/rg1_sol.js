class Character {
  constructor(obj) {
    this.name         = obj.name || 'Hero'
    this.strength     = obj.strength || 10
    this.dexterity    = obj.dexterity || 10
    this.intelligence = obj.intelligence || 10
    this.bag          = {limbs: [1, 1, 1, 0, this.strength + this.dexterity + this.intelligence]}
    this.enhanced     = []
    this.equipWeapon  = 'limbs'
    this.log          = []
    return new Proxy(this, {
      get(t, p) {
        if (p in t) return t[p];
        if (typeof t.__noSuchMethod__ == "function") return function(...args){ return t.__noSuchMethod__.call(t, p, args); };
      }
    });
  }
  characterInfo() {
    var e = this.enhanced.includes(this.equipWeapon) ? '(enhanced)' : '';
    return `${this.name}\nstr ${this.strength}\ndex ${this.dexterity}\nint ${this.intelligence}\n${this.equipWeapon}${e} ${this.bag[this.equipWeapon][4]} dmg`;
  }
  eventLog() {
    return this.log.join(`\n`);
  }
  __noSuchMethod__(method, args) {
    var name = method.replace(/([a-z])([A-Z])/g,'$1 $2').toLowerCase();
    name = name[0].toUpperCase() + name.slice(1);
    name.includes(' of ') ? this.weapon(name, args) : this.stats(name, args);
  }
  weapon(weaponName, dmg) {
    //   if @bag[weapon_name] # берем макс характеристики из обоих если попалось одинаковое оружие
    //     old = @bag[weapon_name]
    //     dmg = old[0..-2].zip(dmg).map(&:max)
    //     @enhanced << weapon_name
    //   end
    this.bag[weaponName] = dmg.concat([dmg[0] * this.strength + dmg[1] * this.dexterity + dmg[2] * this.intelligence + dmg[3]]);
    // bestWeapon()
    this.log.push(`${this.name} find '${weaponName}'`);
  }
  stats(eventName, stats) {
    //   @strength     += stats[0]
    //   @dexterity    += stats[1]
    //   @intelligence += stats[2]
    //   weapons_adjustment
    //   best_weapon
    //   changes = [['strength', stats[0]], ['dexterity', stats[1]], ['intelligence', stats[2]]]
    //   .reject{|a| a[1] == 0}.map{|a| a[1].positive? ? a.join(' +') : a.join(' ')}.join(', ')
    //   @log << "#{event_name}: #{changes}"
  }

  // def weapons_adjustment
  //   @bag.each{|k, v| @bag[k] = v[0..3] + [v[0] * @strength + v[1] * @dexterity + v[2] * @intelligence + v[3]]}
  // end
  //
  // def best_weapon # при одинаковом уроне, берем то у которого длиннее название(включая пробелы) тк круче звучит
  //   @weapon = @bag.min_by{|k, v| [-v[4], k]}[0]
  // end
}

var ch = new Character({name: 'Kroker', strength: 15, intelligence: 7});
// console.log(ch.characterInfo());
console.log(ch.axeOfFire(3, 1, 0, 20));
console.log(ch.bag);
console.log(ch.eventLog());
// # p ch.character_info
// # ch.staff_of_water(1, 0, 2, 50)
// # p ch.character_info
// # ch.strange_fruit(0, 2, -1)
// # p ch.character_info
// # ch.axe_of_fire(1, 2, 1, 10)
// # p ch.character_info
