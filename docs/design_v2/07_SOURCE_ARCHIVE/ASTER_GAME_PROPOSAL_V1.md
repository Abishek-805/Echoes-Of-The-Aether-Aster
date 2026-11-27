# Echoes of the Aether: Aster — Full Game Proposal v1

> **Status:** Evolving design document. The creator has said all ideas discussed in
> chat so far are intended for the game and are canon. Details explicitly described as
> flexible remain revisable. The organized canon set is in
> [CANON](CANON/README.md). Earlier co-op-era canon and GDD files remain untouched.

## 1. Game identity

- **Working title:** *Echoes of the Aether: Aster*
- **Format:** Single-player, 2D pixel-art action-adventure with Metroidvania exploration.
- **Engine:** Godot.
- **Target length:** Approximately 8–10 hours as an early scope goal.
- **Creative references:** *Hollow Knight*, *Hollow Knight: Silksong*, *Sword Art Online*,
  and dungeon-based anime. These are references for feel and genre; the story, world and
  mechanics here remain the creator's own.
- **Player fantasy:** Be an experienced hunter who enters a legendary dungeon for a
  famous relic, then survives by learning how the entire dungeon works.

## 2. Confirmed story foundation

1. Aster is an experienced, talented hunter from **Eldara**. He was orphaned as a child,
   grew up in an orphanage and was inspired by the hunters he saw.
2. Eldara has a guild town and an immense dungeon. Hunters defeat monsters, obtain
   valuable finds and trade them through guilds.
3. Aster hears that a legendary relic, **Echo Rewind**, may be hidden in the dungeon.
   A legendary team reached a space-time-distorted area but failed to obtain it.
4. Aster enters on an expedition. An **Echo Warp** merges parts of Eldara's and
   **Veraya's** dungeons, strengthens the monsters and traps Aster inside. The planets
   themselves do not merge.
5. Aster finds a map or clue at the end of Chapter 1 that points toward Echo Rewind.
   He obtains Echo Rewind around the middle of the game, at the end of Chapter 2 in the
   current outline. It is his only special ability.
6. At the end of Chapter 3, Aster defeats a space-time boss but cannot pass the final
   gate. The Echo Warp has broken it. He remains trapped, setting up Orion's game.
7. In the second game Orion is the player character and Aster is an NPC ally. Orion
   eventually helps Aster escape. Their friendship grows, and the two begin their
   journey together.

The Echo Warp's full cause, the ancient civilization's failed Echo-gathering project,
Nalora, the displaced aliens and the trapped Echoes are part of the larger trilogy
direction. Aster's game can foreshadow these answers without explaining the whole
history before the later games.

## 3. Design pillars

### The world is one puzzle

The dungeon is not a string of disconnected rooms. Its routes, symbols, relics,
creatures, Echo flows and warped spaces all reveal parts of a larger system. The player
learns the dungeon's logic piece by piece and uses that understanding to reach new
areas and search for an escape.

### Story through play

Every region should show what it was for, who used it, what changed, and how that
history connects to Aster's expedition. Use architecture, environmental changes,
objects, enemy behavior and short optional records alongside brief cinematic scenes.

### Exploration with purpose

The world should reward curiosity with useful map information, shortcuts, upgrades,
Echo resources, relic records or story clues. Optional rewards enrich the journey;
they do not block the critical story route.

### Fair challenge

Enemies and bosses have readable tells, distinct behaviors and openings for counterplay.
Puzzles require reasoning, but their answers can be inferred from clues. A mistake
should teach the player something and should not force a long replay without new
information.

### A connected saga

Aster's game resolves his hunt for Echo Rewind and establishes the dungeon crisis. It
ends on the broken gate, making Orion's rescue the next necessary chapter in the saga.
Foreshadow the later games through evidence and unanswered questions, not a full lore
dump.

## 4. Metroidvania flow in plain language

A Metroidvania uses a connected map. A route may be visible before the player can pass
it. The player explores elsewhere, learns or acquires something useful, then returns
with a new way to continue. Shortcuts gradually make old and new areas connect. Good
backtracking has a reason: the player now sees a new route, clue, reward or consequence.

For Aster, Echo Rewind arrives midway, so early areas must be traversable without it.
After he gains it, selected paths and puzzles can use its ability to rewind Aster's own
recent position and state. The world and enemies do not rewind. Other gates can use
keys, mechanisms, environmental knowledge or map clues; avoid making every door a key
check.

## 5. World concept and map

### The dungeon's proposed logic

**Current world-design direction:** The ancient dungeon is a vast relic-preservation and Echo-management
network. Its spaces have connected functions: approach routes, hunter-accessible outer
areas, storage and display halls, maintenance systems, research spaces and protected
relic chambers. It is also a living environment with open sky, trees, roots, water and
creatures. It is not just a cave or a collection of generic rooms.

The Echo Warp introduces portions of Veraya's dungeon into Eldara's connected map.
Early on, the player sees impossible architecture, unfamiliar symbols, abrupt changes
in materials and monster traces. The map can show which paths existed before and which
appeared after the warp. This makes the merger a navigational mystery as well as a
story event.

### Proposed region graph

```text
[Guild Town]
     |
[Outer Wilds] ---- [Hunter's Reach] ---- [Old Survey Camp]
     |                                        |
[Rootspan] -------- [Echo Sluice] ---- [Reliquary Works]
                                              |
                                       [Survey Vault]
                                              |
                                        [Warped Verge]
                                       /             \
                          [Veraya Fold]         [Echo Reservoir]
                                       \             /
                                    [Rewind Sanctuary]
                                              |
                                      [Folded Depths]
                                              |
                                      [Final Approach]
                                              |
                                    [Space-Time Boss]
                                              |
                                   [Warp-Broken Gate]
```

This graph is a planning sketch, not a committed map. The critical path should be easy
to understand from landmarks, while side routes reconnect and reward exploration. The
player should not need to collect every map scrap or relic to reach the ending.

### Region roles

| Region | Purpose and mood | Main discoveries |
|---|---|---|
| **Guild Town** | Safe, lively contrast to the dungeon. Establish the guild economy, Aster's hunter identity and the relic rumor. | Expedition reports, hunter relationships, preparation for the trip. |
| **Outer Wilds** | A low-risk approach with open-air space, plants, wildlife and the dungeon entrance. | Basic navigation, first enemy, route landmarks. |
| **Hunter's Reach** | Familiar hunting grounds with signs of other expeditions and optional branches. | Monster materials, the legendary team's trail, first map scrap. |
| **Old Survey Camp** | Abandoned hunter camp where maps and instruments stop agreeing with the world. | Critical clue toward the relic and the first evidence of spatial distortion. |
| **Echo Sluice / Rootspan** | Ancient water and Echo routing through a living root-covered bridge system. | First substantial world-system puzzle and a shortcut loop. |
| **Reliquary Works / Survey Vault** | Storage, cataloguing and protection of relics. | Map to Echo Rewind, relic inscriptions and ancient design language. |
| **Warped Verge** | Eldara and Veraya dungeon structures overlap. | Stronger monsters, alien architecture and clues that the warp joins two planetary dungeons. |
| **Echo Reservoir** | A major flow hub where Echoes move through the dungeon. | How Echo devices release Echoes into usable energy; a puzzle that alters routes elsewhere. |
| **Rewind Sanctuary** | The guarded site of the legendary relic. | Major guardian encounter and Aster's acquisition of Echo Rewind. |
| **Folded Depths** | Routes twist in space-time, changing sightlines and connections. | Rewind-based traversal, history fragments and the way toward the final gate. |
| **Final Approach** | The deepest guarded route, with a rest point before the climax. | Final signs of the broken warp pattern and a clear view of the boss arena/gate. |
| **Warp-Broken Gate** | A massive final gate damaged by the Echo Warp. | Aster cannot open it; Orion's game picks up the rescue. |

## 6. Story and chapter beats

The three chapters and their lengths are provisional. The full game target is 8–10 hours;
use pacing and playtesting to refine it rather than padding it with repetitive rooms.

### Opening and Chapter 1 — The relic rumor

1. A short animated opening shows an ordinary day in the guild town.
2. Hunters return, trade finds and prepare for dungeon expeditions. Aster's experience
   appears through a practical action, not a long explanation.
3. Aster hears the relic rumor. A legendary team came close to a time-distorted area
   but failed to reach the relic. Since the dungeon yields relics, Aster believes the
   rumor may be true.
4. Aster enters alone. The player learns basic movement and interaction in the Outer
   Wilds and outer dungeon.
5. Aster finds evidence from earlier hunters, fights first monsters and learns that
   defeated creatures release Echoes he can collect for his gear.
6. The Echo Warp occurs, merging the dungeons and sealing Aster inside. It changes
   routes and brings stronger monsters.
7. Aster investigates the Old Survey Camp, solves the Echo Sluice and faces an early
   mini-boss. The chapter ends with a map/clue pointing to Echo Rewind.

### Chapter 2 — The route to Echo Rewind

1. Aster compares the map clue with visible landmarks to plan a route through warped
   areas. A missing map piece can reveal an optional shortcut, but the critical clue is
   available on the main path.
2. He explores Eldara's and Veraya's connected dungeon structures and sees that the
   new routes follow a consistent Echo-network pattern.
3. He solves region puzzles that change the world: power or Echo flows redirect,
   bridges and lifts move, and doors open in distant connected areas.
4. Monsters have grown stronger around high-Echo areas. A mid-boss tests combat
   patterns learned in Chapter 1.
5. At the Rewind Sanctuary, a guardian protects the relic. After overcoming the
   encounter and sanctuary puzzle, Aster obtains Echo Rewind at the end of the chapter.

### Chapter 3 — The folded route and the broken gate

1. Aster revisits selected routes using Echo Rewind. It repositions/rewinds only Aster,
   not monsters or the world. The design teaches it in a safe traversal space before
   using it in a boss encounter.
2. He follows the world-scale clues toward the deepest gate and learns that the warp
   has damaged the dungeon's connections. Optional records foreshadow ancient Echo
   technology, Nalora and the Echoes' fate without resolving all of it.
3. A final guardian uses space-time attacks. Telegraphed attacks may originate above,
   behind or from an apparent spatial fold; the player reads the warning and uses
   movement or Echo Rewind to avoid/counter them.
4. Aster defeats the guardian and reaches the final gate. The Echo Warp has broken the
   gate's mechanism. Echo Rewind cannot restore a world-scale failure, so Aster remains
   trapped.
5. End on Aster recognizing he needs a different kind of expertise to solve the gate.
   Orion's game begins on Veraya and leads to the rescue.

## 7. The world-scale puzzle

### Main question

**How does this dungeon's Echo network work, and how can Aster use what he learns to
reach the way out?**

The player should solve local puzzles and gradually build a larger model. Clues can
come from repeated symbols, architectural alignments, old maps, Echo flow, mechanisms,
creature behavior and the differences between Eldara and Veraya structures.

### Proposed layers of discovery

1. **Read the surface:** repeated marks correspond to routes, devices or Echo channels.
2. **Learn cause and effect:** an activated machine changes more than one nearby room.
3. **Reconstruct geography:** map scraps and landmarks reveal loops; impossible new
   connections point to the warp.
4. **Compare worlds:** Veraya structures use related but not identical signs. Matching
   systems reveals how the dungeons connect.
5. **Infer the purpose:** relic-storage patterns and records show that the dungeon was
   built to protect and preserve powerful relics.
6. **Apply the knowledge:** Aster uses the system he has learned to reach Echo Rewind
   and later the final gate.

The whole-world puzzle should reward understanding, but not demand hidden trivia. The
critical route provides enough evidence to proceed; optional discoveries explain more.

## 8. Puzzle system

### A puzzle language

Each puzzle should have: a visible goal, clues the player can inspect, a rule that can
be inferred, an action to test the rule, and feedback that teaches. Avoid arbitrary
passwords without clues. Introduce an idea in a safe place, combine it with another
idea later, then test mastery under pressure only after the player has had a fair chance
to learn.

### First substantial puzzle: Echo Sluice

- **Goal:** restore a bridge by activating three Echo conductors in order.
- **Conductors:** Root Arch, Hanging Bell, Split Stone.
- **Clues:** a damaged plinth states that the center conductor goes last; a wall relief
  shows Root Arch before Hanging Bell; a light pulse confirms the sequence.
- **Working solution:** **Root Arch → Hanging Bell → Split Stone.**
- **Result:** the bridge rises and opens a loop back toward the Hunter's Reach.
- **Wrong attempt:** the nearby mechanism briefly resets and gives feedback. No long
  walk back to the room.

### Later puzzle families (current working canon; details can be refined)

| Family | Player reasoning | World response |
|---|---|---|
| **Echo routing** | Follow symbols and pulses to connect source, relay and receiver. | Powers a lift, bridge or route in another room. |
| **Map alignment** | Match fragments to landmarks and notice a missing connection. | Adds a safe route or points toward the next region. |
| **Relic sequence** | Combine a mural, found record and machine response to infer an order. | Opens a relic vault or reveals a memory. |
| **Warp topology** | Compare before/after maps and identify which doorway now links to Veraya. | Reveals a new dungeon loop. |
| **Rewind traversal** | Use Aster's recorded recent path/state to cross a timed hazard or return from a risky position. | Opens a route that depends on Aster's movement, not rewriting the world. |
| **Multi-room mechanism** | Find and activate related controls across a region. | Changes lights, water, lifts or doors across the map. |

### Fairness and difficulty

- Put the key clue in the room or a nearby branch; tell the player if a clue is optional.
- Let the map and journal preserve found clues. Players should not need to memorize a
  long symbol sequence from a prior hour.
- Wrong answers should give specific feedback, not simply “wrong.”
- Use checkpoints near bosses and long puzzle chains.
- Increase difficulty by combining learned rules, not by hiding the one required clue.
- Optional hint levels can go from a landmark nudge, to a rule reminder, to an explicit
  clue. Use playtesting to decide whether they are needed.

## 9. Combat, enemies and AI

### Combat goals

Combat should be deliberate and readable, with multiple weapons/equipment types and a
small set of enemy behaviors that combine into interesting encounters. Difficulty
should come from decisions and pattern reading, not oversized health pools or
untelegraphed damage. Aster uses Echoes to power gear by releasing them into usable
energy; equipment does not burn Echoes outright.

### Enemy AI pattern

Start with simple finite-state behavior: **Patrol → Notice → Approach → Telegraph →
Attack → Recovery → Patrol**. Enemies react to visible/heard Aster, may pursue his last
known position, and lose track of him after searching. Each attack has a readable tell
and recovery. Larger or later enemies can add guard, ranged, stagger and phase states.

### Proposed enemy roster

| Placeholder enemy | Role | Example behavior |
|---|---|---|
| **Echo Forager** | Basic common enemy; teaches spacing and dodging. | Patrols, notices Aster, crouches with a visible Echo glow, lunges at his last seen position, then pauses if it misses. Releases stored Echoes when defeated. |
| **Stonebound Guard** | Slow armored melee enemy. | Guards from the front, raises its arm before a heavy sweep, then exposes its back/core briefly. Teaches repositioning rather than repeated frontal attacks. |
| **Rift Skitter** | Fast warp-touched ambusher. | Appears at marked cracks or ceilings, gives an audio/visual warning, makes one quick attack, then retreats. It cannot attack from unmarked off-screen space. |
| **Prism Turret** | Stationary ranged pressure. | Tracks Aster slowly, paints a visible laser line, fires, then cools down. Cover or movement breaks its aim. |
| **Veraya Sentinel** | Mid-game unfamiliar construct from the merged dungeon. | Uses a guarded pulse, then a committed charge. Its pattern hints that the foreign dungeon shares the same Echo network. |

Names, appearances, stats and exact drops are current working canon and remain
adjustable as the roster is refined. Use a few archetypes well before adding many enemy
types.

### Proposed bosses and mini-bosses

| Encounter | Placement | Main mechanic and purpose |
|---|---|---|
| **Sluice Warden** (placeholder) | Chapter 1, Relic Watch. | Repeated wind-up slam creates a low floor shockwave; jump or move to safety, then strike while its arm is stuck and core exposed. At low health, two slams come with clear pauses. First boss-like combat lesson. |
| **Wayfinder Colossus** (placeholder) | Chapter 2, near the Rewind Sanctuary. | Large monster distorts positioning. It marks an area before a laser or strike arrives from above/behind. Aster reads the marker, dodges, and attacks during recovery. Tests observation before obtaining Echo Rewind. |
| **Fold Guardian** (placeholder) | Chapter 3, before the final gate. | Main boss uses spatial folds: marked attacks arrive from a portal point, the ceiling or behind. Later phase combines two known patterns. Aster's Echo Rewind can recover his own position after a mistake or help him reach a brief opening; it does not rewind the boss or cancel the warp. |

The exact number and ordering of bosses remain flexible. Mini-bosses may be optional or
on the critical path; each should teach a distinct pattern or reveal a story clue.

## 10. Items, map and progression

### Critical versus optional items

- **Critical map/clue:** found by the end of Chapter 1 and points toward Echo Rewind.
  It cannot be permanently missed.
- **Optional map scraps:** reveal side rooms, shortcuts or lore; never required to
  finish the main story.
- **Keys/mechanism parts:** open a specific door or restore a specific device. Show
  where they fit so they do not become arbitrary inventory clutter.
- **Echoes:** collected from defeated Echo-bearing monsters and spent/used according
  to a future resource specification. Preserve the release-to-energy principle.
- **Monster materials:** possible equipment upgrades or guild trade goods; economy is
  open.
- **Relic records:** explain the legendary team, relic safeguards and ancient network.
- **Equipment upgrades:** improve a chosen weapon or utility without replacing
  Echo Rewind as Aster's sole special ability.

### Echo Rewind progression

1. Before discovery: Aster relies on hunting skill, traversal, equipment and deduction.
2. Discovery: a guardian encounter and sanctuary sequence lead to the relic.
3. Safe tutorial: demonstrate the personal rewind in a low-risk space.
4. Practice: use it to return Aster along his own recent path or recover his position.
5. Mastery: combine it with previously learned timing, map reading and boss tells.

The exact rewind duration, cost, cooldown and state-rewind details must be reviewed
against the existing Aster design before implementation. The environment and enemies
are not rewound.

## 11. Story and cinematic presentation

Make the game feel cinematic through an authored rise and fall: short opening scene,
playable exploration, discovery, danger, quiet aftermath, a boss climax and a story
reveal. Use environmental storytelling for optional depth and concise scenes for
essential transitions. Give each chapter a clear question and answer:

- **Chapter 1:** Is the Echo Rewind rumor real, and why has the dungeon changed?
- **Chapter 2:** Where is the relic, and what does the merged dungeon reveal?
- **Chapter 3:** Can Aster get through the final gate? He defeats the guardian but the
  warp-broken gate leaves the answer for Orion's game.

Foreshadow Orion and *The Lost Echoes* with Veraya architecture, the displaced
creatures, anomalous Echo routes, and fragments about the ancient relic makers.
Do not resolve Nalora's full history or the trapped Echoes before the finale.

## 12. Scope and playtime target

Target **8–10 hours** total, subject to playtesting. A rough allocation to review:

| Portion | Approximate time |
|---|---:|
| Town opening and first dungeon hours | 1–1.5 h |
| Chapter 1 exploration, puzzle and boss | 1.5–2 h |
| Chapter 2 exploration and Echo Rewind acquisition | 2.5–3 h |
| Chapter 3 mastery, final boss and cliffhanger | 2.5–3 h |
| Optional branches, lore and mini-bosses | 1–2 h |

Avoid using backtracking and collectible hunting to inflate the target. Main-route
players should understand the story without 100% completion.

## 13. Decisions still needed before production

This canon and design are ready for review and continued refinement. Before building
all levels, we should decide:

1. Whether the proposed dungeon network and regions fit the creator's vision.
2. Aster's starting weapon/equipment and basic combat verbs.
3. How Echoes are collected, stored and spent before ancient efficient-use technology.
4. The final version of Echo Rewind's gameplay rules, within the established concept.
5. Which puzzles, enemies and bosses are core versus optional.
6. The exact 8–10 hour critical path and chapter pacing.
7. What clues about Nalora and the Echo Warp belong in Aster's game versus later games.

After these story and gameplay choices are reviewed, the next production step is a
small playable vertical slice: the town-to-dungeon opening, one route loop, Echo Sluice,
one common enemy and the Sluice Warden. Prototype with simple shapes first, tune
movement and combat, then create finished art.
