# Reliquary Works — geographical construction sheet

**Status:** proposed V4. Bounds (82,46)–(119,64) atlas units; one unit = 16 tiles = 256 logical pixels as a planning scale. These are terrain areas, not level rooms. The drawing is editable SVG: [local map](../MAPS/REL.svg).

## 1. Place and historical purpose

Old manufacturing and repair facilities built to service relics. The outer wall grows through Rootspan; roots penetrate panels before giving way to dry industrial floors. Main spine is a broad maintenance road, above it a suspended crane rail, below it a nonlethal inspection trench. P03 follows a lit source conduit up to a relay and down to a receiver; isolate dead archive spur. Service doors open from both sides after power returns. Golem Walk introduces armored guards with enough space to flank. Prism beams use one-second warnings and safe niches. A service lift climbs to the optional Storage Loft; restore its relay to open a connection back to canopy. Steam vent platforms are optional hazards with readable timing. No foundry molten floor on the mandatory route; visual furnace behind glass. Vault geckos and dust moths occupy broken wall cavities, no wildlife inside active furnaces. Use Foozle laboratory geometry mixed with pale stone and original Vaelari conduit trim.

## 2. Terrain geometry and tile placement

Workshop flat 16 tiles; relay console atop 8-tile mezzanine; line of sight to source and receiver. Golem lane 22–30 tiles with bypass step and space to flank. Beam lanes 3 tiles wide with ≥6 tile safe wait niches. Loft lift 8 tiles wide; mechanical rails background unless marked walkable. Foundry trench lower recovery walkway 2 tiles below main path.

Set anchor foot surfaces at the coordinates in the table after multiplying by 16 tiles; refine surrounding contour locally. Keep ≥4-tile head clearance; target ≤2-tile rise and ≤4-tile mandatory gap. Do not interpolate steep atlas lines into unclimbable slopes: use the listed path profiles. The exact microgeometry is a blockout task, not an approved collision layout.

## 3. Landmarks and placement anchors

| Map mark | ID / landmark | Atlas (x,y) | Tile anchor | Role | State grants |
| --- | --- | --- | --- | --- | --- |
| 1 | REL-WORK / Workshop | (84,54) | (1344,864) | Rest/workbench, first alloy view | — |
| 2 | REL-RELAY / Service Relay | (94,49) | (1504,784) | P03 source and receiver routing | WORKS_POWER |
| 3 | REL-GOLEM / Golem Foundry Walk | (107,54) | (1712,864) | Armored constructs and furnace | — |
| 4 | REL-LOFT / Storage Loft | (111,46) | (1776,736) | Optional relay, carbine, cache | LOFT_RELAY |
| 5 | REL-DRAIN / Archive Service Road | (88,62) | (1408,992) | Quiet westbound maintenance viaduct | — |

## 4. Actual traversable connections

Every connection is two-way unless documented; conditions are persistent and must be checked in both directions. A crossing on the atlas is not a junction. For intersecting schematic routes, adjust local geometry/height or use an authored separated passage; do not accidentally connect them.

| Route | From → To | Mode | Condition / closure | Design |
| --- | --- | --- | --- | --- |
| PATH-045 | Foundry Footbridge ↔ Workshop | walk | WARDEN_DOWN | Roots intrude on industrial maintenance walkway |
| PATH-046 | Workshop ↔ Service Relay | stairs | open | Source to service relay and receiver |
| PATH-047 | Service Relay ↔ Golem Foundry Walk | walk | WORKS_POWER | Service gate opens to foundry road |
| PATH-048 | Golem Foundry Walk ↔ Storage Loft | lift | open | Suspended crane maintenance lift; M08 |
| PATH-049 | Storage Loft ↔ Great Root Canopy | viaduct | LOFT_RELAY, WARDEN_DOWN | S03 maintenance rail over root terrace |
| PATH-050 | Golem Foundry Walk ↔ Archive Service Road | terraces | open | Cooling trench and lower archive service road |
| PATH-051 | Archive Service Road ↔ Archive Steps | viaduct | open | Stone archive viaduct across central span, separate above Warped Verge |

### Local traversal profiles

- **Walk:** Start with 12–20 tiles of legible walking surface, then vary height with 1–2 tile steps. Introduce one sheltered side recess and preserve a 4-tile head clearance. Break long stretches with a landmark, change in surface or deliberate encounter.
- **Stairs:** Build walkable flights with 1–2 tile rises, 3–6 tile treads, and a ≥6 tile landing every 8–12 vertical tiles. Use lifts/ladders if the macro elevation exceeds practical stairs. Provide safe reversible down-route and mark drop-through surfaces.
- **Lift:** Use a platform lift or counterweight with a 6–10 tile deck, call button at both ends, stable landings and anti-crush sensor. For long mixed routes, alternate horizontal galleries and lifts rather than a single enormous vertical shaft.
- **Viaduct:** Build a continuous bridge/maintenance gallery 6–10 tiles wide at minimum local landing, 4+ tile headroom, strong structural supports, occasional inspection recess and varied skyline. Long span needs side discoveries and periodic cover/rest niches.
- **Terraces:** Use staggered 6–12 tile platforms with ≤2 tile rises and ≤4 tile mandatory gaps; add a lower recovery deck, not a lethal void. Hide optional ledges in scenery only with a visible cue.

## 5. Puzzles, secrets, rewards and lore

### P03 — Service Relay

- Clues: Power maintenance receiver. Wall flow diagram and arrows show source→relay→receiver; blocked archive branch.
- Solution: Connect source to service relay, relay to receiver; leave dead archive branch isolated.
- Result / failure: Door opens to REL03; disconnected receiver icon or overload alarm on mistake.
- State: `WORKS_POWER`. Record clues automatically and supply a local reset; no optional item or player EE is required except Rewind exercise with recharge.

- **M08 at Storage Loft:** Connect loft relay to receiver, inspect cache. Reward: LOFT_RELAY, HP02, BP03, WPN01. Wrong input resets locally; never gate critical route with this optional activity (M01 is safe onboarding practice).

| Anchor | Discoveries / reward IDs | Environmental hint |
| --- | --- | --- |
| Workshop | — | Rest/workbench, first alloy view |
| Service Relay | AR07: Maintenance receiver | Service lift to loft with unlit relay icon |
| Golem Foundry Walk | — | Armored constructs and furnace |
| Storage Loft | AR08: Vault manufacture; DAWN06: Vault attempt; HP02: +10 max HP; BP03: equipment blueprint; WPN01: Scatter Carbine | Conduit terminates at hidden relay behind shelf |
| Archive Service Road | — | Quiet westbound maintenance viaduct |

## 6. Encounters and hazards

**Service Relay:** E02 (E02-REL02), steam (HZ-REL02). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**Golem Foundry Walk:** E02 (E02-REL03), V01 (V01-REL03). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**Storage Loft:** E04 (E04-REL04), beam (HZ-REL04). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

All other stretches are deliberately free of required combat. Do not populate every screen. Place hostiles only in traversable habitats, at least one camera look-ahead from protected interaction spaces, and never within rest station safety bubbles.

## 7. Scenery composition and ecosystem

**Workshop** — Ancient workshop converted into hunter workbench; rest station, spare parts, long pale-alloy arches.. Ambient design carried forward: Dust motes, workshop fan, no wildlife on machinery. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Service Relay** — Maintenance hall with raised pipe run, receiver terminal and marked steam nozzle; Stonebound Guard away from panel.. Ambient design carried forward: 1 vault gecko retreats to wall; steam and dust. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Golem Foundry Walk** — Alternating guard bays and cover piers; stone and metal guards; service door into archive stairs.. Ambient design carried forward: No fauna in active defense zone; moving mechanical pistons behind walls. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Storage Loft** — Storage loft with isolated turret, intact crates, relay switch and blueprint cabinet; hatch overlooks Rootspan canopy.. Ambient design carried forward: 2 dust moths near cool shelf away from turret. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Archive Service Road** — Quiet westbound maintenance viaduct. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

Layer assignments: L00–L03 horizon/silhouette/midground; L04 noncombat wildlife; L05 near walls/props and lore; L06 collision; L07 actors; L08 telegraphs/ability effects; L09 foreground fade; L10 atmosphere. Use only the layers that fit the place. See [construction standards](../CONSTRUCTION_STANDARDS.md).

## 8. Save, transitions and acceptance

Rest stations: Workshop. Workbenches: Workshop. All save IDs use landmark IDs, not scene filenames. Save durable changes, flags, discovery, resource transactions; do not save ephemeral hazard phase.

For each path, walk it in both directions with the real controller, test first entry at zero EE and full heat, verify camera sightlines, check before/after state, prove the required gate cannot be bypassed, check return from optional branches, and test save/load after persistent changes. Only accept the region after blind playtest.
