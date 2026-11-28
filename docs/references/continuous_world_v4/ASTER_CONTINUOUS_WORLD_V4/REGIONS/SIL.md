# Silent Gallery — geographical construction sheet

**Status:** proposed V4. Bounds (5,87)–(36,103) atlas units; one unit = 16 tiles = 256 logical pixels as a planning scale. These are terrain areas, not level rooms. The drawing is editable SVG: [local map](../MAPS/SIL.svg).

## 1. Place and historical purpose

A memorial garden below the archives; enters from Veraya through a localized return fold across the map, not a literal underground corridor between planets. Pale stone, soft pink blossoms, dry paths and slow-moving light; no ordinary hostile combat on the critical route. The memory theatre uses a residual imprint of an ordinary Vaelari life, followed by Aster's childhood reflection. The player can leave after the short scene or replay the archive, no dialogue choice blocks progress. Optional Shrine is a short loop along engraved names and a recorded impression; match the name to M12. Still Garden returns to the hall via steps. Lantern moths gather at flowers, quiet small birds in open-air terraces, no wildlife in sealed memorial recess. Use open negative space, restrained music and no combat sound over the scene. This should be a pacing break, not a filler traversal section.

## 2. Terrain geometry and tile placement

Wide 16–24 tile colonnade walks, 2-tile stairs around terraces and still ponds behind parapets. Theatre 20 tiles clear, memory event triggered by inspect; control restored automatically. Optional shrine sits off main path with three readable names spaced 3 tiles apart. Avoid trap collision entirely on main promenade.

Set anchor foot surfaces at the coordinates in the table after multiplying by 16 tiles; refine surrounding contour locally. Keep ≥4-tile head clearance; target ≤2-tile rise and ≤4-tile mandatory gap. Do not interpolate steep atlas lines into unclimbable slopes: use the listed path profiles. The exact microgeometry is a blockout task, not an approved collision layout.

## 3. Landmarks and placement anchors

| Map mark | ID / landmark | Atlas (x,y) | Tile anchor | Role | State grants |
| --- | --- | --- | --- | --- | --- |
| 1 | SIL-HALL / Memorial Hall | (29,89) | (464,1424) | Quiet names and stone colonnade | — |
| 2 | SIL-THEATRE / Memory Theatre | (19,94) | (304,1504) | Required memory impression, not a living ghost | MEMORIAL_SEEN |
| 3 | SIL-WALK / Release Walk | (32,101) | (512,1616) | Open calm colonnade toward Reservoir | — |
| 4 | SIL-SHRINE / Keeper Shrine | (9,99) | (144,1584) | M12 Seren warning, memorial | — |
| 5 | SIL-GARDEN / Still Garden | (10,89) | (160,1424) | Optional viewing balcony and return loop | — |

## 4. Actual traversable connections

Every connection is two-way unless documented; conditions are persistent and must be checked in both directions. A crossing on the atlas is not a junction. For intersecting schematic routes, adjust local geometry/height or use an authored separated passage; do not accidentally connect them.

| Route | From → To | Mode | Condition / closure | Design |
| --- | --- | --- | --- | --- |
| PATH-067 | Foreign Sky Terrace ↔ Memorial Hall | fold | TOPOLOGY_ALIGNED | Warp throat C returns to Eldaran memorials; dashed atlas line is NOT a physical cross-planet corridor |
| PATH-068 | Memorial Hall ↔ Memory Theatre | stairs | open | Quiet memorial promenade |
| PATH-069 | Memorial Hall ↔ Still Garden | walk | open | Quiet viewing terrace |
| PATH-070 | Still Garden ↔ Keeper Shrine | stairs | open | Match memorial name M12 |
| PATH-071 | Keeper Shrine ↔ Memory Theatre | walk | open | Return via colonnade |
| PATH-072 | Memory Theatre ↔ Release Walk | walk | MEMORIAL_SEEN | Memory scene completed; ordinary release walk opens |
| PATH-073 | Release Walk ↔ Flow Deck | walk | MEMORIAL_SEEN | Quiet stone transitions into service basin |

### Local traversal profiles

- **Fold:** Build two distinct approach decks (≥8 tiles each) with matching anchor shape and readable threshold. Transition to the destination coordinate/planet after a brief fold cue; clear Rewind history at the seam. No physical geometry across the dashed atlas connection.
- **Stairs:** Build walkable flights with 1–2 tile rises, 3–6 tile treads, and a ≥6 tile landing every 8–12 vertical tiles. Use lifts/ladders if the macro elevation exceeds practical stairs. Provide safe reversible down-route and mark drop-through surfaces.
- **Walk:** Start with 12–20 tiles of legible walking surface, then vary height with 1–2 tile steps. Introduce one sheltered side recess and preserve a 4-tile head clearance. Break long stretches with a landmark, change in surface or deliberate encounter.

## 5. Puzzles, secrets, rewards and lore

- **M12 at Keeper Shrine:** Match memorial name to recorded imprint. Reward: MEM03, AR16. Wrong input resets locally; never gate critical route with this optional activity (M01 is safe onboarding practice).

| Anchor | Discoveries / reward IDs | Environmental hint |
| --- | --- | --- |
| Memorial Hall | AR14: Memorial inscriptions | Quiet names and stone colonnade |
| Memory Theatre | AR15: Residual memory | Side door marked by same memorial name |
| Release Walk | — | Open calm colonnade toward Reservoir |
| Keeper Shrine | AR16: Seren warning; MEM03: hidden memorial | Matching inscription repeated on base |
| Still Garden | — | Optional viewing balcony and return loop |

## 6. Encounters and hazards

**Release Walk:** E07 (E07-SIL03). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

All other stretches are deliberately free of required combat. Do not populate every screen. Place hostiles only in traversable habitats, at least one camera look-ahead from protected interaction spaces, and never within rest station safety bubbles.

## 7. Scenery composition and ecosystem

**Memorial Hall** — Long memorial hall, names etched on pale arch ribs; dry flowers and residual motes; intentionally enemy-free.. Ambient design carried forward: 1 dust moth on steady lamp; no enemy spawns. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Memory Theatre** — Memory theatre with recorded family silhouette; benches, extinguished lights and quiet camera framing.. Ambient design carried forward: No wildlife or combat; recorded nonliving memory silhouette. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Release Walk** — Release walk overlooking a vertical shaft of ascending Echoes; one Leech near damaged collector away from memorial.. Ambient design carried forward: Rising Echo motes, distinct from insects; 1 moth behind glass. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Keeper Shrine** — Keeper shrine, recorded imprint and name tablets; still guardian statue and small memorial garden.. Ambient design carried forward: 1 fern and moth by memorial lamp; no other movement. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Still Garden** — Optional viewing balcony and return loop. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

Layer assignments: L00–L03 horizon/silhouette/midground; L04 noncombat wildlife; L05 near walls/props and lore; L06 collision; L07 actors; L08 telegraphs/ability effects; L09 foreground fade; L10 atmosphere. Use only the layers that fit the place. See [construction standards](../CONSTRUCTION_STANDARDS.md).

## 8. Save, transitions and acceptance

Rest stations: none; use adjacent regions, with protected story saves where required. Workbenches: none. All save IDs use landmark IDs, not scene filenames. Save durable changes, flags, discovery, resource transactions; do not save ephemeral hazard phase.

For each path, walk it in both directions with the real controller, test first entry at zero EE and full heat, verify camera sightlines, check before/after state, prove the required gate cannot be bypassed, check return from optional branches, and test save/load after persistent changes. Only accept the region after blind playtest.
