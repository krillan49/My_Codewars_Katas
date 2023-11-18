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
    let e = this.enhanced.includes(this.equipWeapon) ? '(enhanced)' : '';
    return `${this.name}\nstr ${this.strength}\ndex ${this.dexterity}\nint ${this.intelligence}\n${this.equipWeapon}${e} ${this.bag[this.equipWeapon][4]} dmg`;
  }
  eventLog() {
    return this.log.join(`\n`);
  }
  __noSuchMethod__(method, args) {
    let name = method.replace(/([a-z])([A-Z])/g,'$1 $2').toLowerCase();
    name = name[0].toUpperCase() + name.slice(1);
    name.includes(' of ') ? this.weapon(name, args) : this.stats(name, args);
  }
  weapon(weaponName, dmg) {
    if (this.bag[weaponName]) { // берем макс характеристики из обоих если попалось одинаковое оружие
      let old = this.bag[weaponName].slice(0, 4);
      dmg = [Math.max(old[0], dmg[0]), Math.max(old[1], dmg[1]), Math.max(old[2], dmg[2]), Math.max(old[3], dmg[3])];
      this.enhanced.push(weaponName);
    }
    this.bag[weaponName] = dmg.concat([dmg[0] * this.strength + dmg[1] * this.dexterity + dmg[2] * this.intelligence + dmg[3]]);
    this.bestWeapon();
    this.log.push(`${this.name} find '${weaponName}'`);
  }
  stats(eventName, stats) {
    this.strength     += stats[0];
    this.dexterity    += stats[1];
    this.intelligence += stats[2];
    this.weaponsAdjustment();
    this.bestWeapon();
    let changes = [['strength', stats[0]], ['dexterity', stats[1]], ['intelligence', stats[2]]]
    .filter(a => a[1] != 0).map(a => a[1] > 0 ? a.join(' +') : a.join(' ')).join(', ');
    this.log.push(`${eventName}: ${changes}`);
  }
  weaponsAdjustment() {
    for (let k in this.bag){
      let v = this.bag[k];
      this.bag[k] = v.slice(0, 4).concat([v[0] * this.strength + v[1] * this.dexterity + v[2] * this.intelligence + v[3]]);
    }
  }
  bestWeapon() { // при одинаковом уроне, берем по названию в алфавитном порядке
    let maxDamage = Object.values(this.bag).sort((a, b) => b[4] - a[4])[0][4];
    this.equipWeapon = Object.keys(this.bag).filter(k => this.bag[k][4] == maxDamage).sort()[0];
  }
}

const test = new Character({name: 'Pinky', strength: 5, dexterity: 5, intelligence: 5});
test.strangeFruit(0, 2, -1);
test.ancientBook(2, 1, -2);
test.ancientBook(2, 1, -2);
// console.log(test.characterInfo());
// console.log(test.intelligence);

// const ch = new Character({name: 'Kroker', strength: 15, intelligence: 7});
// console.log(ch.characterInfo());
// ch.axeOfFire(3, 1, 0, 20);
// console.log(ch.characterInfo());
// ch.staffOfWater(1, 0, 2, 50);
// console.log(ch.characterInfo());
// ch.strangeFruit(0, 2, -1);
// console.log(ch.characterInfo());
// ch.axeOfFire(1, 2, 1, 10);
// console.log(ch.bag);
// console.log(ch.characterInfo());
// console.log(ch.eventLog());
