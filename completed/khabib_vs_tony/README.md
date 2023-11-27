The fight between Khabib Nurmagomedov and Tony Ferguson, the 2 best lightweight MMA fighters of the 2nd half of the 2010s, failed 5 times for various reasons and never took place. But what if their fight did happen, how would it end? So, in a parallel universe, the fighters entered the cage. At the commentary table are Joe Rogan and Nate Diaz. But there is one problem, your pirate stream has stopped showing the picture, so you only need their comments to understand what is happening in the fight.


Description:
-
In this kata you will be given a string with comments from Joe and Nate. Based on the sequence of words from this string, you will need to determine the result of the fight between Khabib and Tony.

Input:
-
__You get a string containing 4 types of words:__
1. Khabib's actions: `'jab'`, `'overhand'`, `'takedown'`, `'hammerfist'`
2. Tony's actions: `'elbow'`, `'punch'`, `'kick'`, `'imanary'`
3. The action may belong to either Khabib or Tony depending on the context: `'submission'`
4. Words from Joe and Nate that have nothing to do with the actions of the fighters

Rules:
-

__The fight can take place in 2 main positions, standing and on the floor.__
1. Starting position _standing_
2. Actions that mean that the position is now standing (change the position if it was on the floor, the position changes before calculating the damage for this action): `'jab'`, `'overhand'`, `'punch'`, `'kick'`
3. Actions that mean that the position is now on the floor (change the position if it was standing, the position changes before calculating the damage for this action): `'takedown'`, `'hammerfist'`, `'imanary'`
4. Actions that do not change the position (the position remains the same as it was during the previous action): `'elbow'`, `'submission'`

__Rules for dealing damage and scoring judge's points for each action:__
1. Initially, both fighters have _100 hit points_ and _0 judge's points_
2. Upper case and with an exclamation mark - damage is _10 hit points_, reward _2 judge's points_. Example: `'ELBOW!'`
3. Upper case - damage is _5 hit points_, reward _2 judge's points_. Example: `'ELBOW'`
4. With an exclamation mark - damage _3 hit points_, reward _2 judge's points_. Examples: `'elbow!'` or `'Elbow!'`
5. Without an exclamation point and not the entire word in upper case - damage _1 hit point_, reward 1 _judge's point_. Examples: `'elbow'` or `'Elbow'`
6. Damage is always _0 hit point_ (regardless of case or exclamation mark) if the action is: `'takedown'`, `'submission'`, `'imanary'`. Judge's points for the actions `'takedown'`, `'imanary'` are awarded according to the normal rules. For `'submission'` judge's points are awarded only if the rule for submission described in the next paragraph is met

__Submission__ is always carried out by the fighter whose hit points are greater than those of the opponent, while the opponent's remaining hit points must be __less than 20__. Otherwise, the submission is considered unsuccessful and does not bring points to anyone, so it doesn’t matter to us who performed it

__The result of the battle can be:__
1. __Submission__. To win using this method, it is necessary (in addition to the conditions for submission in the paragraph above) that the difference in the number of hit points between the attacker and opponent is greater than 10 if the position is standing otherwise by 5 if the position is on the floor.
    * _Submission example 1_ (Tony: 25hp, Khabib: 20hp, action: `'submission'`): 25 > 20 Tony makes a submission attempt; 20 >= 20 Khabib defends too easily and therefore the judges do not give Tony points.
    * _Submission example 2_ (Tony: 25hp, Khabib: 19hp, position: standing, action: `'SUBMISSION!'`): 25 > 19 Tony makes a submission attempt; 19 < 20 The judges give Tony 2 points; 25 - 19 <= 10 Failed to finish off Khabib, the fight continues
    * _Submission example 3_ (Tony 25hp, Khabib 19hp, position: on the floor, action: `'submission'`): 25 > 19 Tony makes a submission attempt; 19 < 20 The judges give Tony 1 point; 25 - 19 > 5 Tony won by submission
* Output: `'Khabib won by submission'` or `'Tony won by submission'`
2. __Knockout__. To win by knockout, you need to deal 10 damage in one action and the remaining (remaining before this action) hit points were less than: for Tony, 30 hit points if the position is on the floor, otherwise 20 if the position is standing. For Khabib, 30 hit points if the position is standing otherwise 20 if the position is on the floor.
    * _Knockout example 1_ (Khabib: 25hp, action: `'KICK!'`): This action means that the position is standing and the damage is 10; 25 < 30 Tony wins by knockout
    * _Knockout example 2_ (Khabib: 25hp, position: on the floor, action: `'ELBOW!'`): 25 >= 20 Tony deals 10 damage and gets 2 points from the judges, but no knockout occurs, the fight continues
    * _Knockout example 3_ (Tony 29hp, action: `'HAMMERFIST!'`): This action means that the position is on the floor and the damage is 10; 29 < 30 Khabib wins by knockout
    * _Knockout example 4_ (Tony 18hp, action: `'OVERHAND!'`): This action means that the position is standing and the damage is 10; 18 < 20 Khabib wins by knockout
* Output: `'Khabib won by KO'` or `'Tony won by KO'`
3. __Technical knockout__. To win using this method, the hit points of one of the fighters must become 0 or less. (if both a knockout and technical knockout occurred at the same time, then the result is a knockout)
* Output: `'Khabib won by TKO'` or `'Tony won by TKO'`
4. __Victory on points__. Possible if no one has won ahead of schedule until the end of the battle, then you need to count the judges’ points, whoever scored more wins, or a draw if there is a tie
* Output: `'Khabib won by decision'` or `'Tony won by decision'` or `'Draw'`

There is strange smoke and a suspicious smell coming from Joe and Nate, so they can continue to comment on the fight even if it has already ended early by knockout or submission, you should not pay attention to them after that
