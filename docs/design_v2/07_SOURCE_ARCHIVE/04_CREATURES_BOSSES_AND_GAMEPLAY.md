# Creatures, Bosses and Gameplay Canon

This file records the current conversation canon for Aster's game, including the
connected-world approach and encounter concepts. Specific encounter names and balancing
can be changed by the creator.

## Game format and creative influences

- Aster's game is single-player, 2D pixel art, intended for Godot.
- It is a story-based Metroidvania/action-adventure, with an early 8–10 hour target.
- The creator draws inspiration from *Hollow Knight*, *Hollow Knight: Silksong*,
  *Sword Art Online* and other dungeon-based anime: challenging monsters, bosses,
  exploration, skill growth and loot.
- The story, characters and mechanics are original to *Echoes of the Aether*.

## World as puzzle

The entire dungeon should be one interconnected mystery, not just individual quest
rooms. Aster learns its logic through repeated symbols, maps, architecture, relics,
Echo flows, enemy behavior and the changes caused by the Warp. Local puzzles contribute
to his understanding of the whole dungeon and his route toward escape.

The proposed room/region loop is:

**Explore → notice clue or blocked path → collect useful information/item → infer and
test a solution → fight or evade a threat → open a route, shortcut or story discovery.**

Keys, map pieces, relics, inscriptions, mechanism parts and environmental knowledge may
gate paths. Optional collectibles can reveal lore, upgrades and shortcuts; they should
not block the main story unless marked critical.

## Puzzle canon

### Echo Sluice

- Aster restores a bridge by routing Echo flow through three conductors.
- Clues: a damaged plinth says the center conductor must go last; a wall relief gives
  the first two symbols; a nearby light pulse confirms the order.
- Working solution: **Root Arch → Hanging Bell → Split Stone**.
- Success raises the bridge and opens a loop.
- A wrong sequence briefly resets the mechanism locally and gives feedback; it does
  not force a long walk back.

The wider puzzle approach favors multi-clue, inferable solutions. Teach a rule in a
safe context, combine it with other rules later, and increase challenge through
reasoning rather than hiding essential clues.

## Creatures and enemy behavior

- Dungeon monsters use Echoes to live. Aster collects Echoes from defeated monsters;
  ordinary gear releases Echoes to make usable energy, while Nalora's aliens consume
  them outright.
- The dungeon includes relic-like mechanical enemies and golems, including stone,
  metal and mithril forms.
- Chapter 1 and Chapter 2 each have at least a mid-boss encounter in the current plan.
  The first can use continuous, relatively simple attacks; later encounters can
  introduce time/space attacks from unusual directions, including from above or behind.
- The final major boss, before the gate at the end of Chapter 3, uses space-time
  abilities that Aster can face with Echo Rewind.
- The creator wants multiple mini-bosses, story clues and foreshadowing through the
  encounters.

### Echo Forager — regular enemy

The Forager patrols near Echo traces, notices Aster, approaches, telegraphs a lunge,
attacks Aster's last seen position, then pauses if it misses. It searches briefly if
Aster escapes, returns to its route and releases stored Echoes on defeat. Its AI states
are **Patrol → Notice → Approach → Telegraph → Lunge → Recover**. It does not track
Aster through walls or attack from unmarked off-screen space.

### Sluice Warden — first mini-boss

The stone-and-metal Warden tracks Aster, winds up a heavy arm slam, creates a floor
shockwave and becomes vulnerable when its arm sticks in the ground. Aster jumps or
dodges the wave and attacks during the recovery window. At low health it can chain two
slams with clear pauses. Its states are **Guard → Track → Wind-up → Slam →
Stuck/Recovery → Guard**, with Stagger and Defeated states.

### Wayfinder Colossus — Chapter 2 mid-boss

A large monster distorts positioning and marks attacks that arrive from above or
behind, including laser-like strikes from a position other than its visible body.
Warnings appear before danger. Aster reads the markers, evades and attacks during
recovery.

### Fold Guardian — Chapter 3 main boss

The Fold Guardian uses spatial folds to deliver marked attacks from portals, the
ceiling or behind Aster. Its later phase combines patterns the player has already
learned. Aster uses movement and Echo Rewind to evade, recover his own position or
reach short openings; Rewind does not rewind the boss or cancel the Warp.

These encounter names are working canon from the discussed design and remain editable.
Other boss/monster roster entries may be added as the full game is developed.

## Three-chapter structure

Chapter count is flexible, but the current Aster outline is:

1. **Chapter 1 — The relic rumor:** Town opening, dungeon expedition, Echo Warp,
   exploration, first mid-boss and a map/clue at the end pointing toward Echo Rewind.
2. **Chapter 2 — Echo Rewind:** Aster follows the map through merged dungeon regions,
   faces a large mid-boss and finds Echo Rewind at the chapter's end.
3. **Chapter 3 — The final gate:** Aster masters Rewind, fights the space-time boss,
   reaches the Warp-broken gate and is trapped for Orion's game.

## Working world layout

The discussed first-pass route includes:

**Guild Town → Outer Wilds → Hunter's Reach/Trail → Old Survey Camp → Split Walk →
Echo Sluice → Rootspan → Relic Watch → Survey Vault → Warped Verge → Echo Reservoir →
Rewind Sanctuary → Folded Depths → Final Approach → Fold Guardian → Warp-Broken Gate.**

These are descriptive area names. The dungeon is a connected world with loops and
shortcuts; the arrangement and number of regions can be revised to support pacing and
the 8–10 hour scope.
