# Echoes of the Aether: Aster — Continuous World V4

**Proposed geography and construction overlay** for the approved V2 narrative and mechanics. No numbered level rooms. The sanctuary is one continuous geographical world; only authored fold thresholds transfer between planets. V3 room-based grayboxes are superseded, not deleted. No actual game code or finalized tiles are included.

## Read in this order
1. [World map instructions](WORLD_MAP_INSTRUCTIONS.md) — entire geographical design, route locks, 12 major puzzles and placement.
2. [Full editable blueprint](MAPS/WORLD_BLUEPRINT.svg) or [PNG](MAPS/WORLD_BLUEPRINT.png), paired with [artistic reference](REFERENCE/CONCEPT_MAP.png).
3. [Construction standards](CONSTRUCTION_STANDARDS.md) — tile scale, streaming, layer stack, ecosystem, traps, saves, UI and QA.
4. [Validation](VALIDATION.md) — exact static tests and remaining work.
5. `REGIONS/` — 16 detailed build sheets, each with local editable SVG, landmarks, routes, tile geometry guidance, puzzles, enemies, secrets, collectibles, scenery and wildlife.
6. `DATA/` — machine-readable JSON and CSV registers. These are design data, not engine scenes. Ingest after confirming design, then implement and test.

## Contents
16 region sheets, 87 landmarks (not rooms), 105 paths including seven shortcuts, 14 rest stations, 12 major puzzles, 16 minor challenges, six bosses and 56 collectibles. The six biome families and V2 lore remain. Weapons only use heat and Echo Energy; no reload. Collector releases Echoes and stores the released energy. Aster acquires only personal Echo Rewind. Gate remains physically broken at the ending.

Source references consulted: `ECHOES_OF_THE_AETHER_V2.zip` (canon, movement, resource system, art bible), `ASTER_WORLD_V3/DATA/world.json` and `WORLD_SYSTEMS.md` (puzzle/collectible/encounter migration), prior generated `echoes_of_the_aether_world_map.png` (concept). New anchor coordinates, geographical routing and local geometry are proposed creative decisions. No originals overwritten.
