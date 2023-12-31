const khabib = ['jab', 'overhand', 'takedown', 'hammerfist', 'submission'];
const tony = ['punch', 'elbow', 'kick', 'imanary', 'submission'];

function actionPower(upcase, exclamation){
  if (upcase && exclamation) return 10;
  if (upcase) return 5;
  if (exclamation) return 3;
  return 1;
}

function actionPoints(upcase, exclamation){
  return upcase || exclamation ? 2 : 1;
}

function khabibVsTony(joeAndNate){
  let habibPoints = 0, tonyPoints = 0, habibHp = 100, tonyHp = 100, position = 'standing';
  joeAndNate = joeAndNate.split(' ').filter(s => khabib.concat(tony).includes(s.toLowerCase().replace(/[^a-z]/g, '')))

  for (var action of joeAndNate) {
    action = action.replace(/[^a-z!]/gi, '');
    let upcase = action == action.toUpperCase() ? true : false;
    let exclamation = action[action.length-1] == '!' ? true : false;
    let res = [action, upcase, exclamation];
    action = action.toLowerCase().replace('!', '');
    if (['takedown', 'hammerfist', 'imanary'].includes(action)) position = 'ground';
    if (['jab', 'overhand', 'punch', 'kick'].includes(action)) position = 'standing';
    let ap = actionPower(upcase, exclamation);

    if (action == 'submission' && habibHp > tonyHp && tonyHp < 20) {
      habibPoints += actionPoints(upcase, exclamation);
      if (habibHp - tonyHp > (position == 'standing' ? 10 : 5)) return 'Khabib won by submission';
    } else if (action == 'submission' && habibHp < tonyHp && habibHp < 20) {
      tonyPoints += actionPoints(upcase, exclamation);
      if (tonyHp - habibHp > (position == 'standing' ? 10 : 5)) return 'Tony won by submission';
    } else if (['elbow', 'punch', 'kick'].includes(action)) {
      if (habibHp < (position == 'standing' ? 30 : 20) && ap == 10) return 'Tony won by KO';
      habibHp -= ap;
    } else if (['jab', 'overhand', 'hammerfist'].includes(action)) {
      if (tonyHp < (position == 'standing' ? 20 : 30) && ap == 10) return 'Khabib won by KO';
      tonyHp -= ap;
    };

    if (habibHp <= 0) return 'Tony won by TKO';
    if (tonyHp <= 0) return 'Khabib won by TKO';
    if (['jab', 'overhand', 'hammerfist', 'takedown'].includes(action)) habibPoints += actionPoints(upcase, exclamation);
    if (['elbow', 'punch', 'kick', 'imanary'].includes(action)) tonyPoints += actionPoints(upcase, exclamation);
  };

  if (habibPoints > tonyPoints) return 'Khabib won by decision';
  if (habibPoints < tonyPoints) return 'Tony won by decision';
  return 'Draw';
}

// test1
var joeAndNate = "First round! The fighters are in the center, Khabib delivers a power jab! and immediately OVERHAND! Tony felt it. Ferguson tries to break the distance with a kick, but another OVERHAND! Tony staggers. Takedown, Khabib easily moved the shocked opponent, trying to make a submission, but Tony's jiujitsu works. Hammerfist, HAMMERFIST, HAMMERFIST! Tony's doing bad, he can only try to survive. Hammerfist! HAMMERFIST! HAMMERFIST! HAMMERFIST! HAMMERFIST! Ferguson sweeps and slides out, all is not lost for him! He is shaking, can he survive until the end of the round? Khabib clamps down on his jab. Jab!, OVERHAND! Knockout!!! Incredible domination, I did not expect such an easy victory for Khabib.";
console.log(khabibVsTony(joeAndNate)); // 'Khabib won by KO'
// test1 clear
var joeAndNate = "jab! OVERHAND! kick OVERHAND! Takedown submission Hammerfist HAMMERFIST HAMMERFIST! Hammerfist! HAMMERFIST! HAMMERFIST! HAMMERFIST! HAMMERFIST! jab Jab! OVERHAND!"
"Khabib won by KO";
console.log(khabibVsTony(joeAndNate)); // 'Khabib won by KO'

// test2
var joeAndNate = "Khabib tries to pull Tony to the cage, hits the jab, but misses. ELBOW! from the turn, how did he catch him! Khabib backs away like he's shocked and got a cut above his eye, blood starts to fill his eye, Tony is chasing, kick! More KICK, PUNCH! ELBOW! More PUNCH, Khabib got another cut, his whole face is in blood, he can't see anything. Khabib does a takedown and Tony closes the guard. Khabib tries to hit, but he sees almost nothing, bumps into an ELBOW! ELBOW! ELBOW! Another ELBOW! New cuts, Khabib's face becomes like a bloody mask. Tony throws a triangle, tightens, it looks like Khabib passed out, excellent submission. Yes, Tony is horrendous, the real El Cucuy.";
console.log(khabibVsTony(joeAndNate)); // 'Tony won by submission'
// test2 clear
var joeAndNate = "jab ELBOW! kick! KICK PUNCH! ELBOW! PUNCH takedown ELBOW! ELBOW! ELBOW! ELBOW! submission";
console.log(khabibVsTony(joeAndNate)); // 'Tony won by submission'

// test3
var joeAndNate = `Khabib starts with a jab, Tony kicks back, another jab, OVERHAND! Tony backs to the cage. Khabib corners Ferguson, takedown. Tony tries to get out but gives back, hammerfist, HAMMERFIST, HAMMERFIST! Tony rolls over and Khabib keeps hitting him with the mount, hammerfist, HAMMERFIST, HAMMERFIST! Ferguson hits with an elbow, tries to twist and improve his position, but to no avail, hammerfist, HAMMERFIST, HAMMERFIST! Siren round is over. Khabib confidently took him 10 - 9.
Second round. Tony starts with a kick, punch, another kick, not a bad start. Imanari roll!? Why did he do it? Tony is on the bottom again, that was stupid. Khabib went back to hammering hammerfist after hammerfist, more HAMMERFIST! It looks like the error was critical. HAMMERFIST, HAMMERFIST, HAMMERFIST, HAMMERFIST, HAMMERFIST, HAMMERFIST. Tony doesn't actively defend, Big John stops the fight.`;
console.log(khabibVsTony(joeAndNate)); // 'Khabib won by TKO'
// test3 clear
var joeAndNate = `jab kick jab OVERHAND! takedown hammerfist HAMMERFIST HAMMERFIST! hammerfist HAMMERFIST HAMMERFIST! elbow hammerfist HAMMERFIST HAMMERFIST! kick punch kick hammerfist hammerfist HAMMERFIST! HAMMERFIST HAMMERFIST HAMMERFIST HAMMERFIST HAMMERFIST HAMMERFIST`;
console.log(khabibVsTony(joeAndNate)); // 'Khabib won by TKO'

// test4
var joeAndNate = "It looks like the score is equal, everything will be decided by the last round. Khabib comes up with a jab, Tony hits back with a kick, another kick, Khabib catches his leg, he can’t go down, Tony hits with an elbow, another elbow. Khabib makes another attempt to move into the fight, again unsuccessfully, it seems Tony retained more strength at the end of the fight. Jab, kick, punch. These middle exchanges are clearly in favor of Tony. Khabib closes in, takedown, Tony in guard, he defends well, gets a hammerfist, but immediately responds with an elbow. Siren, let's see what the judges say.";
console.log(khabibVsTony(joeAndNate)); // 'Tony won by decision'
// test4 clear
var joeAndNate = "jab kick kick elbow elbow Jab kick punch takedown hammerfist elbow";
console.log(khabibVsTony(joeAndNate)); // 'Tony won by decision'

// test5
var joeAndNate = "It looks like the score is equal, everything will be decided by the last round. Khabib comes up with a jab, Tony hits back with a kick, another kick, Khabib catches his leg, he can’t go down, Tony hits with an elbow, another elbow. Khabib makes another attempt to move into the fight, again unsuccessfully, it seems Tony retained more strength at the end of the fight. Jab, kick, punch. These middle exchanges are clearly in favor of Tony. Khabib closes in, takedown, Tony is on guard, he defends well but gets a hammerfist, and another HAMMERFIST. Siren, let's see what the judges say.";
console.log(khabibVsTony(joeAndNate)); // 'Draw'
// test5 clear
var joeAndNate = "jab kick kick elbow elbow Jab kick punch takedown hammerfist HAMMERFIST";
console.log(khabibVsTony(joeAndNate)); // 'Draw'
