# Echo Reservoir — geographical construction sheet

**Status:** proposed V4. Bounds (40,89)–(79,110) atlas units; one unit = 16 tiles = 256 logical pixels as a planning scale. These are terrain areas, not level rooms. The drawing is editable SVG: [local map](../MAPS/RES.svg).

## 1. Place and historical purpose

A vast, partially open cistern with transparent conduits and a towering release manifold visible from several elevations. Distinguish ordinary hydraulic water from Echo channels: water flows blue-green with ripples; Echo energy travels through sealed luminous conduits; an Echo releases upward as a separate motif. Main path wraps around the basin on tiered inspection decks, never requires swimming. P06 follows source feed to three branches: vault power, release path, already-full storage. Toggle Vault ON, Release ON, Full Storage OFF; show pressure bars and arrows. After success lights stabilize and some Echo-dependent enemies leave; ordinary fish can return in physically connected water only. Colossus occupies an alignment court on a broad platform, attacks from marked folds overhead or behind, fully avoidable before Rewind. Overflow branch is optional; isolate after P06, then open return to Warped Verge from local latch. Basin minnows and filter shrimp are in water behind glass; Echo Leeches near exposed bound Echo accumulations, not fish schools. No player resource expenditure on required switches.

## 2. Terrain geometry and tile placement

Ring walkway around basin with 8–14 tile inspection decks, no playable deep water. Three toggles on 10-tile control deck; feed lines visually traceable from source. Colossus arena target 48×22 tiles, safe sidelines and clearly marked offscreen-origin warning. Overflow ladder uses call-from-both-ends lift and dry landing; no route beneath energy discharge.

Set anchor foot surfaces at the coordinates in the table after multiplying by 16 tiles; refine surrounding contour locally. Keep ≥4-tile head clearance; target ≤2-tile rise and ≤4-tile mandatory gap. Do not interpolate steep atlas lines into unclimbable slopes: use the listed path profiles. The exact microgeometry is a blockout task, not an approved collision layout.

## 3. Landmarks and placement anchors

| Map mark | ID / landmark | Atlas (x,y) | Tile anchor | Role | State grants |
| --- | --- | --- | --- | --- | --- |
| 1 | RES-DECK / Flow Deck | (42,101) | (672,1616) | Rest/workbench, water/EE separation shown | — |
| 2 | RES-SOURCE / Source Manifold | (51,94) | (816,1504) | P06 source and routing schematic | — |
| 3 | RES-ROUTE / Release Manifold | (59,101) | (944,1616) | P06 three toggles and pressure indicators | RESERVOIR_STABLE |
| 4 | RES-COURT / Alignment Court | (73,99) | (1168,1584) | Wayfinder Colossus habitat | COLOSSUS_DOWN |
| 5 | RES-OVER / Overflow Alcove | (48,108) | (768,1728) | M13 optional isolation, return spur | OVERFLOW_ISOLATED |
| 6 | RES-EXIT / Vault Supply Bridge | (78,106) | (1248,1696) | Stable connection to Rewind Sanctuary | — |

## 4. Actual traversable connections

Every connection is two-way unless documented; conditions are persistent and must be checked in both directions. A crossing on the atlas is not a junction. For intersecting schematic routes, adjust local geometry/height or use an authored separated passage; do not accidentally connect them.

| Route | From → To | Mode | Condition / closure | Design |
| --- | --- | --- | --- | --- |
| PATH-073 | Release Walk ↔ Flow Deck | walk | MEMORIAL_SEEN | Quiet stone transitions into service basin |
| PATH-074 | Flow Deck ↔ Source Manifold | stairs | open | Source pipes climb to manifold |
| PATH-075 | Source Manifold ↔ Release Manifold | stairs | open | Three branch controls on a compact inspection loop |
| PATH-076 | Release Manifold ↔ Alignment Court | walk | RESERVOIR_STABLE | Stabilized pressure gate into alignment court |
| PATH-077 | Flow Deck ↔ Overflow Alcove | stairs | RESERVOIR_STABLE | Overflow alcove M13 after safe release |
| PATH-078 | Overflow Alcove ↔ Broken Promenade | lift | RESERVOIR_STABLE, OVERFLOW_ISOLATED | S05 long maintenance return shaft along basin rim |
| PATH-079 | Alignment Court ↔ Vault Supply Bridge | terraces | COLOSSUS_DOWN | Vault supply bridge opens when court safe |
| PATH-080 | Vault Supply Bridge ↔ Vault Vestibule | walk | COLOSSUS_DOWN | Transition from reservoir machinery into pale vault |

### Local traversal profiles

- **Walk:** Start with 12–20 tiles of legible walking surface, then vary height with 1–2 tile steps. Introduce one sheltered side recess and preserve a 4-tile head clearance. Break long stretches with a landmark, change in surface or deliberate encounter.
- **Stairs:** Build walkable flights with 1–2 tile rises, 3–6 tile treads, and a ≥6 tile landing every 8–12 vertical tiles. Use lifts/ladders if the macro elevation exceeds practical stairs. Provide safe reversible down-route and mark drop-through surfaces.
- **Lift:** Use a platform lift or counterweight with a 6–10 tile deck, call button at both ends, stable landings and anti-crush sensor. For long mixed routes, alternate horizontal galleries and lifts rather than a single enormous vertical shaft.
- **Terraces:** Use staggered 6–12 tile platforms with ≤2 tile rises and ≤4 tile mandatory gaps; add a lower recovery deck, not a lethal void. Hide optional ledges in scenery only with a visible cue.

## 5. Puzzles, secrets, rewards and lore

### P06 — Release Manifold

- Clues: Power vault and preserve safe release. Source feeds three toggles; storage indicator full.
- Solution: Vault power ON, Release ON, Full storage OFF.
- Result / failure: Reservoir stabilizes, local fauna reduced, arena accessible; full storage alarms, no fatal penalty.
- State: `RESERVOIR_STABLE`. Record clues automatically and supply a local reset; no optional item or player EE is required except Rewind exercise with recharge.

- **M13 at Overflow Alcove:** Isolate overflow line after P06. Reward: HP03, BP05. Wrong input resets locally; never gate critical route with this optional activity (M01 is safe onboarding practice).

| Anchor | Discoveries / reward IDs | Environmental hint |
| --- | --- | --- |
| Flow Deck | AR17: Safe release schematic | Rest/workbench, water/EE separation shown |
| Source Manifold | — | P06 source and routing schematic |
| Release Manifold | AR18: Storage capacity warning | Overflow conduit leads to alcove |
| Alignment Court | — | Wayfinder Colossus habitat |
| Overflow Alcove | HP03: +10 max HP; BP05: equipment blueprint | Dry return pipe points back to WAR02 |
| Vault Supply Bridge | — | Stable connection to Rewind Sanctuary |

## 6. Encounters and hazards

**Flow Deck:** E05 (E05-RES01), E07 (E07-RES01). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**Release Manifold:** E07 (E07-RES02), steam (HZ-RES02). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**Overflow Alcove:** water (HZ-RES04). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**Wayfinder Colossus (Required):** Damaged alignment construct; rear beam, ceiling marker, fold punch, resonance pulse. Counterplay: 0.8–1.2s warnings; 1.5s exposed core; all avoidable pre-Rewind. Phase2 combines two known attacks sequentially. Prototype HP 620; damage 18–28. Arena seal closes after safe entry, resets on death.

All other stretches are deliberately free of required combat. Do not populate every screen. Place hostiles only in traversable habitats, at least one camera look-ahead from protected interaction spaces, and never within rest station safety bubbles.

## 7. Scenery composition and ecosystem

**Flow Deck** — Flow deck with rest/workbench behind sealed maintenance screen; visible reservoir and roaming Sentinel/Leech beyond.. Ambient design carried forward: 3 filter shrimp in coolant observation tank; water pulsing before stabilization. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Source Manifold** — P06 source and routing schematic. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Release Manifold** — Three branch pipes with distinct symbols, flow meter and saturated storage tank; Leeches occupy approach only.. Ambient design carried forward: Coolant pool behind walkway; 2 shrimp and 3 glassfin after P06; leech density falls. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Alignment Court** — Colossus alignment court; tall overhead apertures and wide flat arena for marked rear beams and ceiling attacks.. Ambient design carried forward: No decorative actors during arena; steady flow after victory. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Overflow Alcove** — Overflow service catwalk, relief valve and surplus-energy pool; safe alcove opens after reservoir stabilization.. Ambient design carried forward: 2 glassfin in side channel, dry pipe return route above. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Vault Supply Bridge** — Stable connection to Rewind Sanctuary. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

Layer assignments: L00–L03 horizon/silhouette/midground; L04 noncombat wildlife; L05 near walls/props and lore; L06 collision; L07 actors; L08 telegraphs/ability effects; L09 foreground fade; L10 atmosphere. Use only the layers that fit the place. See [construction standards](../CONSTRUCTION_STANDARDS.md).

## 8. Save, transitions and acceptance

Rest stations: Flow Deck. Workbenches: Flow Deck. All save IDs use landmark IDs, not scene filenames. Save durable changes, flags, discovery, resource transactions; do not save ephemeral hazard phase.

For each path, walk it in both directions with the real controller, test first entry at zero EE and full heat, verify camera sightlines, check before/after state, prove the required gate cannot be bypassed, check return from optional branches, and test save/load after persistent changes. Only accept the region after blind playtest.
