# Old Survey Camp — geographical construction sheet

**Status:** proposed V4. Bounds (87,30)–(119,44) atlas units; one unit = 16 tiles = 256 logical pixels as a planning scale. These are terrain areas, not level rooms. The drawing is editable SVG: [local map](../MAPS/CAM.svg).

## 1. Place and historical purpose

A small expedition site tucked beneath the hunter ridge. Broken guy ropes, weathered tents and overturned diagnostic stands tell the story of a hurried evacuation. The main path descends from the shelter to the tent and a survey overlook. An optional high ledge holds a torn pack and has a return ramp; do not force climbing the whole ridge again. The restored map reveals an old public-maintenance passage west across the head of the valley. The gate is a mechanical route barrier, not a blank wall. P02 uses bell, split rock and camp arch as three actual visible landmarks. Keep orientation consistent across the overworld and journal. Minimal combat: one Forager patrol outside the shelter, no enemy interrupting the map UI. Rainwater drips into pans, a Copperwing may land after the Warp settles; the camp is quiet rather than fully dead.

## 2. Terrain geometry and tile placement

Shelter platform 16 tiles wide, no hostile collider within 12 tiles. Tent path 8-tile sightline to map board; separate higher ledge with torn pack and 2-tile down steps. Survey board stays on solid flat platform; opening gate at upper ridge has 8-tile landing both sides.

Set anchor foot surfaces at the coordinates in the table after multiplying by 16 tiles; refine surrounding contour locally. Keep ≥4-tile head clearance; target ≤2-tile rise and ≤4-tile mandatory gap. Do not interpolate steep atlas lines into unclimbable slopes: use the listed path profiles. The exact microgeometry is a blockout task, not an approved collision layout.

## 3. Landmarks and placement anchors

| Map mark | ID / landmark | Atlas (x,y) | Tile anchor | Role | State grants |
| --- | --- | --- | --- | --- | --- |
| 1 | CAM-SHELTER / Camp Shelter | (110,33) | (1760,528) | Post-Warp safe shelter and rest | — |
| 2 | CAM-TENT / Map Tent | (103,37) | (1648,592) | Dawn instruments and notes | — |
| 3 | CAM-CROSS / Survey Crossing | (94,39) | (1504,624) | P02, compare three landmarks | MAP_ALIGNED |
| 4 | CAM-PACK / Lost Pack Ledge | (115,42) | (1840,672) | Optional torn map cache | — |
| 5 | CAM-RIDGE / Upper Service Ridge | (88,32) | (1408,512) | Continuous aqueduct trail to Echo Sluice | — |

## 4. Actual traversable connections

Every connection is two-way unless documented; conditions are persistent and must be checked in both directions. A crossing on the atlas is not a junction. For intersecting schematic routes, adjust local geometry/height or use an authored separated passage; do not accidentally connect them.

| Route | From → To | Mode | Condition / closure | Design |
| --- | --- | --- | --- | --- |
| PATH-019 | Camp Descent ↔ Camp Shelter | stairs | WARP | Camp trail down the cliff |
| PATH-021 | Camp Shelter ↔ Map Tent | walk | open | Sheltered camp terraces |
| PATH-022 | Map Tent ↔ Survey Crossing | walk | open | Survey board with direct sightline to landmarks |
| PATH-023 | Camp Shelter ↔ Lost Pack Ledge | stairs | open | Optional lost pack ledge, M04 |
| PATH-024 | Lost Pack Ledge ↔ Map Tent | stairs | open | Recovery slope around camp |
| PATH-025 | Survey Crossing ↔ Upper Service Ridge | stairs | MAP_ALIGNED | Old maintenance barrier opens after map alignment |
| PATH-026 | Upper Service Ridge ↔ Conduit Entry | viaduct | MAP_ALIGNED | Upper catchment viaduct; scenic connection above Rootspan, no downward access except authored stairs |

### Local traversal profiles

- **Stairs:** Build walkable flights with 1–2 tile rises, 3–6 tile treads, and a ≥6 tile landing every 8–12 vertical tiles. Use lifts/ladders if the macro elevation exceeds practical stairs. Provide safe reversible down-route and mark drop-through surfaces.
- **Walk:** Start with 12–20 tiles of legible walking surface, then vary height with 1–2 tile steps. Introduce one sheltered side recess and preserve a 4-tile head clearance. Break long stretches with a landmark, change in surface or deliberate encounter.
- **Viaduct:** Build a continuous bridge/maintenance gallery 6–10 tiles wide at minimum local landing, 4+ tile headroom, strong structural supports, occasional inspection recess and varied skyline. Long span needs side discoveries and periodic cover/rest niches.

## 5. Puzzles, secrets, rewards and lore

### P02 — Survey Crossing

- Clues: From the survey board the Hanging Bell is west-northwest (OUT-BELL vicinity); Split Rock is the distinct east-northeast ridge silhouette at atlas (116,29); Camp Arch is the origin. Map Tent sketch records all three.
- Solution: Align bell west-northwest, Split Rock east-northeast, Camp Arch at origin; confirm maintenance link to Echo Sluice.
- Result / failure: Reveals the westbound upper service ridge; mismatch highlights the incorrect landmark. Compass directions supersede old V3 positions.
- State: `MAP_ALIGNED`. Record clues automatically and supply a local reset; no optional item or player EE is required except Rewind exercise with recharge.

- **M04 at Lost Pack Ledge:** Align torn map to bell silhouette. Reward: DAWN04, MAP03. Wrong input resets locally; never gate critical route with this optional activity (M01 is safe onboarding practice).

| Anchor | Discoveries / reward IDs | Environmental hint |
| --- | --- | --- |
| Camp Shelter | — | Post-Warp safe shelter and rest |
| Map Tent | AR03: Shared sanctuary manufacture; DAWN03: Survey instruments | Torn map points toward lost pack |
| Survey Crossing | — | P02, compare three landmarks |
| Lost Pack Ledge | DAWN04: Lost pack; MAP03: optional map annotation | Scratched trail markers and loose canvas |
| Upper Service Ridge | — | Continuous aqueduct trail to Echo Sluice |

## 6. Encounters and hazards

**Lost Pack Ledge:** fall (HZ-CAM04). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

All other stretches are deliberately free of required combat. Do not populate every screen. Place hostiles only in traversable habitats, at least one camera look-ahead from protected interaction spaces, and never within rest station safety bubbles.

## 7. Scenery composition and ecosystem

**Camp Shelter** — Overgrown survey shelter with rest bench; rain on canvas, old fire pit and silent instruments.. Ambient design carried forward: Rain drips and 2 moths under canvas; quiet rest. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Map Tent** — Collapsed map tent with bell sketch, split rock sample and compass; no combat near critical clues.. Ambient design carried forward: Moth near lantern; paper flutters in draft. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Survey Crossing** — Survey platform with three visible landmarks framed through apertures; map alignment terminal beside closed maintenance door.. Ambient design carried forward: Distant Copperwings only visible through open window. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Lost Pack Ledge** — Ledge below the tent; broken survey case beside roots, torn map fits the bell silhouette.. Ambient design carried forward: 1 hare under roots if stable; otherwise fallen leaves. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Upper Service Ridge** — Continuous aqueduct trail to Echo Sluice. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

Layer assignments: L00–L03 horizon/silhouette/midground; L04 noncombat wildlife; L05 near walls/props and lore; L06 collision; L07 actors; L08 telegraphs/ability effects; L09 foreground fade; L10 atmosphere. Use only the layers that fit the place. See [construction standards](../CONSTRUCTION_STANDARDS.md).

## 8. Save, transitions and acceptance

Rest stations: Camp Shelter. Workbenches: none. All save IDs use landmark IDs, not scene filenames. Save durable changes, flags, discovery, resource transactions; do not save ephemeral hazard phase.

For each path, walk it in both directions with the real controller, test first entry at zero EE and full heat, verify camera sightlines, check before/after state, prove the required gate cannot be bypassed, check return from optional branches, and test save/load after persistent changes. Only accept the region after blind playtest.
