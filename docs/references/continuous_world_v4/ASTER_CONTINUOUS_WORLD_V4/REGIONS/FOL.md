# Folded Depths — geographical construction sheet

**Status:** proposed V4. Bounds (5,114)–(42,139) atlas units; one unit = 16 tiles = 256 logical pixels as a planning scale. These are terrain areas, not level rooms. The drawing is editable SVG: [local map](../MAPS/FOL.svg).

## 1. Place and historical purpose

The deepest unstable service tunnels loop under the upper sanctuary. Terrain is layered pale rock and violet fractures, with actual solid routes visually distinct from background fragments. History Landing shows a fragment of Continuum doctrine; another record at Fold Junction names Nalora without revealing the whole catastrophe. The old archive return shaft opens after Rewind training and local latch; return cannot bypass earlier mandatory flags. One-Way Gallery contains an optional shutter pocket for M16 and a safe main bypass. P10 uses three pairs A diamond, B split diamond, C ring: visual halves and rhythmic pulses, errors show mismatch and reset only that pair. NEST is a side spur off Junction, accessible after M14 Rewind exercise; a creature destroys an Echo in the background, reinforcing ethics. Optional Rift Devourer arena is a natural hollow with retreat before engagement and retry after death. No full Warp control, no player teleport. Rift Moths flee unstable cracks, no normal birds or fish here. Sparse effects ensure spatial markers remain legible.

## 2. Terrain geometry and tile placement

Use 6–12 tile terraces under asymmetric fractures and a lower recovery path. M16 pocket: service x=5, pad x=9, shutter x=13, latch x=24, separate from main lane. M14 pocket: pad x=9, shutter x=13, latch x=16; unlock nest entry after return. Nest arena target 40×20 tiles; leave clear space for attack markers. Anchor junction platforms 8 tiles each.

Set anchor foot surfaces at the coordinates in the table after multiplying by 16 tiles; refine surrounding contour locally. Keep ≥4-tile head clearance; target ≤2-tile rise and ≤4-tile mandatory gap. Do not interpolate steep atlas lines into unclimbable slopes: use the listed path profiles. The exact microgeometry is a blockout task, not an approved collision layout.

## 3. Landmarks and placement anchors

| Map mark | ID / landmark | Atlas (x,y) | Tile anchor | Role | State grants |
| --- | --- | --- | --- | --- | --- |
| 1 | FOL-LAND / History Landing | (38,116) | (608,1856) | Rest, ancient warning and archive return | ARCHIVE_RETURN |
| 2 | FOL-ONE / One-Way Gallery | (25,123) | (400,1968) | M16 optional recorded path and return to Veraya | REWIND_RETURN |
| 3 | FOL-JUNC / Fold Junction | (15,129) | (240,2064) | P10 geometric anchor pairing | FOLDS_ALIGNED |
| 4 | FOL-NEST / Devourer Nest | (8,136) | (128,2176) | Optional Rift Devourer, M14 | DEVOURER_DOWN, NEST_LATCH |
| 5 | FOL-RIDGE / Deep Service Ridge | (37,135) | (592,2160) | Aligned route into Final Approach | — |

## 4. Actual traversable connections

Every connection is two-way unless documented; conditions are persistent and must be checked in both directions. A crossing on the atlas is not a junction. For intersecting schematic routes, adjust local geometry/height or use an authored separated passage; do not accidentally connect them.

| Route | From → To | Mode | Condition / closure | Design |
| --- | --- | --- | --- | --- |
| PATH-085 | Lower Service Landing ↔ History Landing | viaduct | REWIND_TRAINED | Lower service traverse along reservoir foundation; scenic tunnel, no arbitrary portal |
| PATH-086 | History Landing ↔ Sealed Shelf | lift | REWIND_TRAINED, SHELF_OPEN, ARCHIVE_RETURN | S06 deep maintenance lift, separate shaft; shelf-side latch reachable after main route |
| PATH-087 | History Landing ↔ One-Way Gallery | stairs | open | Safe path past optional shutter pocket |
| PATH-088 | One-Way Gallery ↔ Service Alcove | fold | REWIND_TRAINED, REWIND_RETURN | S07 dormant paired maintenance fold unlocked by M16, not arbitrary teleport |
| PATH-089 | One-Way Gallery ↔ Fold Junction | terraces | open | Three visible paired anchors along sloping corridor |
| PATH-090 | Fold Junction ↔ Devourer Nest | stairs | REWIND_TRAINED | M14 safe Rewind latch before optional Devourer arena |
| PATH-091 | Fold Junction ↔ Deep Service Ridge | terraces | FOLDS_ALIGNED | Aligned service corridor |
| PATH-092 | Deep Service Ridge ↔ Stabilizer Walk | walk | FOLDS_ALIGNED | Fractured architecture resolves into monumental viaduct |

### Local traversal profiles

- **Viaduct:** Build a continuous bridge/maintenance gallery 6–10 tiles wide at minimum local landing, 4+ tile headroom, strong structural supports, occasional inspection recess and varied skyline. Long span needs side discoveries and periodic cover/rest niches.
- **Lift:** Use a platform lift or counterweight with a 6–10 tile deck, call button at both ends, stable landings and anti-crush sensor. For long mixed routes, alternate horizontal galleries and lifts rather than a single enormous vertical shaft.
- **Stairs:** Build walkable flights with 1–2 tile rises, 3–6 tile treads, and a ≥6 tile landing every 8–12 vertical tiles. Use lifts/ladders if the macro elevation exceeds practical stairs. Provide safe reversible down-route and mark drop-through surfaces.
- **Fold:** Build two distinct approach decks (≥8 tiles each) with matching anchor shape and readable threshold. Transition to the destination coordinate/planet after a brief fold cue; clear Rewind history at the seam. No physical geometry across the dashed atlas connection.
- **Terraces:** Use staggered 6–12 tile platforms with ≤2 tile rises and ≤4 tile mandatory gaps; add a lower recovery deck, not a lethal void. Hide optional ledges in scenery only with a visible cue.
- **Walk:** Start with 12–20 tiles of legible walking surface, then vary height with 1–2 tile steps. Introduce one sheltered side recess and preserve a 4-tile head clearance. Break long stretches with a landmark, change in surface or deliberate encounter.

## 5. Puzzles, secrets, rewards and lore

### P10 — Fold Junction

- Clues: Reconstruct local connections. Three anchor panels show matching geometric halves and stable pulses.
- Solution: Connect diamond A to A, split diamond B to B, ring C to C; follow resulting maintenance corridor.
- Result / failure: FIN01 accessible; wrong pair gives local mismatch. No extra powers.
- State: `FOLDS_ALIGNED`. Record clues automatically and supply a local reset; no optional item or player EE is required except Rewind exercise with recharge.

- **M14 at Devourer Nest:** Rewind from safe ledge to latch; optional boss. Reward: HP04, MAP06, MEM05. Wrong input resets locally; never gate critical route with this optional activity (M01 is safe onboarding practice).
- **M16 at One-Way Gallery:** Rewind through authored shutter to optional return switch. Reward: shortcut to VER04. Wrong input resets locally; never gate critical route with this optional activity (M01 is safe onboarding practice).

| Anchor | Discoveries / reward IDs | Environmental hint |
| --- | --- | --- |
| History Landing | AR20: Continuum fragment | Visible old shelf identifier on reverse side |
| One-Way Gallery | — | Paired Verayan service glyph next to optional latch |
| Fold Junction | AR21: Nalora and convergence fragment | P10 geometric anchor pairing |
| Devourer Nest | MAP06: optional map annotation; HP04: +10 max HP; MEM05: hidden memorial | Organic feeding traces lead to hidden memorial behind arena |
| Deep Service Ridge | — | Aligned route into Final Approach |

## 6. Encounters and hazards

**History Landing:** E03 (E03-FOL01), rift (HZ-FOL01). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**One-Way Gallery:** E08 (E08-FOL02). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**Fold Junction:** E08 (E08-FOL03), rift (HZ-FOL03). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**Devourer Nest:** V04 (V04-FOL04). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**Rift Devourer (Optional):** Displaced Voruun predator; marked rift strike, delayed pool, charge. Counterplay: 1.0s tells; 1.5s recovery; use Rewind safely; HP04, MAP06, MEM05. Prototype HP 760; damage 20–30. Arena seal closes after safe entry, resets on death.

All other stretches are deliberately free of required combat. Do not populate every screen. Place hostiles only in traversable habitats, at least one camera look-ahead from protected interaction spaces, and never within rest station safety bubbles.

## 7. Scenery composition and ecosystem

**History Landing** — History landing with rest station and Continuum fragment; Skitter marked crack beyond refuge screen; return stair to archive.. Ambient design carried forward: 1 cave arthropod in distant seam; rift moth flees Skitter. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**One-Way Gallery** — One-way gallery with taught shutter sequence, delayed marker Stalker in separate combat bay, optional latch to Veraya.. Ambient design carried forward: No fauna along shutter; faint violet dust in combat bay. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Fold Junction** — Fold junction with three paired anchor panels and Nalora record; Stalker outside protected puzzle deck.. Ambient design carried forward: 1 rift moth at stable anchor, disappears during attack telegraphs. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Devourer Nest** — Predator nest: safe rewind latch at entrance, sealed arena for Rift Devourer, leftover consumed-Echo husks beyond.. Ambient design carried forward: Empty feeding husks; no benign fauna near Voruun; quiet after defeat. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Deep Service Ridge** — Aligned route into Final Approach. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

Layer assignments: L00–L03 horizon/silhouette/midground; L04 noncombat wildlife; L05 near walls/props and lore; L06 collision; L07 actors; L08 telegraphs/ability effects; L09 foreground fade; L10 atmosphere. Use only the layers that fit the place. See [construction standards](../CONSTRUCTION_STANDARDS.md).

## 8. Save, transitions and acceptance

Rest stations: History Landing. Workbenches: none. All save IDs use landmark IDs, not scene filenames. Save durable changes, flags, discovery, resource transactions; do not save ephemeral hazard phase.

For each path, walk it in both directions with the real controller, test first entry at zero EE and full heat, verify camera sightlines, check before/after state, prove the required gate cannot be bypassed, check return from optional branches, and test save/load after persistent changes. Only accept the region after blind playtest.
