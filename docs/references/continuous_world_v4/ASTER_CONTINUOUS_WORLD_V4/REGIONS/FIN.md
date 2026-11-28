# Final Approach — geographical construction sheet

**Status:** proposed V4. Bounds (46,116)–(86,140) atlas units; one unit = 16 tiles = 256 logical pixels as a planning scale. These are terrain areas, not level rooms. The drawing is editable SVG: [local map](../MAPS/FIN.svg).

## 1. Place and historical purpose

Monumental converging architecture. Three stabilizers are integrated into a single multi-level service viaduct: one on western flank, one up a lift, one on lower deck. The player can visit them in any order via an actual loop and returns to Anchor Control. Restore all three, open safe release line, then energize receiver. Each device has a visual link toward the gate and numbered/shape status on the journal; do not require remembering arbitrary order. Main platforms have solid rails, safe lift landings and marked spatial hazards. Optional Service Niche branches from upper terrace near Last Rest; align a conduit for the Resonator, never required for boss. Last Rest is quiet and near final approach, with safe short retry to Guardian. A huge gate silhouette fills background as alignment completes. Sparse Prism Beetles in outer cracks only, no ordinary flora in active containment. Art switches from fractured chaos to monumental symmetry; violet marks remain in cracks, proving the local repair is partial.

## 2. Terrain geometry and tile placement

Stabilizer decks ≥10 tiles long, 2-tile stairs or 8-tile lifts, each with clear shape label and visible cable. Lower return deck no drop-only trap. Control deck 16 tiles, three status lamps and release valve. Last Rest has 12-tile safe radius. Final approach to arena target ≤45 seconds at baseline controller; shorten if retry is longer.

Set anchor foot surfaces at the coordinates in the table after multiplying by 16 tiles; refine surrounding contour locally. Keep ≥4-tile head clearance; target ≤2-tile rise and ≤4-tile mandatory gap. Do not interpolate steep atlas lines into unclimbable slopes: use the listed path profiles. The exact microgeometry is a blockout task, not an approved collision layout.

## 3. Landmarks and placement anchors

| Map mark | ID / landmark | Atlas (x,y) | Tile anchor | Role | State grants |
| --- | --- | --- | --- | --- | --- |
| 1 | FIN-WALK / Stabilizer Walk | (48,135) | (768,2160) | Rest, first anchor, warning directive | — |
| 2 | FIN-A / Western Stabilizer | (54,126) | (864,2016) | P11 component A | STAB_A |
| 3 | FIN-B / Upper Stabilizer | (65,118) | (1040,1888) | P11 component B | STAB_B |
| 4 | FIN-C / Lower Stabilizer | (68,136) | (1088,2176) | P11 component C | STAB_C |
| 5 | FIN-CTRL / Anchor Control | (76,128) | (1216,2048) | P11 commit and release line | ANCHORS_STABLE |
| 6 | FIN-REST / Last Rest | (84,131) | (1344,2096) | Final rest/workbench, isolation warning | — |
| 7 | FIN-NICHE / Service Niche | (82,119) | (1312,1904) | M15 optional Resonator | — |

## 4. Actual traversable connections

Every connection is two-way unless documented; conditions are persistent and must be checked in both directions. A crossing on the atlas is not a junction. For intersecting schematic routes, adjust local geometry/height or use an authored separated passage; do not accidentally connect them.

| Route | From → To | Mode | Condition / closure | Design |
| --- | --- | --- | --- | --- |
| PATH-092 | Deep Service Ridge ↔ Stabilizer Walk | walk | FOLDS_ALIGNED | Fractured architecture resolves into monumental viaduct |
| PATH-093 | Stabilizer Walk ↔ Western Stabilizer | stairs | open | Western stabilizer |
| PATH-094 | Western Stabilizer ↔ Upper Stabilizer | lift | open | Upper lift terrace |
| PATH-095 | Upper Stabilizer ↔ Lower Stabilizer | lift | open | Inspection lift from upper to lower deck |
| PATH-096 | Lower Stabilizer ↔ Stabilizer Walk | walk | open | Lower deck loop; stabilizers can be activated in any order |
| PATH-097 | Upper Stabilizer ↔ Anchor Control | stairs | open | Upper approach to common control |
| PATH-098 | Lower Stabilizer ↔ Anchor Control | stairs | open | Lower approach to common control |
| PATH-099 | Anchor Control ↔ Last Rest | walk | ANCHORS_STABLE | Aligned approach to final rest |
| PATH-100 | Upper Stabilizer ↔ Service Niche | walk | open | Service receiver M15 |
| PATH-101 | Service Niche ↔ Last Rest | stairs | ANCHORS_STABLE | Optional loop cannot bypass P11 |
| PATH-102 | Last Rest ↔ Containment Court | walk | ANCHORS_STABLE | Short safe boss retry approach |

### Local traversal profiles

- **Walk:** Start with 12–20 tiles of legible walking surface, then vary height with 1–2 tile steps. Introduce one sheltered side recess and preserve a 4-tile head clearance. Break long stretches with a landmark, change in surface or deliberate encounter.
- **Stairs:** Build walkable flights with 1–2 tile rises, 3–6 tile treads, and a ≥6 tile landing every 8–12 vertical tiles. Use lifts/ladders if the macro elevation exceeds practical stairs. Provide safe reversible down-route and mark drop-through surfaces.
- **Lift:** Use a platform lift or counterweight with a 6–10 tile deck, call button at both ends, stable landings and anti-crush sensor. For long mixed routes, alternate horizontal galleries and lifts rather than a single enormous vertical shaft.

## 5. Puzzles, secrets, rewards and lore

### P11 — Anchor Control

- Clues: Three physical stabilizers on the western, upper and lower decks. Each reports readiness to Anchor Control. Warning: keep release path open.
- Solution: Activate A/B/C in any order, open release line, energize receiver at Anchor Control.
- Result / failure: Final approach becomes stable. The physically broken transit interface remains broken.
- State: `ANCHORS_STABLE`. Record clues automatically and supply a local reset; no optional item or player EE is required except Rewind exercise with recharge.

- **M15 at Service Niche:** Align service conduit to receiver. Reward: BP06, WPN03. Wrong input resets locally; never gate critical route with this optional activity (M01 is safe onboarding practice).

| Anchor | Discoveries / reward IDs | Environmental hint |
| --- | --- | --- |
| Stabilizer Walk | AR22: Anchor network | Rest, first anchor, warning directive |
| Western Stabilizer | — | P11 component A |
| Upper Stabilizer | — | P11 component B |
| Lower Stabilizer | — | P11 component C |
| Anchor Control | — | Niche hatch identified by service receiver |
| Last Rest | AR23: Isolation directive | Final rest/workbench, isolation warning |
| Service Niche | BP06: equipment blueprint; WPN03: Vaelari Resonator | Receiver cable runs behind broken panel |

## 6. Encounters and hazards

**Stabilizer Walk:** E06 (E06-FIN01), steam (HZ-FIN01). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**Anchor Control:** E08 (E08-FIN02), rift (HZ-FIN02). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**Service Niche:** V03 (V03-FIN04), beam (HZ-FIN04). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

All other stretches are deliberately free of required combat. Do not populate every screen. Place hostiles only in traversable habitats, at least one camera look-ahead from protected interaction spaces, and never within rest station safety bubbles.

## 7. Scenery composition and ecosystem

**Stabilizer Walk** — Stabilizer walk with three labeled pylons, large gate silhouette and rest shield; Mithril guard between pylons.. Ambient design carried forward: No live fauna; moving conduit lights and steam. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Western Stabilizer** — P11 component A. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Upper Stabilizer** — P11 component B. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Lower Stabilizer** — P11 component C. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Anchor Control** — Anchor control under colossal conduits; Stalker on approach, release-first terminal in protected zone.. Ambient design carried forward: No live fauna; conduit pulses show receiver sequence. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Last Rest** — Final rest and workbench with isolation directive; massive distant guardian silhouette beyond gate; quiet anticipation.. Ambient design carried forward: No live fauna; distant guardian silhouette. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Service Niche** — Service niche with dual Prism Array behind cover, spare parts cabinet and Resonator case.. Ambient design carried forward: No live fauna; service fans and dust. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

Layer assignments: L00–L03 horizon/silhouette/midground; L04 noncombat wildlife; L05 near walls/props and lore; L06 collision; L07 actors; L08 telegraphs/ability effects; L09 foreground fade; L10 atmosphere. Use only the layers that fit the place. See [construction standards](../CONSTRUCTION_STANDARDS.md).

## 8. Save, transitions and acceptance

Rest stations: Stabilizer Walk, Last Rest. Workbenches: Last Rest. All save IDs use landmark IDs, not scene filenames. Save durable changes, flags, discovery, resource transactions; do not save ephemeral hazard phase.

For each path, walk it in both directions with the real controller, test first entry at zero EE and full heat, verify camera sightlines, check before/after state, prove the required gate cannot be bypassed, check return from optional branches, and test save/load after persistent changes. Only accept the region after blind playtest.
