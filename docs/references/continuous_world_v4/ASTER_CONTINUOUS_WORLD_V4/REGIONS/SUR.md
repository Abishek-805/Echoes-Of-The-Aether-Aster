# Survey Vault — geographical construction sheet

**Status:** proposed V4. Bounds (5,59)–(37,81) atlas units; one unit = 16 tiles = 256 logical pixels as a planning scale. These are terrain areas, not level rooms. The drawing is editable SVG: [local map](../MAPS/SUR.svg).

## 1. Place and historical purpose

A tall archive sunk into the rock below the sluice, reached from the foundry along a high viaduct with water flowing beneath. Build monumental vertical stacks, balconies and an astrolabe-like map frame as a navigation landmark. Main path winds down through Archive Steps, across the display bridge and into the map chamber, then exits along the lower terrace. A short optional upper shelf spur contains an archive lock and a late-game return shaft. P04 requires Receiver → Archive → Anchor, taught by glyphs in previous facilities. Each plate is mounted on the same archive apparatus rather than arbitrary remote buttons. Critical map granted after correct sequence and inspection; no optional archive count. A turret watches a side stair with visible beam line; central map area safe. Dust motes, Vault Geckos in damaged upper niches, no fish or birds in sealed stacks. Muted ivory, bronze, cyan accents; transition gradually toward irregular purple geometry at lower terrace.

## 2. Terrain geometry and tile placement

Archive balconies 8–16 tile spans with stone ribs at edges. Stacks rise in staggered tiers linked by stairs/lift. Map display platform 18 tiles wide with three plates spaced 4 tiles apart; critical map at central pedestal. Shelf niche behind clue-marked rotating panel. Lower exit slope transitions to fractured surface across ≥10 tiles.

Set anchor foot surfaces at the coordinates in the table after multiplying by 16 tiles; refine surrounding contour locally. Keep ≥4-tile head clearance; target ≤2-tile rise and ≤4-tile mandatory gap. Do not interpolate steep atlas lines into unclimbable slopes: use the listed path profiles. The exact microgeometry is a blockout task, not an approved collision layout.

## 3. Landmarks and placement anchors

| Map mark | ID / landmark | Atlas (x,y) | Tile anchor | Role | State grants |
| --- | --- | --- | --- | --- | --- |
| 1 | SUR-STEPS / Archive Steps | (34,62) | (544,992) | Rest, vista toward bell tower | — |
| 2 | SUR-DISPLAY / Survey Display | (22,65) | (352,1040) | P04 sequence | ARCHIVE_ALIGNED |
| 3 | SUR-MAP / Cartographic Vault | (14,72) | (224,1152) | Critical map, Rewind and emergency gate records | VAULT_MAP |
| 4 | SUR-SHELF / Sealed Shelf | (8,64) | (128,1024) | Optional archive cache, later Rewind return | SHELF_OPEN |
| 5 | SUR-LOW / Lower Archive Terrace | (31,79) | (496,1264) | Exit to Warped Verge | — |

## 4. Actual traversable connections

Every connection is two-way unless documented; conditions are persistent and must be checked in both directions. A crossing on the atlas is not a junction. For intersecting schematic routes, adjust local geometry/height or use an authored separated passage; do not accidentally connect them.

| Route | From → To | Mode | Condition / closure | Design |
| --- | --- | --- | --- | --- |
| PATH-051 | Archive Service Road ↔ Archive Steps | viaduct | open | Stone archive viaduct across central span, separate above Warped Verge |
| PATH-052 | Archive Steps ↔ Survey Display | stairs | open | Archive balcony and display frame |
| PATH-053 | Survey Display ↔ Cartographic Vault | stairs | ARCHIVE_ALIGNED | Validated archive lock opens downward |
| PATH-054 | Survey Display ↔ Sealed Shelf | terraces | open | Optional glyph-locked shelf cache M09 |
| PATH-055 | Cartographic Vault ↔ Lower Archive Terrace | stairs | VAULT_MAP | Lower archive exit, route to unstable connection |
| PATH-056 | Lower Archive Terrace ↔ Fracture Landing | walk | VAULT_MAP | Repeating glyphs begin to misalign |
| PATH-086 | History Landing ↔ Sealed Shelf | lift | REWIND_TRAINED, SHELF_OPEN, ARCHIVE_RETURN | S06 deep maintenance lift, separate shaft; shelf-side latch reachable after main route |

### Local traversal profiles

- **Viaduct:** Build a continuous bridge/maintenance gallery 6–10 tiles wide at minimum local landing, 4+ tile headroom, strong structural supports, occasional inspection recess and varied skyline. Long span needs side discoveries and periodic cover/rest niches.
- **Stairs:** Build walkable flights with 1–2 tile rises, 3–6 tile treads, and a ≥6 tile landing every 8–12 vertical tiles. Use lifts/ladders if the macro elevation exceeds practical stairs. Provide safe reversible down-route and mark drop-through surfaces.
- **Terraces:** Use staggered 6–12 tile platforms with ≤2 tile rises and ≤4 tile mandatory gaps; add a lower recovery deck, not a lethal void. Hide optional ledges in scenery only with a visible cue.
- **Walk:** Start with 12–20 tiles of legible walking surface, then vary height with 1–2 tile steps. Introduce one sheltered side recess and preserve a 4-tile head clearance. Break long stretches with a landmark, change in surface or deliberate encounter.
- **Lift:** Use a platform lift or counterweight with a 6–10 tile deck, call button at both ends, stable landings and anti-crush sensor. For long mixed routes, alternate horizontal galleries and lifts rather than a single enormous vertical shaft.

## 5. Puzzles, secrets, rewards and lore

### P04 — Survey Display

- Clues: Identify survey archive. Three plates show receiver, archive, anchor symbols; service note requires power before record before route.
- Solution: Receiver → Archive → Anchor.
- Result / failure: Access SUR03; incorrect order resets plates; critical map automatically recorded on entry.
- State: `ARCHIVE_ALIGNED`. Record clues automatically and supply a local reset; no optional item or player EE is required except Rewind exercise with recharge.

- **M09 at Sealed Shelf:** Read archive symbols to unlock shelf cache. Reward: lore and late return path. Wrong input resets locally; never gate critical route with this optional activity (M01 is safe onboarding practice).

| Anchor | Discoveries / reward IDs | Environmental hint |
| --- | --- | --- |
| Archive Steps | — | Rest, vista toward bell tower |
| Survey Display | AR09: Custody archive; DAWN07: Distortion report | Shelf seam and repeated archive glyph |
| Cartographic Vault | AR10: Personal Continuity Device; DAWN08: Dawn failure conclusion | Critical map, Rewind and emergency gate records |
| Sealed Shelf | — | Repeated archive glyphs and dust-free seam |
| Lower Archive Terrace | — | Exit to Warped Verge |

## 6. Encounters and hazards

**Archive Steps:** E02 (E02-SUR01), E04 (E04-SUR01), beam (HZ-SUR01). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**Survey Display:** E04 (E04-SUR02), beam (HZ-SUR02). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

All other stretches are deliberately free of required combat. Do not populate every screen. Place hostiles only in traversable habitats, at least one camera look-ahead from protected interaction spaces, and never within rest station safety bubbles.

## 7. Scenery composition and ecosystem

**Archive Steps** — Archive stairs and huge carved map panels; safe rest alcove separated from guard and turret lane.. Ambient design carried forward: 1 gecko in wall alcove; no fauna near turret. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Survey Display** — Three display plates receiver/archive/anchor; one turret in entry gallery, safe puzzle alcove beyond cover.. Ambient design carried forward: Dust motes; display lights animate after alignment. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Cartographic Vault** — Cartographic vault with luminous layered map of the sanctuary and broken route to gate; acquisition scene.. Ambient design carried forward: No wildlife; animated map only. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Sealed Shelf** — Sealed shelf corridor, displaced shelves and late Rewind return shaft; cache opens on symbol match.. Ambient design carried forward: 1 moth by shelf lamp; curtain of dust when panel opens. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Lower Archive Terrace** — Exit to Warped Verge. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

Layer assignments: L00–L03 horizon/silhouette/midground; L04 noncombat wildlife; L05 near walls/props and lore; L06 collision; L07 actors; L08 telegraphs/ability effects; L09 foreground fade; L10 atmosphere. Use only the layers that fit the place. See [construction standards](../CONSTRUCTION_STANDARDS.md).

## 8. Save, transitions and acceptance

Rest stations: Archive Steps. Workbenches: none. All save IDs use landmark IDs, not scene filenames. Save durable changes, flags, discovery, resource transactions; do not save ephemeral hazard phase.

For each path, walk it in both directions with the real controller, test first entry at zero EE and full heat, verify camera sightlines, check before/after state, prove the required gate cannot be bypassed, check return from optional branches, and test save/load after persistent changes. Only accept the region after blind playtest.
