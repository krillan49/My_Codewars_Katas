const chai = require("chai");
const assert = chai.assert;
chai.config.truncateThreshold=0;

describe("Sample tests", () => {

  it("sample test 1: New character", () => {
    var test = new Character({name: 'Kroker', strength: 15, intelligence: 7});
    var res = `Kroker\nstr 15\ndex 10\nint 7\nlimbs 32 dmg`;
    assert.strictEqual(test.characterInfo(), res);
  });

  it("sample test 2: Character find weapon", () => {
    var test = new Character({name: 'Kroker', strength: 15, intelligence: 7});
    test.axeOfFire(3, 1, 0, 20);
    var res = `Kroker\nstr 15\ndex 10\nint 7\nAxe of fire 75 dmg`;
    assert.strictEqual(test.characterInfo(), res);
  });

  it("sample test 3: Character find second weapon", () => {
    var test = new Character({name: 'Kroker', strength: 15, intelligence: 7});
    test.axeOfFire(3, 1, 0, 20);
    test.staffOfWater(1, 0, 2, 50);
    var res = `Kroker\nstr 15\ndex 10\nint 7\nStaff of water 79 dmg`;
    assert.strictEqual(test.characterInfo(), res);
  });

  it("sample test 4: Character stats modifer", () => {
    var test = new Character({name: 'Kroker', strength: 15, intelligence: 7});
    test.axeOfFire(3, 1, 0, 20);
    test.staffOfWater(1, 0, 2, 50);
    test.strangeFruit(0, 2, -1);
    var res = `Kroker\nstr 15\ndex 12\nint 6\nAxe of fire 77 dmg`;
    assert.strictEqual(test.eventLog(), res);
  });

  it("sample test 5: Character enchanced weapon", () => {
    var test = new Character({name: 'Kroker', strength: 15, intelligence: 7});
    test.axeOfFire(3, 1, 0, 20);
    test.staffOfWater(1, 0, 2, 50);
    test.strangeFruit(0, 2, -1);
    test.axeOfFire(1, 2, 1, 10);
    var res = `Kroker\nstr 15\ndex 12\nint 6\nAxe of fire(enhanced) 95 dmg`;
    assert.strictEqual(test.characterInfo(), res);
  });

  it("sample test 6: Show event log", () => {
    var test = new Character({name: 'Kroker', strength: 15, intelligence: 7});
    test.axeOfFire(3, 1, 0, 20);
    test.staffOfWater(1, 0, 2, 50);
    test.strangeFruit(0, 2, -1);
    test.axeOfFire(1, 2, 1, 10);
    var res = `Kroker find 'Axe of fire'\nKroker find 'Staff of water'\nStrange fruit: dexterity +2, intelligence -1\nKroker find 'Axe of fire'`;
    assert.strictEqual(khabibVsTony(joAndNate), res);
  });

});

describe("Random tests", () => {
  // solution for check
  class CharForTest {
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
      if (this.bag[weaponName]) {
        var old = this.bag[weaponName].slice(0, 4);
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
      var changes = [['strength', stats[0]], ['dexterity', stats[1]], ['intelligence', stats[2]]]
      .filter(a => a[1] != 0).map(a => a[1] > 0 ? a.join(' +') : a.join(' ')).join(', ');
      this.log.push(`${eventName}: ${changes}`);
    }
    weaponsAdjustment() {
      for (var k in this.bag){
        var v = this.bag[k];
        this.bag[k] = v.slice(0, 4).concat([v[0] * this.strength + v[1] * this.dexterity + v[2] * this.intelligence + v[3]]);
      }
    }
    bestWeapon() {
      var maxDamage = Object.values(this.bag).sort((a, b) => b[4] - a[4])[0][4];
      this.equipWeapon = Object.keys(this.bag).filter(k => this.bag[k][4] == maxDamage).sort()[0];
    }
  };

  // chars & events for check
  function randomWord() {
    var rand = Math.floor(Math.random()*8)+3;
    var word = '';
    while (rand > 0) {
      var randForChar = Math.floor(Math.random()*26)+97;
      word += String.fromCharCode(randForChar);
      rand--;
    }
    return word;
  }

  function startChar() {
    var stats = ['strength', 'dexterity', 'intelligence'];
    var charObj = {};
    var rand = Math.floor(Math.random()*3)+1;
    while (rand > 0) {
      var i = Math.floor(Math.random()*stats.length);
      var stat = stats.splice(i, 1);
      charObj[stat] = Math.floor(Math.random()*11)+5;
      rand--;
    }
    var rw = randomWord()
    charObj.name = rw[0].toUpperCase() + rw.slice(1)
    return charObj;
  }

  // ...

  // before do
  //
  //   # hash of events
  //   events = rand(5..20).times.with_object([]) do |_, arr|
  //     event = %w[weapon stats].sample
  //     if event == 'weapon'
  //       type = %w[sword axe mace spear staff].sample
  //       element = (%w[fire water ice light dark] + [random_word]).sample
  //       res = type + '_of_' + element
  //       values = [rand(6), rand(6), rand(6), rand(100)]
  //     else
  //       type = %w[strange horrible ancient magical].sample
  //       element = (%w[fruit blessing curse book elixir] + [random_word]).sample
  //       res = type + '_' + element
  //       values = [rand(-2..2), rand(-2..2), rand(-2..2)]
  //     end
  //     arr << [res, values]
  //   end

  //   # start events
  //   events.each do |event, values|
  //     @sol.send(event, *values)
  //     @test.send(event, *values)
  //   end

  // end

  // tests
  for (let n = 1; n <= 50; n++) {

    var charStart = startChar();
    var sol = new CharForTest(charStart);
    var test = new Character(charStart);
    //   it "info test #{n+1}" do
    //     expect(@test.character_info).to eq @sol.character_info
    //   end
    //   it "log test #{n+1}" do
    //     expect(@test.event_log).to eq @sol.event_log
    //   end

    it(`random test ${n}`, () => {
      var s = kataHelper();
      assert.strictEqual(khabibVsTony(s), solution(s));
      // assert.strictEqual(khabibVsTony(s), solution(s), `Testing for: ${JSON.stringify(s)}`);
      // JSON.stringify(s) - выводит ввод
    });
  }

});
