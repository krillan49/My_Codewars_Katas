The fight between Khabib Nurmagomedov and Tony Ferguson, the 2 best lightweight MMA fighters of the 2nd half of the 2010s, failed 5 times for various reasons and never took place. But what if their fight did happen, how would it end?

So, in a parallel universe, the fighters entered the cage. At the commentary table are Joe Rogan and Nate Diaz. But there is one problem, your pirate stream has stopped showing the picture, so you only need their comments to understand what is happening in the fight.


Input:
-

__You get a line with comments from Joe and Nate, they contain:__
1. Khabib's actions:
___jab, overhand, takedown, hammerfist, submission___
2. Tony's actions:
___elbow, punch, kick, imanary, submission___
3. Words from Joe and Nate that have nothing to do with the actions of the fighters

Rules:
-

__The fight can take place in 2 main positions, standing and on the floor.__
1. Starting position __standing__
2. Actions that mean that the position is now standing (change the position if it was on the floor, the position changes before calculating the damage for this action): ___jab, overhand, punch, kick___
3. Actions that mean that the position is now on the floor (change the position if it was standing, the position changes before calculating the damage for this action): ___takedown, hammerfist, imanary___
4. Actions that do not change the position (the position remains the same as it was during the previous action): ___elbow, submission___

__Rules for dealing damage and scoring judges' points for each action:__
1. Initially, both fighters have __100 hit points__ and __0 points__ from the judges
2. Upper case - damage is __5 hit points__, judges give __2 points__
* example: ELBOW
3. With an exclamation mark - damage __3 hit points__, judges give __2 points__
* example: elbow! or Elbow!
4. Upper case and with an exclamation mark - damage is __10 hit points__, judges give __2 points__
* example: ELBOW!
5. Without an exclamation point and not the entire word in upper case - damage __1 hit point__, judges give __1 point__
* example: elbow or Elbow
6. Damage is always __0 hit point__ (regardless of case or exclamation mark) if the action is: ___takedown, submission, imanary___. Judge points for the actions ___takedown, imanary___ are awarded according to the normal rules. For ___submission___ judge points are awarded only if the rule for submission described in the next paragraph is met

__Submission__ is always carried out by the fighter whose hit points are greater than those of the opponent, while the opponent's remaining hit points must be __less than 20__. Otherwise, the submission is considered unsuccessful and does not bring points to anyone, so it doesn’t matter to us who performed it

__The result of the battle can be:__
1. __Submission__. To win using this method, it is necessary (in addition to the conditions for submission) that the difference in the number of hit points between the attacker and opponent is greater than __10__ if the position is standing otherwise by __5__ if the position is on the floor.
2. __Knockout__. To win by knockout, you need to deal 10 damage in one action and the remaining (remaining before this action) hit points were less than: for Tony, __30__ hit points if the position is on the floor, otherwise __20__ if the position is standing. For Khabib, __30__ hit points if the position is standing otherwise __20__ if the position is on the floor.
3. __Technical knockout__. To win using this method, the hit points of one of the fighters must become __0 or less__. (if both a knockout and technical knockout occurred at the same time, then the result is a knockout)
4. __Victory on points__. Possible if no one has won ahead of schedule until the end of the battle, then you need to count the judges’ points, whoever scored more wins, or a draw if there is a tie

__There is strange smoke and a suspicious smell coming from Joe and Nate, so they can continue to comment on the fight even if it has already ended early by knockout or submission, you should not pay attention to them after that__


Output:
-
* 'Khabib won by KO'
* 'Tony won by KO'
* 'Khabib won by TKO'
* 'Tony won by TKO'
* 'Khabib won by submission'
* 'Tony won by submission'
* 'Khabib won by decision'
* 'Tony won by decision'
* 'Draw'

Examples/hints:
-

__Submission example 1 (Tony 25hp, Khabib 20hp, submission):__

25 > 20. Tony makes a submission attempt.

20 >= 20. Khabib defends too easily and therefore the judges do not give Tony points

__Submission example 2 (Tony 25hp, Khabib 19hp, standing, SUBMISSION!):__

25 > 19. Tony makes a submission attempt.

19 < 20. The judges give Tony 2 points.

25 - 19 <= 10. Failed to finish off Khabib, the fight continues

__Submission example 3 (Tony 25hp, Khabib 19hp, on the floor, submission):__

25 > 19. Tony makes a submission attempt.

19 < 20. The judges give Tony 1 point.

25 - 19 > 5. Tony won by submission
