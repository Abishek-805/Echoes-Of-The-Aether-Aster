# Production status — 2026-11-27

Target: Godot 4.7.2 Standard, GDScript, 640×360 logical view. This folder contains
the active game project. V2 design documents remain the narrative/system source except
for decisions in [Player-directed overrides](PLAYER_DIRECTED_OVERRIDES.md).

## Current playable foundation

- Title screen enters the campaign; a six-room mechanics sandbox is also retained.
- The campaign data contains 64 named room records connected by condition-gated routes.
- A physics-driven campaign runner verifies the six-room opening from Memorial Street through the
  Guild Hall, Artificer Yard, dungeon approach and first Forager encounter. It drives the map,
  double jump, jump-shoot, both opening consoles, physical doorways, ranged combat and the first
  Echo release. The full 64-room route is still graph/flag-tested rather than physically
  traversed end to end.
- Three elevated perches in ROT02, WAR02 and REW03 were lowered from near-limit jumps. A physics
  playtest confirms Aster can double-jump onto each and collect WAR02's nearby warning record.
- A live Sluice Warden playtest attacks only during actual recovery windows and reacts to
  shockwave hazards. It verifies the boss defeat flag; initial damage balance still needs review.
- Open room links now transition when Aster crosses their physical screen-edge doorway;
  the destination entry side is preserved. Junctions and sealed exits still use the route
  panel, and room geometry remains placeholder work.
- All 64 campaign rooms now load room-specific platform layouts and story landmark
  anchors from `data/room_layouts.json`; collectibles anchored in those rooms appear at
  their documented world positions. These graybox layouts still need hands-on jump,
  readability, and encounter-spacing review.
- The graybox campaign includes room loading, exploration tracking, a world map on M,
  journal and inventory panels, checkpoints, save/load, day/night tint, enemies,
  boss placeholders, puzzle panels, pickups, upgrades, health, Echo Energy, heat,
  melee, ranged fire, dodge, healing, and Rewind progression.
- Fifteen canon-aligned dialogue sequences are integrated at opening, clue, boss,
  Rewind, gate and ending beats. Continue/skip saves the same progression flags.
- The J journal now presents a campaign objective derived from the progression flags,
  alongside explored-room and collectible counts.
- Room collectibles now appear as world pickups and must be reached/interacted with;
  health shards, weapon unlocks and blueprints apply their rewards once. Markers are
  geometric placeholders and final placement/visuals still need play review.
- Double jump, air shooting and one-way platform drop-through are enabled. Rewind safely
  cancels and refunds its cost when a path becomes blocked before playback can move.
- Enemy Echo Energy and material rewards use stable per-room reward IDs, so a rest can
  respawn encounters for combat without duplicating their drops.
- Campaign saves validate the full state before mutating runtime progress, fall back to
  a semantically valid backup, migrate the documented V2 field layout, and warn instead
  of silently presenting a fresh run when both copies are unusable. Health, healing
  charges, weapon ownership/heat, Echo Energy, map/story progress and Rewind cooldown
  survive continuation; death restores the checkpoint and commits the documented reset.
- The campaign contract currently simulates the critical route through the distress
  signal/refuge ending with no optional weapon required; the separate physical runner verifies
  the first six-room route and the first live enemy encounter. The sandbox contract also checks
  jump, double jump, jump-shoot, heat/cooling and melee with zero Echo Energy.
- Major puzzles now reveal hints in three tiers, ending with the explicit solution only
  after the player requests it. The first Veraya Sentinel now commits to a warned charge
  direction and becomes vulnerable during recovery.
- All six named bosses now have distinct graybox attack patterns: directional Warden
  slams, Titan waves/debris, Colossus fold/beam/charge cycles, Keeper committed charges,
  Devourer delayed pools, and a three-phase Fold Guardian with offset final-phase lanes.
  Their telegraphs and recovery windows are automated; damage balance and animation still
  need hands-on play review.
- All eight enemy archetypes and four roster variants now use distinct graybox tells,
  attacks and recovery windows. Authored encounter zones control spawn positions and group
  counts; group rewards have unique stable IDs, and the Silent Gallery memory theatre stays
  enemy-free.
- The HUD now states whether Echo Rewind is locked, recording, ready, short on energy,
  active or cooling down, and explicitly marks overheated weapons.
- All seven canon optional stories are tracked in the field journal. Their evidence,
  completion flags and one-time rewards persist. M06 restores the garden and exposes its
  cache/shortcut; M12 uses the inscription record before matching Seren's imprint; M14
  exposes its cache after a real Rewind return, while its optional story also waits for the
  Devourer defeat. None gates the main route.
- Optional world-puzzle records M02–M15 now have clue-led, retryable room interactions;
  the authored caches and equipment rewards stay hidden until their local puzzle is solved.
  Their clues include inspectable room landmarks for the cache wiring diagram, hunter trail
  tags, loft receiver, and final service receiver. M07 records the Warden pulse before the
  optional Titan defeat. M09 adds custody lore to the field journal and opens its late return
  seam after Rewind mastery. M05 and M13 open their shortcut sluices when their valves are
  solved. M16 uses a physical Fold shutter that closes after Aster has a safe Rewind route;
  east-side FOL02 re-entry no longer activates the latch backward. Rewind temporarily passes
  this one shutter and restores collision afterward.
- Temporary geometric visuals remain intentional until core gameplay is complete.

## Controls and player-directed movement

The currently requested feature set includes double jump and shooting in the air.
These supersede conflicting older V2 controls. Keyboard, gamepad and touch foundations
exist; each target still needs an interactive hardware run.

## Not complete

- The 64 room records do not mean there are 64 individually authored, polished levels.
  Most spaces still use graybox room construction; route geometry and landmarks need
  authored iteration.
- Final animated cinematics and remaining journal/archive unlocks still need integration
  and review across the full campaign.
- Enemy and boss patterns need readable animation, balance tuning and hands-on play review
  beyond the automated behavior contracts.
- Remaining Rewind edge cases, map discoverability, every puzzle path,
  and all platform targets need further automated and hands-on verification.
- Final art, audio, accessibility, performance, export packaging and release QA remain
  future production work.
- Console deployment requires platform-holder access, SDKs and certification; a preset
  alone cannot validate a console build.

## Recent validation

Godot 4.7.2 headless import and script scan completed; 45 GDScript files checked, zero
broken. All 23 `*_contract.gd` checks passed, including campaign save validation, V2
save migration, semantic backup fallback, Rewind cooldown/resource persistence, HUD state,
seven side-story conditions/rewards, and M06/M12/M14 integration. Other contracts cover
physical room-edge transitions, 64 authored graybox layouts, three-tier puzzle hints,
Warden and Sentinel attack tells, all six distinct boss patterns, platform controls,
stable loot, story flags, and content references. The campaign contract
observed 62 reachable rooms, acquired Rewind, and reached the distress/refuge ending. The
minor-puzzle contract passed, checking all 10 optional reward gates, the two-part Titan
marker condition, the physical M16 shutter registration, and Rewind collision restoration.
The in-engine optional-puzzle integration runner passed M02 reward gating, M03 wrong-answer
reset and correct solution, M05/M13 shortcut gating, M07 marker-plus-Titan completion, M09
lore and return seam, M14 pre-boss cache access, and east-side M16 re-entry handling.
The opening physical runner passed through OUT02, defeated the first Forager and collected its
Echo. Separate physics playtests passed the three adjusted double-jump ledges and a six-window
Sluice Warden fight with tells, recovery attacks and healing. Starting at 100 HP with three
heals, the test finished at 64 HP after using all charges; the Warden still needs human balance
review. Windows, Linux, macOS and Web release exports were rebuilt with the adjusted room
layouts; the Windows headless launch completed. Android and iOS remain blocked by missing local
SDK/signing setup, and the other exports still need their native runtime/browser checks.
The 240-frame campaign-scene smoke run, exported Windows headless launch, and editor scan
had no script or engine errors. Windows, Linux, Web, and
macOS release exports completed; Android export is blocked by the missing JDK and Android
SDK, while iOS export requires the developer's Apple Team ID. These are code/data/export
checks, not interactive hardware, browser, or release-quality validation.

The OpenGame-derived workflow skill is installed globally at
`C:\Users\ashek\.codex\skills\opengame-workflow`. It is a Godot-specific adaptation,
not the OpenGame web-game CLI.

## Production rule

Keep the game completable with placeholders first, then replace them through the asset
pipeline. Preserve world identity in graybox via room purpose, route logic, landmarks,
clue placement, silhouette and environmental cause/effect. See
[Production plan](PRODUCTION_PLAN.md) and [requirements](REQUIREMENTS.md).
