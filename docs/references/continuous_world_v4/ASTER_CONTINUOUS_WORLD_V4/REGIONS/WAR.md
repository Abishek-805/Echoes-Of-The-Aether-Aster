# Warped Verge — geographical construction sheet

**Status:** proposed V4. Bounds (42,64)–(79,84) atlas units; one unit = 16 tiles = 256 logical pixels as a planning scale. These are terrain areas, not level rooms. The drawing is editable SVG: [local map](../MAPS/WAR.svg).

## 1. Place and historical purpose

A fractured connection zone, not an alternate planet by itself. Establish the same pale-alloy architecture from Survey Vault, then offset its repeating patterns along visible rifts. Three anchor mouths share a compact promenade: diamond pair pulses continuously; split and ring mismatches lead to short nonlethal loops returning to the same hub. P05 chooses the matching diamond. The main fold to Veraya is physically represented by an arch boundary and a distinct map glyph; the planets remain separate. M10 traces the optional anchor loop, but cannot open the Veraya shortcut without P05. Rift Skitters and occasional Fold Stalker are telegraphed; floor cracks warn before striking, no invisible walls. Rift moths cluster only near stable edges; displaced species do not instantly become a new food chain. Use suspended-looking fragments attached by traversable decks, not mandatory midair teleport. A distant view of the Reservoir explains a later service return.

## 2. Terrain geometry and tile placement

Junction platform 24–32 tiles with three arch mouths separated by ≥8 tiles. Safe mismatch loops take 10–20 seconds and return to same landing; no fall penalty. Rift cracks span 3 tiles, warning from above the floor. Deck fragments have visible supports; no uncontrolled gravity inversion. Stable fold threshold ≥8 tiles wide.

Set anchor foot surfaces at the coordinates in the table after multiplying by 16 tiles; refine surrounding contour locally. Keep ≥4-tile head clearance; target ≤2-tile rise and ≤4-tile mandatory gap. Do not interpolate steep atlas lines into unclimbable slopes: use the listed path profiles. The exact microgeometry is a blockout task, not an approved collision layout.

## 3. Landmarks and placement anchors

| Map mark | ID / landmark | Atlas (x,y) | Tile anchor | Role | State grants |
| --- | --- | --- | --- | --- | --- |
| 1 | WAR-LAND / Fracture Landing | (43,79) | (688,1264) | Rest on stable Eldaran slab | — |
| 2 | WAR-JUNC / Three-Anchor Junction | (56,73) | (896,1168) | P05 identify stable matching pair | TOPOLOGY_ALIGNED |
| 3 | WAR-FOLD / Stable Fold | (75,73) | (1200,1168) | Only mandatory interplanetary threshold | — |
| 4 | WAR-LOOP / Unmapped Loop | (62,65) | (992,1040) | M10 optional anchor branch, return spur | LOOP_MARKED |
| 5 | WAR-EDGE / Broken Promenade | (48,83) | (768,1328) | Optional reservoir return landing | — |

## 4. Actual traversable connections

Every connection is two-way unless documented; conditions are persistent and must be checked in both directions. A crossing on the atlas is not a junction. For intersecting schematic routes, adjust local geometry/height or use an authored separated passage; do not accidentally connect them.

| Route | From → To | Mode | Condition / closure | Design |
| --- | --- | --- | --- | --- |
| PATH-056 | Lower Archive Terrace ↔ Fracture Landing | walk | VAULT_MAP | Repeating glyphs begin to misalign |
| PATH-057 | Fracture Landing ↔ Three-Anchor Junction | terraces | open | Marked stable slabs connected by decks |
| PATH-058 | Three-Anchor Junction ↔ Stable Fold | walk | TOPOLOGY_ALIGNED | Matched diamond anchor opens stable connection |
| PATH-059 | Three-Anchor Junction ↔ Unmapped Loop | stairs | open | Optional anchor trace M10 |
| PATH-060 | Fracture Landing ↔ Broken Promenade | walk | open | See later Reservoir return from upper promenade |
| PATH-061 | Stable Fold ↔ Foreign Atrium | fold | TOPOLOGY_ALIGNED | Warp throat A: Eldara to Veraya; reciprocal |
| PATH-062 | Unmapped Loop ↔ Research Gallery | fold | LOOP_MARKED, TOPOLOGY_ALIGNED | S04 Warp throat B after both anchor checks |
| PATH-078 | Overflow Alcove ↔ Broken Promenade | lift | RESERVOIR_STABLE, OVERFLOW_ISOLATED | S05 long maintenance return shaft along basin rim |

### Local traversal profiles

- **Walk:** Start with 12–20 tiles of legible walking surface, then vary height with 1–2 tile steps. Introduce one sheltered side recess and preserve a 4-tile head clearance. Break long stretches with a landmark, change in surface or deliberate encounter.
- **Terraces:** Use staggered 6–12 tile platforms with ≤2 tile rises and ≤4 tile mandatory gaps; add a lower recovery deck, not a lethal void. Hide optional ledges in scenery only with a visible cue.
- **Stairs:** Build walkable flights with 1–2 tile rises, 3–6 tile treads, and a ≥6 tile landing every 8–12 vertical tiles. Use lifts/ladders if the macro elevation exceeds practical stairs. Provide safe reversible down-route and mark drop-through surfaces.
- **Fold:** Build two distinct approach decks (≥8 tiles each) with matching anchor shape and readable threshold. Transition to the destination coordinate/planet after a brief fold cue; clear Rewind history at the seam. No physical geometry across the dashed atlas connection.
- **Lift:** Use a platform lift or counterweight with a 6–10 tile deck, call button at both ends, stable landings and anti-crush sensor. For long mixed routes, alternate horizontal galleries and lifts rather than a single enormous vertical shaft.

## 5. Puzzles, secrets, rewards and lore

### P05 — Three-Anchor Junction

- Clues: Historical map shows three doors; two unstable anchors pulse irregularly. Current landmarks and anchor shape match stable route.
- Solution: Select continuously pulsing matched diamond; wrong anchor mouths loop to the same junction. No shortcuts to Veraya before TOPOLOGY_ALIGNED.
- Result / failure: WAR03 opens; wrong doors loop safely to WAR02 with mismatched landmark feedback.
- State: `TOPOLOGY_ALIGNED`. Record clues automatically and supply a local reset; no optional item or player EE is required except Rewind exercise with recharge.

- **M10 at Unmapped Loop:** Trace matching anchor pairs. Reward: LOOP_MARKED, MAP05, MEM04. Wrong input resets locally; never gate critical route with this optional activity (M01 is safe onboarding practice).

| Anchor | Discoveries / reward IDs | Environmental hint |
| --- | --- | --- |
| Fracture Landing | — | Rest on stable Eldaran slab |
| Three-Anchor Junction | AR11: Anchor warning | Unmapped maintenance door with matching halves |
| Stable Fold | — | Only mandatory interplanetary threshold |
| Unmapped Loop | MAP05: optional map annotation; MEM04: hidden memorial | Repeated geometric halves and reversed floor seam |
| Broken Promenade | — | Optional reservoir return landing |

## 6. Encounters and hazards

**Fracture Landing:** E03 (E03-WAR01), V02 (V02-WAR01), rift (HZ-WAR01). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**Stable Fold:** E03 (E03-WAR03), rift (HZ-WAR03). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

All other stretches are deliberately free of required combat. Do not populate every screen. Place hostiles only in traversable habitats, at least one camera look-ahead from protected interaction spaces, and never within rest station safety bubbles.

## 7. Scenery composition and ecosystem

**Fracture Landing** — Fracture landing: Eldaran rock abruptly meets blue Verayan alloy; rest alcove then Skitter and Saturated Forager.. Ambient design carried forward: 2 rift moths flee crack; disconnected bird silhouette only visible outside fold. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Three-Anchor Junction** — Three anchor doors under broken bridge; stable paired diamond and two flickering false doors; safe trial loops.. Ambient design carried forward: No animals near unstable doors; intermittent violet dust. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Stable Fold** — Stable fold spans separated structures; marked crack Skitter, view across unfamiliar sky before Veraya arrival.. Ambient design carried forward: One displaced Copperwing in distant exterior, away from combat; rift moths retreat. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Unmapped Loop** — Small loop of impossible corridors; pairs of anchor halves and memorial niche; exit gate requires stable topology too.. Ambient design carried forward: 2 cave arthropods retreat into seams; no animals teleport. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Broken Promenade** — Optional reservoir return landing. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

Layer assignments: L00–L03 horizon/silhouette/midground; L04 noncombat wildlife; L05 near walls/props and lore; L06 collision; L07 actors; L08 telegraphs/ability effects; L09 foreground fade; L10 atmosphere. Use only the layers that fit the place. See [construction standards](../CONSTRUCTION_STANDARDS.md).

## 8. Save, transitions and acceptance

Rest stations: Fracture Landing. Workbenches: none. All save IDs use landmark IDs, not scene filenames. Save durable changes, flags, discovery, resource transactions; do not save ephemeral hazard phase.

For each path, walk it in both directions with the real controller, test first entry at zero EE and full heat, verify camera sightlines, check before/after state, prove the required gate cannot be bypassed, check return from optional branches, and test save/load after persistent changes. Only accept the region after blind playtest.
