const chai = require("chai");
const assert = chai.assert;
chai.config.truncateThreshold=0;

describe("Sample tests", () => {

  it("sample test 1: New character", () => {
    const test = new Character({name: 'Kroker', strength: 15, intelligence: 7});
    const res = `Kroker\nstr 15\ndex 10\nint 7\nlimbs 32 dmg`;
    assert.strictEqual(test.characterInfo(), res);
  });

  it("sample test 2: Character finds weapon", () => {
    const test = new Character({name: 'Kroker', strength: 15, intelligence: 7});
    test.axeOfFire(3, 1, 0, 20);
    const res = `Kroker\nstr 15\ndex 10\nint 7\nAxe of fire 75 dmg`;
    assert.strictEqual(test.characterInfo(), res);
  });

  it("sample test 3: Character finds second weapon", () => {
    const test = new Character({name: 'Kroker', strength: 15, intelligence: 7});
    test.axeOfFire(3, 1, 0, 20);
    test.staffOfWater(1, 0, 2, 60);
    const res = `Kroker\nstr 15\ndex 10\nint 7\nStaff of water 89 dmg`;
    assert.strictEqual(test.characterInfo(), res);
  });

  it("sample test 4: Character enchanced weapon", () => {
    const test = new Character({name: 'Kroker', strength: 15, intelligence: 7});
    test.axeOfFire(3, 1, 0, 20);
    test.staffOfWater(1, 0, 2, 60);
    test.axeOfFire(1, 2, 1, 10);
    const res = `Kroker\nstr 15\ndex 10\nint 7\nAxe of fire(enhanced) 92 dmg`;
    assert.strictEqual(test.characterInfo(), res);
  });

  it("sample test 5: Character stats modifer", () => {
    const test = new Character({name: 'Kroker', strength: 15, intelligence: 7});
    test.axeOfFire(3, 1, 0, 20);
    test.staffOfWater(1, 0, 2, 60);
    test.axeOfFire(1, 2, 1, 10);
    test.strangeFruit(-2, 0, 2);
    const res = `Kroker\nstr 13\ndex 10\nint 9\nStaff of water 91 dmg`;
    assert.strictEqual(test.characterInfo(), res);
  });

  it("sample test 6: Show event log", () => {
    const test = new Character({name: 'Kroker', strength: 15, intelligence: 7});
    test.axeOfFire(3, 1, 0, 20);
    test.staffOfWater(1, 0, 2, 60);
    test.axeOfFire(1, 2, 1, 10);
    test.strangeFruit(-2, 0, 2);
    const res = `Kroker finds 'Axe of fire'\nKroker finds 'Staff of water'\nKroker finds 'Axe of fire'\nStrange fruit: strength -2, intelligence +2`;
    assert.strictEqual(test.eventLog(), res);
  });

  it("sample test 7: Character change stat to zero", () => {
    const test = new Character({name: 'Pinky', strength: 5, dexterity: 5, intelligence: 5});
    test.strangeFruit(0, 2, -1);
    test.ancientBook(2, 1, -2);
    test.ancientBook(2, 1, -2);
    const res = `Pinky\nstr 9\ndex 9\nint 0\nlimbs 18 dmg`;
    assert.strictEqual(test.characterInfo(), res);
  });

  it("sample test 8: Pick the correct weapon in case of equal damages", () => {
    const test = new Character({name: 'Porky', strength: 15, intelligence: 7});
    test.pillarOfWater(4, 1, 2, 60);
    test.axeOfFire(3, 1, 2, 20);
    test.dunderOfWater(0, 2, 0, 1);
    test.axeOfFire(4, 0, 1, 60);
    test.staffOfWater(4, 1, 2, 60);
    const res = `Porky\nstr 15\ndex 10\nint 7\nAxe of fire(enhanced) 144 dmg`;
    assert.strictEqual(test.characterInfo(), res);
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
      if (this.bag[weaponName]) {
        let old = this.bag[weaponName].slice(0, 4);
        dmg = [Math.max(old[0], dmg[0]), Math.max(old[1], dmg[1]), Math.max(old[2], dmg[2]), Math.max(old[3], dmg[3])];
        this.enhanced.push(weaponName);
      }
      this.bag[weaponName] = dmg.concat([dmg[0] * this.strength + dmg[1] * this.dexterity + dmg[2] * this.intelligence + dmg[3]]);
      this.bestWeapon();
      this.log.push(`${this.name} finds '${weaponName}'`);
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
    bestWeapon() {
      let maxDamage = Object.values(this.bag).sort((a, b) => b[4] - a[4])[0][4];
      this.equipWeapon = Object.keys(this.bag).filter(k => this.bag[k][4] == maxDamage).sort()[0];
    }
  };

  // chars & events for check
  function randomWord() {
    let rand = Math.floor(Math.random()*8)+3;
    let word = '';
    while (rand > 0) {
      let randForChar = Math.floor(Math.random()*26)+97;
      word += String.fromCharCode(randForChar);
      rand--;
    }
    return word;
  }

  function startChar() {
    let stats = ['strength', 'dexterity', 'intelligence'];
    let charObj = {};
    let rand = Math.floor(Math.random()*3)+1;
    while (rand > 0) {
      let i = Math.floor(Math.random()*stats.length);
      let stat = stats.splice(i, 1);
      charObj[stat] = Math.floor(Math.random()*11)+5;
      rand--;
    }
    let rw = randomWord()
    // charObj.name = rw[0].toUpperCase() + rw.slice(1)
    if (Math.floor(Math.random()*11) < 9) charObj.name = rw[0].toUpperCase() + rw.slice(1);
    return charObj;
  }

  function events() { // 2d array of events
    let rand = Math.floor(Math.random()*16)+5;
    let arr = [];
    while (rand > 0) {
      let event = ['weapon', 'stats'][Math.floor(Math.random()*2)];
      if (event == 'weapon') {
        let type = ['sword', 'axe', 'mace', 'spear', 'staff'][Math.floor(Math.random()*5)];
        let element = ['fire', 'water', 'ice', 'light', 'dark', randomWord()][Math.floor(Math.random()*6)];
        var res = type + 'Of' + element[0].toUpperCase() + element.slice(1);
        var values = [
          Math.floor(Math.random()*7), Math.floor(Math.random()*7),
          Math.floor(Math.random()*7), Math.floor(Math.random()*101)
        ];
      } else {
        let type = ['strange', 'horrible', 'ancient', 'magical'][Math.floor(Math.random()*4)];
        let element = ['fruit', 'blessing', 'curse', 'book', 'elixir', randomWord()][Math.floor(Math.random()*6)];
        var res = type + element[0].toUpperCase() + element.slice(1);
        var values = [Math.floor(Math.random()*5)-2, Math.floor(Math.random()*5)-2, Math.floor(Math.random()*5)-2];
      }
      arr.push([res, values]);
      rand--;
    }
    return arr;
  }

  // tests
  for (let n = 1; n <= 50; n++) {
    describe(`Character ${n}`, () => {
      // chars
      let charStart = startChar();
      let sol = new CharForTest(charStart);
      let test = new Character(charStart);
      let evs = events();
      // events
      for (let i = 0; i < evs.length; i++){
        it(`info test ${i+1}`, () => {
          let event = evs[i][0], values = evs[i][1];
          sol[event](...values);
          test[event](...values);

          if (n > 40 && Math.floor(Math.random()*10) == 0){ // additional check for sorting by name
            let dmgs = Object.values(sol.bag).sort((a, b) => b[4] - a[4])[0].slice(0, 4);
            let wname = ['ahlspiessOfAbc', 'voulgeOfAbc'][Math.floor(Math.random()*2)];
            sol[wname](...dmgs);
            test[wname](...dmgs);
          }

          assert.strictEqual(test.characterInfo(), sol.characterInfo());
        });
      }

      it(`log test`, () => {
        assert.strictEqual(test.eventLog(), sol.eventLog());
      });
    });
  }
  // for (let n = 1; n <= 50; n++) {
  //   // chars
  //   let charStart = startChar();
  //   let sol = new CharForTest(charStart);
  //   let test = new Character(charStart);
  //   // events
  //   events().forEach(arr => {
  //     let event = arr[0], values = arr[1];
  //     sol[event](...values);
  //     test[event](...values);
  //   });
  //
  //   it(`info test ${n}`, () => {
  //     assert.strictEqual(test.characterInfo(), sol.characterInfo());
  //   });
  //
  //   it(`log test ${n}`, () => {
  //     assert.strictEqual(test.eventLog(), sol.eventLog());
  //   });
  // }

});
