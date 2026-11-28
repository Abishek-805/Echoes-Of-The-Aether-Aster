# Echo Sluice — geographical construction sheet

**Status:** proposed V4. Bounds (5,29)–(36,53) atlas units; one unit = 16 tiles = 256 logical pixels as a planning scale. These are terrain areas, not level rooms. The drawing is editable SVG: [local map](../MAPS/SLU.svg).

## 1. Place and historical purpose

This is the hydraulic control head of the sanctuary: gravity-fed catchment above the valves, pressure gallery below, water falling toward the garden and Echo Reservoir. Build huge arches, damp steps, a dry spillway and giant bronze wheel with a clearly walkable rim. P01 controls are geographically separated along the feeder circuit, yet all within a compact loop; walk between Root Arch, Bell Feeder and Split Stone. The final regulator displays the sequence; incorrect input clears only the command buffer, not the route or collectibles. Root Arch and Bell symbols correspond to landmarks; a relief says Root before Bell; a damaged plinth says center Split Stone last. Warden stands astride the outlet bridge, uses slams and exposed arm; bridge raises on correct flow, safe-mode unlocks exit on defeat. Spillway ladder shortcut opens after local latch; no early Warden bypass. Sluice Swifts shelter in eaves, glassfin fish and crabs appear when water resumes. No collision on decorative falling water. Pressure machinery uses visible gauge and audible warning.

## 2. Terrain geometry and tile placement

Feeder loop has 6–10 tile valve decks, safe platforms on both sides of water, and separate dry service stairs. Put Root/Bell labels beside pipe branches, not in the distant backdrop. Split regulator has 12-tile flat interaction deck. Warden arena target 36×18 tiles, with 8-tile entry and exit buffers. The bridge is an actual moving collision deck with safe sensor; it never moves while standing in unsafe space.

Set anchor foot surfaces at the coordinates in the table after multiplying by 16 tiles; refine surrounding contour locally. Keep ≥4-tile head clearance; target ≤2-tile rise and ≤4-tile mandatory gap. Do not interpolate steep atlas lines into unclimbable slopes: use the listed path profiles. The exact microgeometry is a blockout task, not an approved collision layout.

## 3. Landmarks and placement anchors

| Map mark | ID / landmark | Atlas (x,y) | Tile anchor | Role | State grants |
| --- | --- | --- | --- | --- | --- |
| 1 | SLU-ENTRY / Conduit Entry | (28,31) | (448,496) | Rest under pressure gauge, dry waterfall | — |
| 2 | SLU-ROOT / Root Arch Valve | (22,37) | (352,592) | P01 first conductor, root-side feeder | ROOT_VALVE |
| 3 | SLU-BELL / Bell Feeder Valve | (32,39) | (512,624) | P01 second conductor, relief and pipe label | BELL_VALVE |
| 4 | SLU-SPLIT / Split Stone Regulator | (24,46) | (384,736) | P01 center regulator and commit panel | SLUICE_OPEN |
| 5 | SLU-WARD / Bridge Warden | (14,47) | (224,752) | Sluice Warden habitat, restored bridge | WARDEN_DOWN |
| 6 | SLU-SPILL / High Spillway | (8,34) | (128,544) | M05 spillway ladder, hunter return landing | SPILL_OPEN |
| 7 | SLU-OUTLET / Garden Outlet | (34,50) | (544,800) | Water route to Rootspan | — |

## 4. Actual traversable connections

Every connection is two-way unless documented; conditions are persistent and must be checked in both directions. A crossing on the atlas is not a junction. For intersecting schematic routes, adjust local geometry/height or use an authored separated passage; do not accidentally connect them.

| Route | From → To | Mode | Condition / closure | Design |
| --- | --- | --- | --- | --- |
| PATH-026 | Upper Service Ridge ↔ Conduit Entry | viaduct | MAP_ALIGNED | Upper catchment viaduct; scenic connection above Rootspan, no downward access except authored stairs |
| PATH-027 | Conduit Entry ↔ Root Arch Valve | stairs | open | Dry feeder staircase |
| PATH-028 | Conduit Entry ↔ Bell Feeder Valve | stairs | open | Upper feeder route under bell label |
| PATH-029 | Root Arch Valve ↔ Split Stone Regulator | stairs | open | Root feeder descends to central command regulator |
| PATH-030 | Bell Feeder Valve ↔ Split Stone Regulator | stairs | open | Bell feeder descends to central command regulator |
| PATH-031 | Split Stone Regulator ↔ Bridge Warden | walk | SLUICE_OPEN | Raised bridge into Warden territory |
| PATH-032 | Bridge Warden ↔ Garden Outlet | viaduct | WARDEN_DOWN | Lower spill channel promenade beyond Warden; barrier locked until safe mode |
| PATH-033 | Garden Outlet ↔ Root Bridge | walk | WARDEN_DOWN | Water channel becomes root bridge |
| PATH-034 | Conduit Entry ↔ High Spillway | terraces | open | Upper spillway catwalk; optional local valve after P01 |
| PATH-035 | High Spillway ↔ Split Walk | lift | SLUICE_OPEN, SPILL_OPEN | S01 catchment ladder and service ledge; separate deck above ridge viaduct |
| PATH-040 | Underroot Culvert ↔ Split Stone Regulator | viaduct | GARDEN_RESTORED, WARDEN_DOWN | S02 service tunnel, safe bilateral return |

### Local traversal profiles

- **Viaduct:** Build a continuous bridge/maintenance gallery 6–10 tiles wide at minimum local landing, 4+ tile headroom, strong structural supports, occasional inspection recess and varied skyline. Long span needs side discoveries and periodic cover/rest niches.
- **Stairs:** Build walkable flights with 1–2 tile rises, 3–6 tile treads, and a ≥6 tile landing every 8–12 vertical tiles. Use lifts/ladders if the macro elevation exceeds practical stairs. Provide safe reversible down-route and mark drop-through surfaces.
- **Walk:** Start with 12–20 tiles of legible walking surface, then vary height with 1–2 tile steps. Introduce one sheltered side recess and preserve a 4-tile head clearance. Break long stretches with a landmark, change in surface or deliberate encounter.
- **Terraces:** Use staggered 6–12 tile platforms with ≤2 tile rises and ≤4 tile mandatory gaps; add a lower recovery deck, not a lethal void. Hide optional ledges in scenery only with a visible cue.
- **Lift:** Use a platform lift or counterweight with a 6–10 tile deck, call button at both ends, stable landings and anti-crush sensor. For long mixed routes, alternate horizontal galleries and lifts rather than a single enormous vertical shaft.

## 5. Puzzles, secrets, rewards and lore

### P01 — Split Stone Regulator

- Clues: Distributed feeder loop: root relief orders Root Arch before Bell; Split Stone plinth says center last. Three controls can be visited safely and the final regulator displays the command buffer.
- Solution: Operate Root Arch Valve, then Bell Feeder Valve, then Split Stone Regulator. Press commit. If order is wrong clear only the local command buffer; valves remain physically accessible.
- Result / failure: Raises bridge to Warden; local spillway can later be unlocked by M05; water reaches main channels.
- State: `SLUICE_OPEN`. Record clues automatically and supply a local reset; no optional item or player EE is required except Rewind exercise with recharge.

- **M05 at High Spillway:** Open spillway valve after P01. Reward: DAWN05, BP02. Wrong input resets locally; never gate critical route with this optional activity (M01 is safe onboarding practice).

| Anchor | Discoveries / reward IDs | Environmental hint |
| --- | --- | --- |
| Conduit Entry | AR04: Water circulation purpose | Rest under pressure gauge, dry waterfall |
| Root Arch Valve | — | P01 first conductor, root-side feeder |
| Bell Feeder Valve | — | P01 second conductor, relief and pipe label |
| Split Stone Regulator | AR05: Conductor order | Garden return hatch and spillway gate visible |
| Bridge Warden | — | Sluice Warden habitat, restored bridge |
| High Spillway | DAWN05: Bridge observations; BP02: equipment blueprint | Old waterline and valve with bridge symbol |
| Garden Outlet | — | Water route to Rootspan |

## 6. Encounters and hazards

**Split Stone Regulator:** water (HZ-SLU02). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**High Spillway:** water (HZ-SLU04). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**Sluice Warden (Required):** Maintenance construct; slam shockwave; double slam <50%; attack stuck arm/core. Counterplay: 1.0s wind-up; 1.4s recovery; phase chain 2 with clear pause. Safe mode opens bridge exit. Prototype HP 320; damage 18–24. Arena seal closes after safe entry, resets on death.

All other stretches are deliberately free of required combat. Do not populate every screen. Place hostiles only in traversable habitats, at least one camera look-ahead from protected interaction spaces, and never within rest station safety bubbles.

## 7. Scenery composition and ecosystem

**Conduit Entry** — Conduit entry with safe rest ledge; dry channel, source symbol and huge bell silhouetted beyond arch.. Ambient design carried forward: Dry channel before P01; after P01 distant swift silhouettes and flowing water. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Root Arch Valve** — P01 first conductor, root-side feeder. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Bell Feeder Valve** — P01 second conductor, relief and pipe label. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Split Stone Regulator** — Three conductor islands on dry service deck above flowing channel; plinth, relief and pulse aligned in view; bridge gate at exit.. Ambient design carried forward: P01 enables water and 2 glassfin silhouettes behind walkway; no aquatic life before flow. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Bridge Warden** — Sluice Warden protects the bridge actuator; broad bronze deck with empty overhead shockwave lanes.. Ambient design carried forward: No actors during boss; restored waterfall after victory. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**High Spillway** — Spillway ledge overlooks previously dry channel; valve controls drainage, return ladder folds down toward Hunter Trail.. Ambient design carried forward: 2 reed crabs beside waterline after P01; fish silhouettes after valve. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Garden Outlet** — Water route to Rootspan. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

Layer assignments: L00–L03 horizon/silhouette/midground; L04 noncombat wildlife; L05 near walls/props and lore; L06 collision; L07 actors; L08 telegraphs/ability effects; L09 foreground fade; L10 atmosphere. Use only the layers that fit the place. See [construction standards](../CONSTRUCTION_STANDARDS.md).

## 8. Save, transitions and acceptance

Rest stations: Conduit Entry. Workbenches: none. All save IDs use landmark IDs, not scene filenames. Save durable changes, flags, discovery, resource transactions; do not save ephemeral hazard phase.

For each path, walk it in both directions with the real controller, test first entry at zero EE and full heat, verify camera sightlines, check before/after state, prove the required gate cannot be bypassed, check return from optional branches, and test save/load after persistent changes. Only accept the region after blind playtest.
