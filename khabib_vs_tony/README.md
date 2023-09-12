The fight of Khabib Nurmagomedov and Tony Ferguson, the 2 best lightweights of the 2nd half of 2010s, fell through for various reasons 5 times and never took place. But what if it all the same took place, I wonder how it would end?

So in the parallel universe, everything worked out, the fighters went into the cage. Commentary by Joe Rogan and Nate Diaz. But there is one problem, your pirate stream stopped showing the picture so you only have their comments to understand what's going on in the fight.

Task

Input:

You get a line with comments from Joe and Nate, they contain:
1. Khabib's actions
%w[jab overhand takedown hammerfist submission]
2. Tony's actions
%w[elbow punch kick imanary submission]
3. Words from Joe and Nate that have nothing to do with the actions of the fighters

Rules:

Initially, both fighters have 100 hit points and 0 points from the judges

Judges award points for any actions of fighters
Damage is caused by any action except:
%w[takedown submission imanary]

Any actions can be of 4 types:
1. In the upper register - damage is 5 hit points, judges give 2 points
2. With an exclamation mark - damage 3 hit points, judges give 2 points
3. In upper case and with an exclamation mark - damage is 10 hit points, judges give 2 points
4. Without an exclamation point and not the entire word in upper case - damage 1 hit point, judges give 1 point

The fight can take place in 2 main positions, standing and on the floor.
1. Actions that mean that the position is now standing (change the position if it was on the floor)
%w[takedown hammerfist imanary]
2. Actions that mean that the position is now on the floor (change the position if it was standing)
%w[jab overhand punch kick]
3. Actions that do not change the position (the position remains the same as it was during the previous action) - all others except those indicated above.

There is strange smoke and a suspicious smell coming from Joe and Nate, so they can continue to comment on the fight even if it has already ended early by knockout or submission, you should not pay attention to them after that

Submission is always carried out by the fighter whose hit points are greater than those of the opponent, while the opponent's remaining hit points must be less than 20
Otherwise, the submission is considered unsuccessful and does not bring points to anyone, so it doesn’t matter to us who performed it

The result of the battle can be:
1. Knockout. To win by knockout, you need to deal 10 damage in one action, and the remaining hit points were less than:
30 for Tony's hit points if the position is on the floor or for Khabib's hit points if the position is standing
20 for Khabib's hit points if the position is standing or for Tony's hit points if the position is on the floor
2. Technical knockout. To win using this method, the hit points of one of the fighters must become 0 or less.
(if both a knockout and technical knockout occurred at the same time, then the result is a knockout)
3. Submission. To win using this method, it is necessary (in addition to the conditions for submission) that the number of hit points of the victim be less than the number of hit points of the attacker by 10 if the position is standing or by 5 if the position is on the floor.
4. Victory on points. Possible if no one has won ahead of schedule until the end of the battle, then you need to count the judges’ points, whoever scored more wins, or a draw if there is a tie


Output:
'Khabib won by KO' or 'Tony won by KO' or
'Khabib won by TKO' or 'Tony won by TKO' or
'Khabib won by submission' or 'Tony won by submission' or
'Khabib won by decision' or 'Tony won by decision' or
'Draw'
