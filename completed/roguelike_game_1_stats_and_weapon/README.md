You need to create a Character class that can create a character for a roguelike game with interchangeable stats and a choice of weapons.

Character:
-
The character has a __name__ and 3 main characteristics: __strength__, __dexterity__, __intelligence__. Name and characteristics are set randomly when creating a character; if some characteristic is not specified, then the default value is taken equal to __10__, name default value is 'Hero'.

Random events:
-
Character characteristics can be influenced by random events. The event occurs using an instance method, the name of which is the name of the event, and the parameters are how much each character characteristic will change (the order is always: strength, dexterity, intelligence), the values are always 3. For example, a ancient curse with the values -2 0 1 will mean that the character’s strength has decreased by 2, agility has not changed, and intelligence has increased by 1

Weapons:
-
The character can find, store, equip, and enchant weapons.

Weapons can be found using an instance method, the name of which is the name of the weapon, and the parameters are the coefficients by which the characteristics will be multiplied + additional damage. The weapon name is always weapon_of_something.

Weapon damage consists of 3 coefficients, which give damage depending on characteristics and additional damage. For example, a sword of light with values of 3 2 1 50 would mean that the damage is: 3 * strength + 2 * agility + 1 * intellect + 50 (always the order: strength, agility, intellect, extra damage), the damage values are always 4.

Initially, the character is armed only with his limbs, the damage from which is equal to the sum of his characteristics.

The character keeps all the weapons he finds.

If a character has 2 weapons with the same name, then he enchants one of them and destroys the second, enchanting gives the new weapon the characteristics that are maximum from each weapon, for example from the sword of light (1 0 3 70) and the sword of light (3 2 1 50 ) you get a sword of light (3 2 3 70). In the output, __(enchanted)__ is added to the name of the improved weapon, but for the new enchantment it is considered the same as the weapon of the same name without this suffix, that is, you can combine an improved one with an unimproved one if you come across a 3rd one that is the same

The character should __always choose the weapon with the highest damage__, for example if he received a stronger weapon or a random event changed his characteristics so that some weapon from previously found became stronger. If 2 weapons have the same damage, then choose the first one in alphabetical order.

Output methods:
-
The Character class must have 2 mandatory instance methods, the output of which will be checked by tests

__character_info__ - returns character information as a string. For example, for a Goblin character with strength 5, agility 15, intelligence 3 and dagger of poison with a total damage of 60:
```bash
"Goblin\nstr 5\ndex 15\nint 3\nDagger of poison 60 dmg"
```

__event_log__ - returns all events as a string. Each event on a new line:
```bash
"Goblin find 'Dagger of poison'\nStrange fruit: dexterity +2, intelligence -1"
```

Example:
-
1. Create a new character
```bash
ch = Character.new(name: 'Kroker', strength: 15, intelligence: 7)
```
2. Let's check, the missing characteristic will be equal to 10, and the weapon will be limbs
```bash
puts ch.character_info
```
```bash
Kroker
str 15
dex 10
int 7
limbs 32 dmg
```
3. The character finds a weapon
```bash
ch.axe_of_fire(3, 1, 0, 20)
```
4. The weapon and its total damage should appear in the output
```bash
puts ch.character_info
```
```bash
Kroker
str 15
dex 10
int 7
Axe of fire 75 dmg
```
5. The character finds a weapon that will give him more damage
```bash
ch.staff_of_water(1, 0, 2, 50)
```
6. Accordingly, the weapon in the output changes
```bash
puts ch.character_info
```
```bash
Kroker
str 15
dex 10
int 7
Staff of water 79 dmg
```
7. An event occurs that changes characteristics
```bash
ch.strange_fruit(0, 2, -1)
```
8. Accordingly, the character’s characteristics and weapon damage, if they affected him, have changed in the output
```bash
puts ch.character_info
```
```bash
Kroker
str 15
dex 12
int 6
Staff of water 77 dmg
```
9. The character finds weapons with the same name as the first one and can make them stronger
```bash
ch.axe_of_fire(1, 2, 1, 10)
```
10. The output shows enhanced weapons
```bash
puts ch.character_info
```
```bash
Kroker
str 15
dex 12
int 6
Axe of fire(enhanced) 95 dmg
```
11. Event log displays all events in order
```bash
puts ch.event_log
```
```bash
Kroker find 'Axe of fire'
Kroker find 'Staff of water'
Strange fruit: dexterity +2, intelligence -1
Kroker find 'Axe of fire'
```
