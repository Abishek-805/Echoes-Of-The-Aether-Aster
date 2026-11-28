# Outer Wilds — geographical construction sheet

**Status:** proposed V4. Bounds (30,4)–(69,26) atlas units; one unit = 16 tiles = 256 logical pixels as a planning scale. These are terrain areas, not level rooms. The drawing is editable SVG: [local map](../MAPS/OUT.svg).

## 1. Place and historical purpose

A broad open-air foothill valley between the town and the sanctuary rim. The path descends to a shallow brook, then rises along a ruined aqueduct; its broken span is supported by stone piers and accessible lower recovery deck. The bell tower is visible from two distinct elevations. No deep-water swimming; fish are in a background stream or below a traversable bank. Tall grass in foreground is faded near Aster. Tutorial Forager patrols a flat clearing with a retreat route, no offscreen attack. Introduce jump and dodge in separate low-risk stretches. Use grass-top edges, dirt interior, exposed rock corner, fallen pale-alloy conduit; the path blends to cut stone over 6–10 tiles. Copperwings, Bristle Hares, Lantern Moths and Ribbonfish establish normal ecology. After Warp the entrance to town is blocked at the cut corridor; the surviving wilds remain revisitable.

## 2. Terrain geometry and tile placement

At Brook Crossing create a 24-tile clearing, 3-tile crossing gap with recovery bank 2 tiles down, then 2-tile stair rise. At Bell Overlook give a 14-tile clear vista; cache entry behind a 6-tile overhang with repeated Source mark. Aqueduct piers are 4–6 tiles thick and support decks; show a lower crossing if the upper span is broken.

Set anchor foot surfaces at the coordinates in the table after multiplying by 16 tiles; refine surrounding contour locally. Keep ≥4-tile head clearance; target ≤2-tile rise and ≤4-tile mandatory gap. Do not interpolate steep atlas lines into unclimbable slopes: use the listed path profiles. The exact microgeometry is a blockout task, not an approved collision layout.

## 3. Landmarks and placement anchors

| Map mark | ID / landmark | Atlas (x,y) | Tile anchor | Role | State grants |
| --- | --- | --- | --- | --- | --- |
| 1 | OUT-TRAIL / Trailhead Shelter | (33,17) | (528,272) | First rest, ridge overlooks town | — |
| 2 | OUT-BROOK / Brook Crossing | (41,22) | (656,352) | First Forager and safe collection lesson | FIRST_RELEASE |
| 3 | OUT-BELL / Bell Overlook | (55,12) | (880,192) | View Hanging Bell, split rock and distant Great Root | — |
| 4 | OUT-CACHE / Hunter Cache | (49,6) | (784,96) | Optional concealed trail and memorial | CACHE_OPEN |
| 5 | OUT-AQUA / Broken Aqueduct | (65,20) | (1040,320) | Natural traversal across stepped stone terraces | — |

## 4. Actual traversable connections

Every connection is two-way unless documented; conditions are persistent and must be checked in both directions. A crossing on the atlas is not a junction. For intersecting schematic routes, adjust local geometry/height or use an authored separated passage; do not accidentally connect them.

| Route | From → To | Mode | Condition / closure | Design |
| --- | --- | --- | --- | --- |
| PATH-006 | East Road ↔ Trailhead Shelter | walk | TUTORIAL_DONE / closed on WARP | Surface passage physically cut by Warp; persistent closure |
| PATH-007 | Trailhead Shelter ↔ Brook Crossing | terraces | open | Downhill meadow and recovery bank |
| PATH-008 | Brook Crossing ↔ Bell Overlook | terraces | FIRST_RELEASE | Broken aqueduct climbs by stairs and 2-tile ledges |
| PATH-009 | Bell Overlook ↔ Hunter Cache | stairs | open | Source sign near hidden rock cache, M02 local latch |
| PATH-010 | Hunter Cache ↔ Trailhead Shelter | stairs | CACHE_OPEN | Return trail behind grassy rock; cache route not mandatory |
| PATH-011 | Bell Overlook ↔ Broken Aqueduct | terraces | open | Stone aqueduct rim, no mandatory long gap |
| PATH-012 | Broken Aqueduct ↔ Hunter Trail | walk | open | Rooted natural transition; scout ropes become hunter structures |

### Local traversal profiles

- **Walk:** Start with 12–20 tiles of legible walking surface, then vary height with 1–2 tile steps. Introduce one sheltered side recess and preserve a 4-tile head clearance. Break long stretches with a landmark, change in surface or deliberate encounter.
- **Terraces:** Use staggered 6–12 tile platforms with ≤2 tile rises and ≤4 tile mandatory gaps; add a lower recovery deck, not a lethal void. Hide optional ledges in scenery only with a visible cue.
- **Stairs:** Build walkable flights with 1–2 tile rises, 3–6 tile treads, and a ≥6 tile landing every 8–12 vertical tiles. Use lifts/ladders if the macro elevation exceeds practical stairs. Provide safe reversible down-route and mark drop-through surfaces.

## 5. Puzzles, secrets, rewards and lore

- **M02 at Hunter Cache:** Match Source sign to receiver to open cache. Reward: MAP01, BP01. Wrong input resets locally; never gate critical route with this optional activity (M01 is safe onboarding practice).

| Anchor | Discoveries / reward IDs | Environmental hint |
| --- | --- | --- |
| Trailhead Shelter | — | First rest, ridge overlooks town |
| Brook Crossing | — | Side path marked by rope and torn cloth |
| Bell Overlook | AR02: Source and conduit marks | View Hanging Bell, split rock and distant Great Root |
| Hunter Cache | MAP01: optional map annotation; BP01: equipment blueprint; MEM01: hidden memorial | Two matching source carvings and a path of flattened grass |
| Broken Aqueduct | — | Natural traversal across stepped stone terraces |

## 6. Encounters and hazards

**Brook Crossing:** E01 (E01-OUT02), stream (HZ-OUT02). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**Bell Overlook:** fall (HZ-OUT03). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

All other stretches are deliberately free of required combat. Do not populate every screen. Place hostiles only in traversable habitats, at least one camera look-ahead from protected interaction spaces, and never within rest station safety bubbles.

## 7. Scenery composition and ecosystem

**Trailhead Shelter** — Town walls recede behind a grassy trail; rest shelter and trail marker frame the first view of the sanctuary.. Ambient design carried forward: 3 Copperwings over trees; 1 bristle hare near ; wind in grass. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Brook Crossing** — Open meadow and fallen aqueduct; first Forager on wide ground, a shallow stream and fluttering insects; teach safe release.. Ambient design carried forward: 2 lantern moths near flowers; 1 hare flees before Forager appears; ribbonfish silhouettes in background stream. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Bell Overlook** — Climb a low stepped escarpment to a panoramic view of the Hanging Bell and split rock; source marks on the railing.. Ambient design carried forward: 3 Copperwings far ridge; one flock crosses bell view. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Hunter Cache** — Hunter cache beneath a broken arch; receiver lock and a tiny memorial tucked behind vegetation.. Ambient design carried forward: 2 moths reveal cache flowers; no aggressive fauna. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Broken Aqueduct** — Natural traversal across stepped stone terraces. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

Layer assignments: L00–L03 horizon/silhouette/midground; L04 noncombat wildlife; L05 near walls/props and lore; L06 collision; L07 actors; L08 telegraphs/ability effects; L09 foreground fade; L10 atmosphere. Use only the layers that fit the place. See [construction standards](../CONSTRUCTION_STANDARDS.md).

## 8. Save, transitions and acceptance

Rest stations: Trailhead Shelter. Workbenches: none. All save IDs use landmark IDs, not scene filenames. Save durable changes, flags, discovery, resource transactions; do not save ephemeral hazard phase.

For each path, walk it in both directions with the real controller, test first entry at zero EE and full heat, verify camera sightlines, check before/after state, prove the required gate cannot be bypassed, check return from optional branches, and test save/load after persistent changes. Only accept the region after blind playtest.
