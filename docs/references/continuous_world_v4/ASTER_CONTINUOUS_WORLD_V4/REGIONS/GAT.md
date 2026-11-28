# Warp-Broken Gate — geographical construction sheet

**Status:** proposed V4. Bounds (90,121)–(121,145) atlas units; one unit = 16 tiles = 256 logical pixels as a planning scale. These are terrain areas, not level rooms. The drawing is editable SVG: [local map](../MAPS/GAT.svg).

## 1. Place and historical purpose

A colossal gate at the farthest edge of the accessible sanctuary, approached through a broad containment court. The Last Custodian is a machine trying to protect the passage, not the trilogy villain. Arena seals only after safe entry; all attack zones are signaled; defeat releases a stored reserve source and opens gate approach. Aster inspects broken remote interface and sees the transit alignment fail; physical destination cannot be reached, no hidden alternative exit. Gate is visibly broken before interaction; journal labels it irreparable by Aster. P12 uses Guardian reserve source, isolate failed transit load, connect beacon and confirm distress packet. Player EE not spent. Beacon unlocks safe Refuge Terrace; Aster sets camp and ending follows. No active combat after the court, no ambient animals in sealed machinery; dust and a few quiet distant lights. End screen offers continue from final refuge with return paths to accessible sanctuary, not an alternative escape; post-credits Orion receives signal. Keep the view of the massive gate from earlier regions consistent.

## 2. Terrain geometry and tile placement

Containment Court target 50×24 tiles (camera follows constrained bounds; no unseen damage). Arrival platform 8 tiles before seal. Gate inspection deck 20 tiles, broken interface visible beyond nontraversable barrier. Beacon area 16 tiles flat, three controls with no combat. Refuge terrace 20 tiles safe with camp, workstation and return path; no fake exit.

Set anchor foot surfaces at the coordinates in the table after multiplying by 16 tiles; refine surrounding contour locally. Keep ≥4-tile head clearance; target ≤2-tile rise and ≤4-tile mandatory gap. Do not interpolate steep atlas lines into unclimbable slopes: use the listed path profiles. The exact microgeometry is a blockout task, not an approved collision layout.

## 3. Landmarks and placement anchors

| Map mark | ID / landmark | Atlas (x,y) | Tile anchor | Role | State grants |
| --- | --- | --- | --- | --- | --- |
| 1 | GAT-ARENA / Containment Court | (93,131) | (1488,2096) | Fold Guardian, Last Custodian | GUARDIAN_DOWN |
| 2 | GAT-GATE / Broken Transit Gate | (109,129) | (1744,2064) | Physical failure, Rewind cannot repair | GATE_DIAGNOSED |
| 3 | GAT-BEACON / Emergency Beacon | (116,136) | (1856,2176) | P12 isolate transit and transmit | SIGNAL_SENT |
| 4 | GAT-REFUGE / Refuge Terrace | (105,142) | (1680,2272) | Ending, safe camp and final rest | — |

## 4. Actual traversable connections

Every connection is two-way unless documented; conditions are persistent and must be checked in both directions. A crossing on the atlas is not a junction. For intersecting schematic routes, adjust local geometry/height or use an authored separated passage; do not accidentally connect them.

| Route | From → To | Mode | Condition / closure | Design |
| --- | --- | --- | --- | --- |
| PATH-102 | Last Rest ↔ Containment Court | walk | ANCHORS_STABLE | Short safe boss retry approach |
| PATH-103 | Containment Court ↔ Broken Transit Gate | walk | GUARDIAN_DOWN | Containment seal opens after Guardian defeat |
| PATH-104 | Broken Transit Gate ↔ Emergency Beacon | stairs | GATE_DIAGNOSED | Physically broken exit; emergency diagnostic walkway |
| PATH-105 | Emergency Beacon ↔ Refuge Terrace | stairs | SIGNAL_SENT | Beacon powers refuge access, not exit |

### Local traversal profiles

- **Walk:** Start with 12–20 tiles of legible walking surface, then vary height with 1–2 tile steps. Introduce one sheltered side recess and preserve a 4-tile head clearance. Break long stretches with a landmark, change in surface or deliberate encounter.
- **Stairs:** Build walkable flights with 1–2 tile rises, 3–6 tile treads, and a ≥6 tile landing every 8–12 vertical tiles. Use lifts/ladders if the macro elevation exceeds practical stairs. Provide safe reversible down-route and mark drop-through surfaces.

## 5. Puzzles, secrets, rewards and lore

### P12 — Emergency Beacon

- Clues: Power separate diagnostic channel after guardian defeated and gate inspected. Reserve source can route to broken transit or beacon.
- Solution: Isolate transit load, connect reserve source to beacon receiver, confirm distress packet.
- Result / failure: Signal sent, refuge unlocked; invalid routing shows broken-interface warning. No player EE cost or gate repair.
- State: `SIGNAL_SENT`. Record clues automatically and supply a local reset; no optional item or player EE is required except Rewind exercise with recharge.


| Anchor | Discoveries / reward IDs | Environmental hint |
| --- | --- | --- |
| Containment Court | AR24: Guardian final directive | Fold Guardian, Last Custodian |
| Broken Transit Gate | — | Physical failure, Rewind cannot repair |
| Emergency Beacon | — | P12 isolate transit and transmit |
| Refuge Terrace | — | Ending, safe camp and final rest |

## 6. Encounters and hazards

**Fold Guardian / Last Custodian (Required):** Containment system; Phase1 strikes/beams; Phase2 portal attacks; Phase3 delayed markers and exposed core. Counterplay: 1.0s minimum initial tell, 1.6s opening; phase thresholds 70%, 35%; no new last-second mechanic. Prototype HP 1000; damage 20–32. Arena seal closes after safe entry, resets on death.

All other stretches are deliberately free of required combat. Do not populate every screen. Place hostiles only in traversable habitats, at least one camera look-ahead from protected interaction spaces, and never within rest station safety bubbles.

## 7. Scenery composition and ecosystem

**Containment Court** — Containment arena: three monumental anchor arches, clean floor and neutral lighting for all Guardian attack tells.. Ambient design carried forward: No ambient actors; phase telegraphs and mechanical motion only. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Broken Transit Gate** — Warp-broken gate at far wall, split remote interface and dead transit aperture; visible physical break not a riddle.. Ambient design carried forward: No fauna; fractured aperture motion and dead anchor. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Emergency Beacon** — Beacon terminal on surviving circuit; isolator and reserve source, view of disabled gate through glass.. Ambient design carried forward: No fauna; steady diagnostic signal pulses. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Refuge Terrace** — Sheltered refuge with rest/workbench, folded blanket, faint skyline through fracture and distress indicator; credits trigger.. Ambient design carried forward: No fauna inside; occasional distant light beyond fracture, not a traversable exit. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

Layer assignments: L00–L03 horizon/silhouette/midground; L04 noncombat wildlife; L05 near walls/props and lore; L06 collision; L07 actors; L08 telegraphs/ability effects; L09 foreground fade; L10 atmosphere. Use only the layers that fit the place. See [construction standards](../CONSTRUCTION_STANDARDS.md).

## 8. Save, transitions and acceptance

Rest stations: Refuge Terrace. Workbenches: Refuge Terrace. All save IDs use landmark IDs, not scene filenames. Save durable changes, flags, discovery, resource transactions; do not save ephemeral hazard phase.

For each path, walk it in both directions with the real controller, test first entry at zero EE and full heat, verify camera sightlines, check before/after state, prove the required gate cannot be bypassed, check return from optional branches, and test save/load after persistent changes. Only accept the region after blind playtest.
