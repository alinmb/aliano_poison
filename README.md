![Bannière du script poison & antidote](https://i.ibb.co/T9ZrBTs/aliano-poison.png)

# Aliano Poison/Antidote System

A realistic poisoning and antidote system for FiveM, compatible with ESX and ox_inventory.

## Features

- 🧪 Realistic poisoning system with visual and physical effects
- 💉 Ability to poison other players or yourself
- � Progressive effects (damage, blackouts, difficult walking)
- 🧴 Antidote as the only cure
- ⚗️ Animations & sounds
- 🎚️ Fully customizable configuration
- 🖼️​ 2 items with images (Poison & antidote)

## Requirements

- [ESX Legacy](https://github.com/esx-framework/esx_core)
- [ox_inventory](https://github.com/overextended/ox_inventory)

## Default Configuration Settings

The poison system comes with these carefully balanced default settings:

- ⏱️ `damageInterval = 600000`  
  _Damage occurs every 10 minutes (600,000ms)_
- ❤️ `damageAmount = 5`  
  _5 HP lost per damage tick_

- 🎲 `blackoutChance = 0.5`  
  _50% chance of blackout occurring when damage is applied_

- ⏳ `blackoutInterval = 600000`  
  _10 minute cooldown (600,000ms) between possible blackouts_

- ⏱️ `blackoutDuration = 20000`  
  _Blackouts last 20 seconds (20,000ms)_

- 🚶 `walkStyle = "move_m@drunk@slightlydrunk"`  
  _Drunk walking animation style_

- 👁️ `screenEffectStrength = 0.9`  
  _Intensity of visual effects (0.0-1.0 scale)_

These values can all be adjusted in the config.lua file to suit your server's needs.

## Installation

1. Place the `aliano_poison` folder in your `resources` directory
2. Add `ensure aliano_poison` to your `server.cfg`
3. Configure the items in ox_inventory/data/items.lua, put it at the bottom :

```lua
	--- Aliano Poison/Antidote ---
	['poison'] = {
		label = 'Poison',
		weight = 200,
		description = 'Substance toxique à injection rapide.',
		consume = 1,
		client = {
			export = 'aliano_poison.usePoison',
			usetime = 3000
		}
	},

	['antidote'] = {
		label = 'Antidote',
		weight = 200,
		description = 'Antidote contre les effets du poison à effet rapide.',
		consume = 1,
		client = {
			export = 'aliano_poison.useAntidote',
			usetime = 3000
		}
	}
```

4. Add item's images from the folder "images" in aliano_poison to your ox_inventory in ox_inventory/web/images.
5. Once you done it, delete the images "ox_images" folder.

## Preview

[![Présentation YouTube du script](https://img.youtube.com/vi/KK90zA0C54Y/0.jpg)](https://www.youtube.com/watch?v=KK90zA0C54Y)

---

_See you soon! Aliano._
