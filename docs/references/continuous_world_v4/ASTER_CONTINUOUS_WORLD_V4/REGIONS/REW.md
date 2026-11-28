# Rewind Sanctuary — geographical construction sheet

**Status:** proposed V4. Bounds (86,94)–(119,112) atlas units; one unit = 16 tiles = 256 logical pixels as a planning scale. These are terrain areas, not level rooms. The drawing is editable SVG: [local map](../MAPS/REW.svg).

## 1. Place and historical purpose

A protected relic complex at the end of the reservoir supply bridge. Symmetrical pale-alloy architecture, clean curved surfaces and restrained gold/cyan highlights distinguish it from hunter technology. Vestibule branches to two visible maintenance isolators left/right of Keeper Court; no extra ability to reach them. Once both are off, Keeper shield cycles expose core. Defeating Keeper opens the relic shrine. P08 verifies Sluice Flow, Survey Archive, Reservoir Release; missing indicator explains missing upstream flag. The relic was a rescue/research continuity tool, not a time machine. Aster installs it on his right forearm; immediately save. Return-Path Terrace is a local safe corridor with pad, authored shutter and latch separated by 16 tiles, exactly one continuous loaded domain; use Rewind within six seconds, switch persists, no arbitrary wall traversal. Local reset restores geometry, ability readiness and minimum EE. No wildlife inside sterile vault; calm hum and maintenance dust. Main lower exit opens after training, not by defeating an optional enemy.

## 2. Terrain geometry and tile placement

Vestibule has two 8-tile isolator wings and central rest alcove. Keeper court target 36×18 tiles; two conductors feed shield. Relic plinth has 12-tile safe inspection deck. Training local geometry: pad x=9, shutter x=17, switch x=25 (tiles relative to a 34-tile practice strip), return-side gate at x=4. Rewind trajectory stays within same domain. Reset terminal x=6. No damaging hazards.

Set anchor foot surfaces at the coordinates in the table after multiplying by 16 tiles; refine surrounding contour locally. Keep ≥4-tile head clearance; target ≤2-tile rise and ≤4-tile mandatory gap. Do not interpolate steep atlas lines into unclimbable slopes: use the listed path profiles. The exact microgeometry is a blockout task, not an approved collision layout.

## 3. Landmarks and placement anchors

| Map mark | ID / landmark | Atlas (x,y) | Tile anchor | Role | State grants |
| --- | --- | --- | --- | --- | --- |
| 1 | REW-VEST / Vault Vestibule | (88,104) | (1408,1664) | Rest, paired shield isolators | KEEPER_EXPOSED |
| 2 | REW-KEEP / Keeper Court | (99,100) | (1584,1600) | Reliquary Keeper | KEEPER_DOWN |
| 3 | REW-RELIC / Personal Continuity Shrine | (111,99) | (1776,1584) | P08 confirms three systems and acquires relic | REWIND_ACQUIRED |
| 4 | REW-TRAIN / Return-Path Terrace | (104,109) | (1664,1744) | P09 local recorded-path exercise | REWIND_TRAINED |
| 5 | REW-SERVICE / Lower Service Landing | (89,112) | (1424,1792) | Exit toward Folded Depths | — |

## 4. Actual traversable connections

Every connection is two-way unless documented; conditions are persistent and must be checked in both directions. A crossing on the atlas is not a junction. For intersecting schematic routes, adjust local geometry/height or use an authored separated passage; do not accidentally connect them.

| Route | From → To | Mode | Condition / closure | Design |
| --- | --- | --- | --- | --- |
| PATH-080 | Vault Supply Bridge ↔ Vault Vestibule | walk | COLOSSUS_DOWN | Transition from reservoir machinery into pale vault |
| PATH-081 | Vault Vestibule ↔ Keeper Court | walk | KEEPER_EXPOSED | Paired isolators grant arena access |
| PATH-082 | Keeper Court ↔ Personal Continuity Shrine | walk | KEEPER_DOWN | Inner security vault |
| PATH-083 | Personal Continuity Shrine ↔ Return-Path Terrace | stairs | REWIND_ACQUIRED | Local training terrace and reset service |
| PATH-084 | Return-Path Terrace ↔ Lower Service Landing | walk | REWIND_TRAINED | Return-side gate opens after successful recorded path |
| PATH-085 | Lower Service Landing ↔ History Landing | viaduct | REWIND_TRAINED | Lower service traverse along reservoir foundation; scenic tunnel, no arbitrary portal |

### Local traversal profiles

- **Walk:** Start with 12–20 tiles of legible walking surface, then vary height with 1–2 tile steps. Introduce one sheltered side recess and preserve a 4-tile head clearance. Break long stretches with a landmark, change in surface or deliberate encounter.
- **Stairs:** Build walkable flights with 1–2 tile rises, 3–6 tile treads, and a ≥6 tile landing every 8–12 vertical tiles. Use lifts/ladders if the macro elevation exceeds practical stairs. Provide safe reversible down-route and mark drop-through surfaces.
- **Viaduct:** Build a continuous bridge/maintenance gallery 6–10 tiles wide at minimum local landing, 4+ tile headroom, strong structural supports, occasional inspection recess and varied skyline. Long span needs side discoveries and periodic cover/rest niches.

## 5. Puzzles, secrets, rewards and lore

### P07 — Vault Vestibule

- Clues: Keeper shield fed by paired conductors; diagram marks maintenance isolators.
- Solution: Disable left and right isolators; lock offline for encounter.
- Result / failure: Arena opens and core shield windows become available; wrong panel harmless feedback.
- State: `KEEPER_EXPOSED`. Record clues automatically and supply a local reset; no optional item or player EE is required except Rewind exercise with recharge.

### P08 — Personal Continuity Shrine

- Clues: Relic vault requires verified Sluice flow, Survey archive and Reservoir release. Three indicators and symbols correspond to earlier systems.
- Solution: Set Sluice=Flow, Survey=Archive, Reservoir=Release; confirm when all three prior flags true.
- Result / failure: Relic installed, save immediately; missing inputs identify exact system. Keeper already defeated.
- State: `REWIND_ACQUIRED`. Record clues automatically and supply a local reset; no optional item or player EE is required except Rewind exercise with recharge.

### P09 — Return-Path Terrace

- Clues: Safe tutorial: return from one-way switch to starting pad after shutter closes. Ghost trail and prompt show personal path.
- Solution: Charge ≥25 EE, walk from pad through shutter to switch within 4 s, activate, press F to rewind to pad.
- Result / failure: World switch remains active; next door opens. Reset button restores shutter and gives EE, no progress loss.
- State: `REWIND_TRAINED`. Record clues automatically and supply a local reset; no optional item or player EE is required except Rewind exercise with recharge.


| Anchor | Discoveries / reward IDs | Environmental hint |
| --- | --- | --- |
| Vault Vestibule | — | Rest, paired shield isolators |
| Keeper Court | — | Reliquary Keeper |
| Personal Continuity Shrine | AR19: Rescue equipment purpose | P08 confirms three systems and acquires relic |
| Return-Path Terrace | — | P09 local recorded-path exercise |
| Lower Service Landing | — | Exit toward Folded Depths |

## 6. Encounters and hazards

**Vault Vestibule:** E06 (E06-REW01). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**Reliquary Keeper (Required):** Mithril vault guardian; paired conductors isolated first; shield pulses and core windows. Counterplay: Shield opens after pulse for 1.6s; dodge charge; short encounter. No Rewind required. Prototype HP 380; damage 18–24. Arena seal closes after safe entry, resets on death.

All other stretches are deliberately free of required combat. Do not populate every screen. Place hostiles only in traversable habitats, at least one camera look-ahead from protected interaction spaces, and never within rest station safety bubbles.

## 7. Scenery composition and ecosystem

**Vault Vestibule** — Vault vestibule, rest shelter, paired left/right isolators and Mithril guard on separate approach platform.. Ambient design carried forward: No live animals in sealed vault; conductor hum and faint dust. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Keeper Court** — Keeper arena, external shield conductors already isolated; clear center and core exposure lanes.. Ambient design carried forward: No wildlife; shield light only. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Personal Continuity Shrine** — Relic chamber framed by symmetrical pale-alloy ribs; three verification inputs and inert forearm relic on pedestal.. Ambient design carried forward: No wildlife; symmetrical device light and dust. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Return-Path Terrace** — Safe tutorial lane; starting pad, authored shutter and switch, return door opens behind start after rewind.. Ambient design carried forward: No wildlife, minimal particles; ghost trail is personal Rewind preview. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Lower Service Landing** — Exit toward Folded Depths. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

Layer assignments: L00–L03 horizon/silhouette/midground; L04 noncombat wildlife; L05 near walls/props and lore; L06 collision; L07 actors; L08 telegraphs/ability effects; L09 foreground fade; L10 atmosphere. Use only the layers that fit the place. See [construction standards](../CONSTRUCTION_STANDARDS.md).

## 8. Save, transitions and acceptance

Rest stations: Vault Vestibule. Workbenches: none. All save IDs use landmark IDs, not scene filenames. Save durable changes, flags, discovery, resource transactions; do not save ephemeral hazard phase.

For each path, walk it in both directions with the real controller, test first entry at zero EE and full heat, verify camera sightlines, check before/after state, prove the required gate cannot be bypassed, check return from optional branches, and test save/load after persistent changes. Only accept the region after blind playtest.
