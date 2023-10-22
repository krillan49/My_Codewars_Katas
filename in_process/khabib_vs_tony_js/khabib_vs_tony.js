const chai = require("chai");
const assert = chai.assert;
chai.config.truncateThreshold=0;

describe("Sample tests", () => {
  it("sample test 1: Khabib won by KO", () => {
    var joAndNate = "First round! The fighters are in the center, Khabib delivers a power jab! and immediately OVERHAND! Tony felt it. Ferguson tries to break the distance with a kick, but another OVERHAND! Tony staggers. Takedown, Khabib easily moved the shocked opponent, trying to make a submission, but Tony's jiujitsu works. Hammerfist, HAMMERFIST, HAMMERFIST! Tony's doing bad, he can only try to survive. Hammerfist! HAMMERFIST! HAMMERFIST! HAMMERFIST! HAMMERFIST! Ferguson sweeps and slides out, all is not lost for him! He is shaking, can he survive until the end of the round? Khabib clamps down on his jab. Jab!, OVERHAND! Knockout!!! Incredible domination, I did not expect such an easy victory for Khabib."
    assert.strictEqual(tripleX(joAndNate),'Khabib won by KO');
  })
  it("sample test 2: Tony won by submission", () => {
    var joAndNate = "Khabib tries to pull Tony to the cage, hits the jab, but misses. ELBOW! from the turn, how did he catch him! Khabib backs away like he's shocked and got a cut above his eye, blood starts to fill his eye, Tony is chasing, kick! More KICK, PUNCH! ELBOW! More PUNCH, Khabib got another cut, his whole face is in blood, he can't see anything. Khabib does a takedown and Tony closes the guard. Khabib tries to hit, but he sees almost nothing, bumps into an ELBOW! ELBOW! ELBOW! Another ELBOW! New cuts, Khabib's face becomes like a bloody mask. Tony throws a triangle, tightens, it looks like Khabib passed out, excellent submission. Yes, Tony is horrendous, the real El Cucuy."
    assert.strictEqual(tripleX(joAndNate),'Tony won by submission');
  })
  it("sample test 3: Khabib won by TKO", () => {
    var joAndNate = `Khabib starts with a jab, Tony kicks back, another jab, OVERHAND! Tony backs to the cage. Khabib corners Ferguson, takedown. Tony tries to get out but gives back, hammerfist, HAMMERFIST, HAMMERFIST! Tony rolls over and Khabib keeps hitting him with the mount, hammerfist, HAMMERFIST, HAMMERFIST! Ferguson hits with an elbow, tries to twist and improve his position, but to no avail, hammerfist, HAMMERFIST, HAMMERFIST! Siren round is over. Khabib confidently took him 10 - 9.
    Second round. Tony starts with a kick, punch, another kick, not a bad start. Imanari roll!? Why did he do it? Tony is on the bottom again, that was stupid. Khabib went back to hammering hammerfist after hammerfist, more HAMMERFIST! It looks like the error was critical. HAMMERFIST, HAMMERFIST, HAMMERFIST, HAMMERFIST, HAMMERFIST, HAMMERFIST. Tony doesn't actively defend, Big John stops the fight.`
    assert.strictEqual(tripleX(joAndNate),'Khabib won by TKO');
  })
  it("sample test 4: Tony won by decision", () => {
    var joAndNate = "It looks like the score is equal, everything will be decided by the last round. Khabib comes up with a jab, Tony hits back with a kick, another kick, Khabib catches his leg, he can’t go down, Tony hits with an elbow, another elbow. Khabib makes another attempt to move into the fight, again unsuccessfully, it seems Tony retained more strength at the end of the fight. Jab, kick, punch. These middle exchanges are clearly in favor of Tony. Khabib closes in, takedown, Tony in guard, he defends well, gets a hammerfist, but immediately responds with an elbow. Siren, let's see what the judges say."
    assert.strictEqual(tripleX(joAndNate),'Tony won by decision');
  })
  it("sample test 5: Draw", () => {
    var joAndNate = "It looks like the score is equal, everything will be decided by the last round. Khabib comes up with a jab, Tony hits back with a kick, another kick, Khabib catches his leg, he can’t go down, Tony hits with an elbow, another elbow. Khabib makes another attempt to move into the fight, again unsuccessfully, it seems Tony retained more strength at the end of the fight. Jab, kick, punch. These middle exchanges are clearly in favor of Tony. Khabib closes in, takedown, Tony is on guard, he defends well but gets a hammerfist, and another HAMMERFIST. Siren, let's see what the judges say."
    assert.strictEqual(tripleX(joAndNate),'Draw');
  })
});

describe("Random tests", () => {
  function solution(str){
    return ;
  }

  // let chars = ['xxx','x','X','soft','kitty','warm','kitty'];

  for (let j = 0; j < 100; j++) {
    it(`random test ${j+1}`, () => {
      // let s = '';
      // for (let i = 0; i < 4; i++)
      //   s += chars[~~(Math.random() * 7)];
      // assert.strictEqual(tripleX(s), solution(s), `Testing for str = ${JSON.stringify(s)}`);
    })
  }
});
