To solve this kata, you need to create a character class that can be used for a roguelike game. Instances of this class must have the characteristics strength, dexterity and intelligence and can call some test-generated methods that will change these characteristics or give the character a new weapon.

Character:
-
The character has a __name__ and 3 main characteristics: __strength__, __dexterity__, __intelligence__. Name and characteristics are set randomly when creating a character; if some characteristic is not specified, then the default value is taken equal to __10__, name default value is __'Hero'__.

Random events:
-
Character characteristics can be affected by random events. An event occurs using an instance method, the name of which is the name of the event, and the parameters (the order is always: strength, dexterity, intelligence; quantity is always 3) are stat modifiers. For example:

```ruby
ch = Character.new(name: 'Goblin', strength: 5, dexterity: 13, intelligence: 6)
ch.strange_fruit(0, 2, -1)
```
```javascript
const ch = new Character({name: 'Goblin', strength: 5, dexterity: 13, intelligence: 6});
ch.strangeFruit(0, 2, -1);
```
Strange fruit will reduce the goblin's strength by 2, dexterity will not change, and intelligence will increase by 1

Weapons:
-
Initially, the character is armed only with his __limbs__(lowercase), the damage from which is equal to the sum of his characteristics.

The character can __find__, __equip__, __store__, and __enchant__ weapons:

__1. Find.__

Weapons can be found using an instance method, the name of which is the name of the weapon, and the parameters are the coefficients by which the characteristics will be multiplied + additional damage. The weapon name is always __weapon_of_something__ (Ruby), __weaponOfSomething__ (JS).

__2. Equip.__

Weapon damage consists of 3 coefficients, which give damage depending on characteristics and additional damage. For example, a sword of light with __values of 3 2 1 50__ would mean that the damage is: __3 * strength + 2 * dexterity + 1 * intellect + 50__ (always the order: strength, dexterity, intellect, extra damage), the damage values are always 4.

The character should __always choose the weapon with the highest damage__, for example if he received a stronger weapon or a random event changed his characteristics so that some weapon from previously found became stronger. If 2 weapons have the same damage, then choose the first one in alphabetical order.

__3. Store.__

The character keeps all the weapons he finds.

__4. Enchant.__

If a character has 2 weapons with the same name, then he enchants one of them and destroys the second, enchanting gives the new weapon the characteristics that are maximum from each weapon, for example from the __sword of light (1 0 3 70)__ and the __sword of light (3 2 1 50 )__ you get a __sword of light (3 2 3 70)__. In the output, __(enchanted)__ is added to the name of the improved weapon, but for the new enchantment it is considered the same as the weapon of the same name without this suffix, that is, you can combine an improved one with an unimproved one if you come across a 3rd one that is the same

Output methods:
-
The Character class must have 2 mandatory instance methods, the output of which will be checked by tests:
1. __character info__ method returns character information as a multiline string.
2. __event log__ method returns all events as a string. Each event on a new line

```ruby
ch = Character.new(name: 'Goblin', strength: 5, dexterity: 13, intelligence: 6)
ch.dagger_of_poison(1, 2, 1, 20)
ch.strange_fruit(0, 2, -1)
ch.character_info #=> "Goblin\nstr 5\ndex 15\nint 3\nDagger of poison 60 dmg"
ch.event_log #=> "Goblin find 'Dagger of poison'\nStrange fruit: dexterity +2, intelligence -1"
```
```javascript
const ch = new Character({name: 'Goblin', strength: 5, dexterity: 13, intelligence: 6});
ch.daggerOfPoison(1, 2, 1, 20);
ch.strangeFruit(0, 2, -1);
ch.characterInfo(); //=> `Goblin\nstr 5\ndex 15\nint 3\nDagger of poison 60 dmg`
ch.eventLog(); //=> `Goblin find 'Dagger of poison'\nStrange fruit: dexterity +2, intelligence -1`
```

Example:
-
1. Create a new character

```ruby
ch = Character.new(name: 'Kroker', strength: 15, intelligence: 7)  
```
```javascript
const ch = new Character({name: 'Kroker', strength: 15, intelligence: 7});
```
2. Let's check, the missing characteristic will be equal to 10, and the weapon will be limbs

```ruby
puts ch.character_info
```
```javascript
console.log(ch.characterInfo());
```
```
Kroker
str 15
dex 10
int 7
limbs 32 dmg
```
3. The character finds a weapon

```ruby
ch.axe_of_fire(3, 1, 0, 20)
```
```javascript
ch.axeOfFire(3, 1, 0, 20);
```
4. The weapon and its total damage should appear in the output

```
Kroker
str 15
dex 10
int 7
Axe of fire 75 dmg
```
5. The character finds a weapon that will give him more damage

```ruby
ch.staff_of_water(1, 0, 2, 50)
```
```javascript
ch.staffOfWater(1, 0, 2, 50);
```
6. Accordingly, the weapon in the output changes

```
Kroker
str 15
dex 10
int 7
Staff of water 79 dmg
```
7. An event occurs that changes characteristics

```ruby
ch.strange_fruit(0, 2, -1)
```
```javascript
ch.strangeFruit(0, 2, -1);
```
8. Accordingly, the character’s characteristics and weapon damage, if they affected him, have changed in the output

```
Kroker
str 15
dex 12
int 6
Axe of fire 77 dmg
```
9. The character finds weapons with the same name as the first one and can make them stronger

```ruby
ch.axe_of_fire(1, 2, 1, 10)
```
```javascript
ch.axeOfFire(1, 2, 1, 10);
```
10. The output shows enhanced weapons

```
Kroker
str 15
dex 12
int 6
Axe of fire(enhanced) 95 dmg
```
11. Event log displays all events in order

```ruby
puts ch.event_log
```
```javascript
console.log(ch.eventLog());
```
```
Kroker find 'Axe of fire'
Kroker find 'Staff of water'
Strange fruit: dexterity +2, intelligence -1
Kroker find 'Axe of fire'
```
