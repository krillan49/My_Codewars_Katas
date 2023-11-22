To solve this kata, you need to create a character class that can be used for a roguelike game. Instances of this class must have the characteristics strength, dexterity and intelligence and can call some test-generated methods that will change these characteristics or give the character a new weapon.

The Character class must have 2 mandatory instance methods - one will display character information and the other will display the event log. Only these output methods will be checked by tests The names of the properties or how the user stores any values is entirely up to the user and individual properties will not be checked.

Character
-
The character has a `name` and 3 main characteristics: `strength`, `dexterity`, `intelligence`. Name and characteristics are set randomly when creating a character; if some characteristic is not specified, then the default value is taken equal to `10`, name default value is `'Hero'`. Initially, the character is armed only with his `'limbs'`(lowercase), the damage from which is equal to the sum of his characteristics.

```ruby
ch = Character.new(name: 'Kroker', strength: 15, intelligence: 7)  
```
```javascript
const ch = new Character({name: 'Kroker', strength: 15, intelligence: 7});
```

The method giving the character's info returns a multiline string. Let's check, the missing characteristic will be equal to 10, and the weapon will be `'limbs'`

```ruby
puts ch.character_info #=> "Kroker\nstr 15\ndex 10\nint 7\nlimbs 32 dmg"
```
```javascript
console.log(ch.characterInfo()); //=> `Kroker\nstr 15\ndex 10\nint 7\nlimbs 32 dmg`
```

```
Kroker
str 15
dex 10
int 7
limbs 32 dmg
```

The character finds a weapon
-
Weapons can be found using an instance method, the name of which is the name of the weapon. The name of the weapon method can be anything, but always consists of 3 words: the type of weapon (for example, "axe"), the word "of" and the property of the weapon (for example, "fire").

```ruby
ch.axe_of_fire(3, 1, 0, 20) # weapon method name can be anything as long as it matches weapon_of_something
```
```javascript
ch.axeOfFire(3, 1, 0, 20); // weapon method name can be anything as long as it matches weaponOfSomething
```

Weapon damage is set by parameters passed to the method, which give damage depending on characteristics and additional damage.(always the order: strength, dexterity, intellect, extra damage), the number of parameters are always 4.

In this case, the Axe of fire has parameters `3, 1, 0, 20`. This means that the damage from this weapon will be calculated according to the formula

```math
3 * strength + 1 * dexterity + 0 * intelligence + 20 = 3 * 15 + 1 * 10 + 0 * 7 + 20 = 75
```

The weapon and its total damage should appear in the output

```
Kroker
str 15
dex 10
int 7
Axe of fire 75 dmg
```

All events with found weapons go into the event log

```ruby
puts ch.event_log
```
```javascript
console.log(ch.eventLog());
```

```
Kroker find 'Axe of fire'
```

The character finds another weapon that will do more damage
-

The character should always choose the weapon with the highest damage, if he received a stronger weapon, If 2 weapons have the same damage, then choose the first one in alphabetical order.

```ruby
ch.staff_of_water(1, 0, 2, 50)
```
```javascript
ch.staffOfWater(1, 0, 2, 50);
```

Staff of water has 79 damage`(1 * 15 + 0 * 10 + 7 * 2 + 50)` this is more than the 'Axe of fire', which means we need to change weapons. Accordingly, the weapon in the output changes

```
Kroker
str 15
dex 10
int 7
Staff of water 79 dmg
```
The character retains all the weapons found, that is, although we replaced the 'Axe of fire' with the 'Staff of water', the 'Axe of fire' will remain in the character’s inventory

Random events that changes characteristics
-
Character characteristics can be affected by random events. An event occurs using an instance method, the name of which is the name of the event, and the parameters (the order is always: strength, dexterity, intelligence; quantity is always 3) are stat modifiers

```ruby
ch.strange_fruit(0, 2, -1)
```
```javascript
ch.strangeFruit(0, 2, -1);
```

The 'Strange fruit' does not change strength, as the first coefficient is 0, but it adds 2 dexterity and -1 intelligence.

The character should always choose the weapon with the highest damage; if a random event changed its characteristics so that some weapon from the previously found one became stronger(or in alphabetical order by name, if damage is equal) than the one equipped, then you need to change to a stronger one from the inventory. Accordingly, we change the 'Staff of water' back to the 'Axe of fire' and the conclusion will be

```
Kroker
str 15
dex 12
int 6
Axe of fire 77 dmg
```

All random events end up in the event log

```
Kroker find 'Axe of fire'
Kroker find 'Staff of water'
Strange fruit: dexterity +2, intelligence -1
```

For random events, you do not need to specify modifiers equal to 0, but only those that changed the character's characteristics.

Enchant
-
If a character has 2 weapons with the same name, then he enchants one of them and destroys the second, enchanting gives the new weapon the characteristics that are maximum from each weapon

```ruby
ch.axe_of_fire(1, 2, 1, 10)
```
```javascript
ch.axeOfFire(1, 2, 1, 10);
```

Now there are 2 'Axe of fire', so let’s enchant one of them by destroying the second one. The enchantment will make each damage parameter maximum from those of the 2 original weapons.
```math
(3, 1, 0, 20) and (1, 2, 1, 10) => ((3>1=3), (1<2=2), (0<1=1), (20>10=20)) => (3, 2, 1, 20)
```
The output shows enhanced weapons. In the output, `'(enchanted)'` is added to the name of the improved weapon

```
Kroker
str 15
dex 12
int 6
Axe of fire(enhanced) 95 dmg
```

For the new enchantment it is considered the same as the weapon of the same name without '(enchanted)' suffix, that is, you can combine an improved one with an unimproved one if you come across a 3rd one that is the same

Event log displays all events in order
-

Event log method returns all events as a string. Each event on a new line.

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