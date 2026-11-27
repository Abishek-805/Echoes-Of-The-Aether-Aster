# Production status — 2026-11-27

Target: Godot 4.7.2 Standard, GDScript, 640×360 logical view. This folder contains
the active game project. V2 design documents remain the narrative/system source except
for decisions in [Player-directed overrides](PLAYER_DIRECTED_OVERRIDES.md).

## Current playable foundation

- Title screen enters the campaign; a six-room mechanics sandbox is also retained.
- The campaign data contains 64 named room records connected by condition-gated routes.
- Open room links now transition when Aster crosses their physical screen-edge doorway;
  the destination entry side is preserved. Junctions and sealed exits still use the route
  panel, and room geometry remains placeholder work.
- The first 24 town/frontier, camp, sluice, and rootspan rooms now load room-specific platform layouts and story
  landmark anchors from `data/room_layouts.json`; collectibles anchored in those rooms appear at their
  documented world positions. These layouts still need hands-on jump and readability
  review.
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
- The campaign contract currently simulates the critical route through the distress
  signal/refuge ending with no optional weapon required.
- Major puzzles now reveal hints in three tiers, ending with the explicit solution only
  after the player requests it. The first Veraya Sentinel now commits to a warned charge
  direction and becomes vulnerable during recovery.
- Temporary geometric visuals remain intentional until core gameplay is complete.

## Controls and player-directed movement

The currently requested feature set includes double jump and shooting in the air.
These supersede conflicting older V2 controls. Keyboard, gamepad and touch foundations
exist; each target still needs an interactive hardware run.

## Not complete

- The 64 room records do not mean there are 64 individually authored, polished levels.
  Most spaces still use graybox room construction; route geometry and landmarks need
  authored iteration.
- Final animated cinematics, side-story completion and all journal unlocks need to be
  integrated/reviewed across the full campaign.
- Enemy and boss records need bespoke behavior, readable animations, tuning and play
  review rather than only generic graybox AI.
- Save integrity, remaining Rewind edge cases, map discoverability, every puzzle path,
  and all platform targets need further automated and hands-on verification.
- Final art, audio, accessibility, performance, export packaging and release QA remain
  future production work.
- Console deployment requires platform-holder access, SDKs and certification; a preset
  alone cannot validate a console build.

## Recent validation

Godot 4.7.2 headless import and script scan completed; 33 GDScript files checked, zero
broken. All 16 `*_contract.gd` checks passed, including physical room-edge transitions,
24 authored graybox layouts, three-tier puzzle hints, Warden and Sentinel attack tells,
platform controls, stable loot, story flags, and content references. The campaign contract
observed 62 reachable rooms, acquired Rewind, and reached the distress/refuge ending. The
240-frame main-scene smoke run had no script or engine errors. Windows, Linux, Web, and
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
