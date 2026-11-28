# Hunter's Reach — geographical construction sheet

**Status:** proposed V4. Bounds (73,4)–(117,28) atlas units; one unit = 16 tiles = 256 logical pixels as a planning scale. These are terrain areas, not level rooms. The drawing is editable SVG: [local map](../MAPS/HUN.svg).

## 1. Place and historical purpose

A ridgeline of wooden hunting platforms wrapped around stone spires, not a straight corridor. Split Walk forks into an upper birdwatching hide, a lower canopy trail and the main ridge. Skyhunt Tower is a viewpoint reached by staggered walkable ledges, not a new jump power. Trigger the Warp only after the player is safely beyond the cut point at Fracture Crossing: freeze input briefly for the authored scene, restore control on a stable ledge, permanently close the town route, and open the camp descent. On return the player sees broken ropes and a missing distant vista; surface communication fails. Foragers patrol ground and Rift Skitters appear only after the event. Steam vents are old human field equipment and visibly warn. Bristle Hares retreat to brush, Copperwings scatter on first shock; no repeated cutscene. Place map clue tags near branch points, not floating in empty air.

## 2. Terrain geometry and tile placement

At Split Walk create a Y-fork with three 8-tile landing pads, higher platform reachable via ladder. Tower uses 2-tile ledge increments or lift, 6-tile landings. Fracture trigger sits 12 tiles after the last safe return shelf; after event place collision at cut, not on top of player. Camp descent follows a zigzag with 6-tile stop platforms.

Set anchor foot surfaces at the coordinates in the table after multiplying by 16 tiles; refine surrounding contour locally. Keep ≥4-tile head clearance; target ≤2-tile rise and ≤4-tile mandatory gap. Do not interpolate steep atlas lines into unclimbable slopes: use the listed path profiles. The exact microgeometry is a blockout task, not an approved collision layout.

## 3. Landmarks and placement anchors

| Map mark | ID / landmark | Atlas (x,y) | Tile anchor | Role | State grants |
| --- | --- | --- | --- | --- | --- |
| 1 | HUN-TRAIL / Hunter Trail | (75,20) | (1200,320) | Old ropes and trail tags | — |
| 2 | HUN-SPLIT / Split Walk | (83,15) | (1328,240) | Spillway return landing, lower canopy fork | — |
| 3 | HUN-FRACT / Fracture Crossing | (94,18) | (1504,288) | Authored Warp event and cut to surface | WARP |
| 4 | HUN-BLIND / Abandoned Blind | (87,6) | (1392,96) | Optional hide on high ledge | — |
| 5 | HUN-TOWER / Skyhunt Tower | (109,8) | (1744,128) | Tall bell-facing observation platform | — |
| 6 | HUN-DESC / Camp Descent | (111,26) | (1776,416) | Rocky switchback to camp | — |

## 4. Actual traversable connections

Every connection is two-way unless documented; conditions are persistent and must be checked in both directions. A crossing on the atlas is not a junction. For intersecting schematic routes, adjust local geometry/height or use an authored separated passage; do not accidentally connect them.

| Route | From → To | Mode | Condition / closure | Design |
| --- | --- | --- | --- | --- |
| PATH-012 | Broken Aqueduct ↔ Hunter Trail | walk | open | Rooted natural transition; scout ropes become hunter structures |
| PATH-013 | Hunter Trail ↔ Split Walk | stairs | open | Ridge switchback and tree deck |
| PATH-014 | Split Walk ↔ Abandoned Blind | ladder | open | Three cloth trail markers, M03 |
| PATH-015 | Abandoned Blind ↔ Skyhunt Tower | terraces | open | Upper ridge view of distant Bell; no shortcut to post-Warp camp before event |
| PATH-016 | Skyhunt Tower ↔ Fracture Crossing | stairs | open | Descend to fracture trigger |
| PATH-017 | Split Walk ↔ Fracture Crossing | walk | open | Main ridge bridge, authored Warp trigger |
| PATH-018 | Fracture Crossing ↔ Camp Descent | terraces | WARP | Stable downhill switchback revealed after fracture |
| PATH-019 | Camp Descent ↔ Camp Shelter | stairs | WARP | Camp trail down the cliff |
| PATH-020 | Split Walk ↔ Crown Fork | stairs | open | Early upper canopy overlook; no descent to lower Rootspan until Warden |
| PATH-035 | High Spillway ↔ Split Walk | lift | SLUICE_OPEN, SPILL_OPEN | S01 catchment ladder and service ledge; separate deck above ridge viaduct |

### Local traversal profiles

- **Walk:** Start with 12–20 tiles of legible walking surface, then vary height with 1–2 tile steps. Introduce one sheltered side recess and preserve a 4-tile head clearance. Break long stretches with a landmark, change in surface or deliberate encounter.
- **Stairs:** Build walkable flights with 1–2 tile rises, 3–6 tile treads, and a ≥6 tile landing every 8–12 vertical tiles. Use lifts/ladders if the macro elevation exceeds practical stairs. Provide safe reversible down-route and mark drop-through surfaces.
- **Ladder:** Use an authored ladder or ordinary climbable structure with clear entry and exit pads ≥6 tiles wide, no enemy at the dismount. Allow both directions; no new ability.
- **Terraces:** Use staggered 6–12 tile platforms with ≤2 tile rises and ≤4 tile mandatory gaps; add a lower recovery deck, not a lethal void. Hide optional ledges in scenery only with a visible cue.
- **Lift:** Use a platform lift or counterweight with a 6–10 tile deck, call button at both ends, stable landings and anti-crush sensor. For long mixed routes, alternate horizontal galleries and lifts rather than a single enormous vertical shaft.

## 5. Puzzles, secrets, rewards and lore

- **M03 at Abandoned Blind:** Follow three hunter tags to find blind. Reward: DAWN02, MAP02. Wrong input resets locally; never gate critical route with this optional activity (M01 is safe onboarding practice).

| Anchor | Discoveries / reward IDs | Environmental hint |
| --- | --- | --- |
| Hunter Trail | — | Old ropes and trail tags |
| Split Walk | — | Three tags lead to blind; spillway ladder visible but folded up |
| Fracture Crossing | — | Authored Warp event and cut to surface |
| Abandoned Blind | DAWN02: Trail departure; MAP02: optional map annotation | Three cloth strips; bird perched on broken railing |
| Skyhunt Tower | — | Tall bell-facing observation platform |
| Camp Descent | — | Rocky switchback to camp |

## 6. Encounters and hazards

**Hunter Trail:** E01 (E01-HUN01), stream (HZ-HUN01). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**Split Walk:** steam (HZ-HUN02). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**Fracture Crossing:** V02 (V02-HUN03), rift (HZ-HUN03). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

All other stretches are deliberately free of required combat. Do not populate every screen. Place hostiles only in traversable habitats, at least one camera look-ahead from protected interaction spaces, and never within rest station safety bubbles.

## 7. Scenery composition and ecosystem

**Hunter Trail** — Hunting trail under giant trees, watch platforms and prey tracks; two separated Forager encounters.. Ambient design carried forward: 1 hare behind grass and 2 Copperwings behind canopy; retreat when combat begins. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Split Walk** — A fork with a high watch shelf and three rope tags; distant sluice channel visibly meets the path; anomaly lights flicker.. Ambient design carried forward: 2 birds perched before Warp; fly away at anomaly; folded ladder behind foreground rope. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Fracture Crossing** — Wide fractured courtyard with a view of the collapsed surface passage; safe scripted Warp reveal, then Saturated Forager.. Ambient design carried forward: 3 birds scatter once during Warp; post-Warp no bird spawns, only dust. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Abandoned Blind** — Abandoned hunting blind above an empty feeding trail; snapped rope, lost expedition tag and scattered equipment.. Ambient design carried forward: 1 perched bird on railing, ambient only. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Skyhunt Tower** — Tall bell-facing observation platform. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Camp Descent** — Rocky switchback to camp. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

Layer assignments: L00–L03 horizon/silhouette/midground; L04 noncombat wildlife; L05 near walls/props and lore; L06 collision; L07 actors; L08 telegraphs/ability effects; L09 foreground fade; L10 atmosphere. Use only the layers that fit the place. See [construction standards](../CONSTRUCTION_STANDARDS.md).

## 8. Save, transitions and acceptance

Rest stations: none; use adjacent regions, with protected story saves where required. Workbenches: none. All save IDs use landmark IDs, not scene filenames. Save durable changes, flags, discovery, resource transactions; do not save ephemeral hazard phase.

For each path, walk it in both directions with the real controller, test first entry at zero EE and full heat, verify camera sightlines, check before/after state, prove the required gate cannot be bypassed, check return from optional branches, and test save/load after persistent changes. Only accept the region after blind playtest.
