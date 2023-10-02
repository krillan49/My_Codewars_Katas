You need to create a Character class that can create a character for a roguelike game with changeable characteristics and the ability to choose weapons

The character has a name and 3 main characteristics
Physical strength
Dexterity
Intelligence
Characteristics are set randomly when creating a character; if some characteristic is not specified, then the default value is taken, which is 10

Character characteristics can be affected by random events
For example:
A curse with values -2 0 1 will mean that the character’s strength has decreased by 2, agility has not changed, intelligence has increased by 1 (the order is always strength, agility, intelligence), values are always 3

The character can find, store, equip and enchant weapons.
Weapon damage consists of 3 coefficients, which give damage depending on the characteristics and additional damage. For example:
A sword of light with values of 3 2 1 50 will mean that the damage is equal to: 3 * strength + 2 * agility + 1 * intelligence + 50 (the order is always strength, agility, intelligence, extra damage), the damage values are always 4
The name of the weapon is always weapon_of_something
Initially, the character is armed only with his limbs, the damage from which is equal to the sum of his characteristics
