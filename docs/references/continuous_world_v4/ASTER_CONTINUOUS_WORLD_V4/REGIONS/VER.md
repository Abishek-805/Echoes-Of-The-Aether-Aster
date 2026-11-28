# Veraya Fold — geographical construction sheet

**Status:** proposed V4. Bounds (84,66)–(119,88) atlas units; one unit = 16 tiles = 256 logical pixels as a planning scale. These are terrain areas, not level rooms. The drawing is editable SVG: [local map](../MAPS/VER.svg).

## 1. Place and historical purpose

This is physically Veraya, connected only through authored Warp throats. Distinguish modern modular steel and bolted laboratory equipment from underlying seamless Vaelari stone. Atrium opens onto an unfamiliar sky beyond a large broken observation window. Research Gallery has current measuring equipment, a named diagnostic recording without revealing Orion, and two traversable maintenance terraces. Foreign Sky is a quiet vista before the separate return fold to Eldara's memorial network. The optional Annex contains equipment and an interface reference but not the actual replacement component; that remains inaccessible until Orion's story. Prism Beetles in open niches and Silverkites outside windows, no Eldaran fish. Defective sentinels patrol lab floor and telegraph charges; no enemy in rest zone. The return fold is stable and bidirectional after P05, not a usable player teleport power. The late service alcove is visible as a one-sided shutter, not a path to the planet surface.

## 2. Terrain geometry and tile placement

Atrium 20-tile vista floor, diagnostic galleries alternate 10-tile deck and 2-tile stair. Annex console on 12-tile dead-end spur with a safe return. Foreign sky terrace has clear sightline to Verayan skyline; no interaction to leave surface. Both fold arrival decks ≥8 tiles, no immediate enemies.

Set anchor foot surfaces at the coordinates in the table after multiplying by 16 tiles; refine surrounding contour locally. Keep ≥4-tile head clearance; target ≤2-tile rise and ≤4-tile mandatory gap. Do not interpolate steep atlas lines into unclimbable slopes: use the listed path profiles. The exact microgeometry is a blockout task, not an approved collision layout.

## 3. Landmarks and placement anchors

| Map mark | ID / landmark | Atlas (x,y) | Tile anchor | Role | State grants |
| --- | --- | --- | --- | --- | --- |
| 1 | VER-ATRIUM / Foreign Atrium | (86,73) | (1376,1168) | Rest and first Verayan view | — |
| 2 | VER-GALLERY / Research Gallery | (99,70) | (1584,1120) | Anonymous diagnostic recording | — |
| 3 | VER-SKY / Foreign Sky Terrace | (113,75) | (1808,1200) | Visible different skyline, outbound memorial fold | — |
| 4 | VER-ANNEX / Diagnostic Annex | (105,84) | (1680,1344) | M11 precision rifle, interface reference, later return | — |
| 5 | VER-RETURN / Service Alcove | (88,85) | (1408,1360) | Later Rewind shortcut arrival | — |

## 4. Actual traversable connections

Every connection is two-way unless documented; conditions are persistent and must be checked in both directions. A crossing on the atlas is not a junction. For intersecting schematic routes, adjust local geometry/height or use an authored separated passage; do not accidentally connect them.

| Route | From → To | Mode | Condition / closure | Design |
| --- | --- | --- | --- | --- |
| PATH-061 | Stable Fold ↔ Foreign Atrium | fold | TOPOLOGY_ALIGNED | Warp throat A: Eldara to Veraya; reciprocal |
| PATH-062 | Unmapped Loop ↔ Research Gallery | fold | LOOP_MARKED, TOPOLOGY_ALIGNED | S04 Warp throat B after both anchor checks |
| PATH-063 | Foreign Atrium ↔ Research Gallery | walk | open | Foreign lab floor and research recording |
| PATH-064 | Research Gallery ↔ Foreign Sky Terrace | terraces | open | Observation ramp and unfamiliar skyline |
| PATH-065 | Research Gallery ↔ Diagnostic Annex | stairs | open | Diagnostic annex M11, local puzzle |
| PATH-066 | Diagnostic Annex ↔ Service Alcove | walk | open | Service alcove dead-end until local Rewind route |
| PATH-067 | Foreign Sky Terrace ↔ Memorial Hall | fold | TOPOLOGY_ALIGNED | Warp throat C returns to Eldaran memorials; dashed atlas line is NOT a physical cross-planet corridor |
| PATH-088 | One-Way Gallery ↔ Service Alcove | fold | REWIND_TRAINED, REWIND_RETURN | S07 dormant paired maintenance fold unlocked by M16, not arbitrary teleport |

### Local traversal profiles

- **Fold:** Build two distinct approach decks (≥8 tiles each) with matching anchor shape and readable threshold. Transition to the destination coordinate/planet after a brief fold cue; clear Rewind history at the seam. No physical geometry across the dashed atlas connection.
- **Walk:** Start with 12–20 tiles of legible walking surface, then vary height with 1–2 tile steps. Introduce one sheltered side recess and preserve a 4-tile head clearance. Break long stretches with a landmark, change in surface or deliberate encounter.
- **Terraces:** Use staggered 6–12 tile platforms with ≤2 tile rises and ≤4 tile mandatory gaps; add a lower recovery deck, not a lethal void. Hide optional ledges in scenery only with a visible cue.
- **Stairs:** Build walkable flights with 1–2 tile rises, 3–6 tile treads, and a ≥6 tile landing every 8–12 vertical tiles. Use lifts/ladders if the macro elevation exceeds practical stairs. Provide safe reversible down-route and mark drop-through surfaces.

## 5. Puzzles, secrets, rewards and lore

- **M11 at Diagnostic Annex:** Align diagnostic display with source/receiver. Reward: BP04, WPN02; part reference only. Wrong input resets locally; never gate critical route with this optional activity (M01 is safe onboarding practice).

| Anchor | Discoveries / reward IDs | Environmental hint |
| --- | --- | --- |
| Foreign Atrium | — | Rest and first Verayan view |
| Research Gallery | AR12: Anonymous researcher | Diagnostic annex marked by cable run |
| Foreign Sky Terrace | — | Visible different skyline, outbound memorial fold |
| Diagnostic Annex | AR13: Remote interface part reference; BP04: equipment blueprint; WPN02: Precision Rifle | Diagnostic wire leads to concealed case; late return hatch |
| Service Alcove | — | Later Rewind shortcut arrival |

## 6. Encounters and hazards

**Foreign Atrium:** E05 (E05-VER01). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**Foreign Sky Terrace:** E05 (E05-VER03), fall (HZ-VER03). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**Diagnostic Annex:** V03 (V03-VER04), beam (HZ-VER04). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

All other stretches are deliberately free of required combat. Do not populate every screen. Place hostiles only in traversable habitats, at least one camera look-ahead from protected interaction spaces, and never within rest station safety bubbles.

## 7. Scenery composition and ecosystem

**Foreign Atrium** — Foreign atrium with modern bolted instruments and blue steel; rest alcove then Sentinel patrol.. Ambient design carried forward: 1 prism beetle under bench; inactive diagnostic equipment. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Research Gallery** — Research gallery with anonymous voice recording, laboratory benches and observation windows toward alien sky.. Ambient design carried forward: 2 basin minnows in background tank only; no open-air birds indoors. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Foreign Sky Terrace** — Open foreign sky with ringed moon, levitating-looking rock supports actually fixed by anchors; Sentinel on stable deck.. Ambient design carried forward: 3 Silverkites circle ringed moon vista; grass moves on fixed stone platforms. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Diagnostic Annex** — Diagnostic annex with precision rifle case, Prism Array and missing remote-interface part reference; part unavailable in I.. Ambient design carried forward: 1 prism beetle behind cold cabinet; no actors near beam lanes. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Service Alcove** — Later Rewind shortcut arrival. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

Layer assignments: L00–L03 horizon/silhouette/midground; L04 noncombat wildlife; L05 near walls/props and lore; L06 collision; L07 actors; L08 telegraphs/ability effects; L09 foreground fade; L10 atmosphere. Use only the layers that fit the place. See [construction standards](../CONSTRUCTION_STANDARDS.md).

## 8. Save, transitions and acceptance

Rest stations: Foreign Atrium. Workbenches: none. All save IDs use landmark IDs, not scene filenames. Save durable changes, flags, discovery, resource transactions; do not save ephemeral hazard phase.

For each path, walk it in both directions with the real controller, test first entry at zero EE and full heat, verify camera sightlines, check before/after state, prove the required gate cannot be bypassed, check return from optional branches, and test save/load after persistent changes. Only accept the region after blind playtest.
