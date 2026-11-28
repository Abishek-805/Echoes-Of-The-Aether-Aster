# Rootspan — geographical construction sheet

**Status:** proposed V4. Bounds (39,28)–(78,56) atlas units; one unit = 16 tiles = 256 logical pixels as a planning scale. These are terrain areas, not level rooms. The drawing is editable SVG: [local map](../MAPS/ROT.svg).

## 1. Place and historical purpose

The Great Root dominates the middle of the map. Design three playable elevations: canopy branches, trunk/terrace network and underroot water service route. The root silhouette is visible from the sluice and archive balcony. Crown Fork is an early optional overlook from Hunter's Reach, but the lower bridge remains disconnected until Warden is defeated. The main route crosses Root Bridge and follows root stair terraces to Foundry Footbridge. Garden branch curves below the bridge; water is dry before Sluice and remains isolated until M06 connects the garden valve. After restoration, fish appear, pond lilies open, a float platform rises and a return path opens to Sluice. Moss Hollow is a naturally enclosed root cavity, with Titan only after Warden and local marker. No mandatory swimming, swinging, double jump or wall climbing; use broad branch tops and authored ladders or mechanical lifts. Hares, mossback grazers, moths, Copperwings, glassfin shoals, crabs and eels occupy separate habitats. Predators are not background loot. Foreground leaves frame the canopy, then fade around player and telegraphs.

## 2. Terrain geometry and tile placement

Crown route uses 8–16 tile branches and 2-tile staggered terraces. Main trunk has a wraparound stair path, not a climbable decorative sprite. Lower garden bank 20 tiles long, water visual layer behind a dry path; raised float deck has a 6-tile landing. Titan hollow 44×22 tiles, separate from lower bypass. Underroot culvert ≥5 tile headroom with 6-tile dry ledges, never swimming.

Set anchor foot surfaces at the coordinates in the table after multiplying by 16 tiles; refine surrounding contour locally. Keep ≥4-tile head clearance; target ≤2-tile rise and ≤4-tile mandatory gap. Do not interpolate steep atlas lines into unclimbable slopes: use the listed path profiles. The exact microgeometry is a blockout task, not an approved collision layout.

## 3. Landmarks and placement anchors

| Map mark | ID / landmark | Atlas (x,y) | Tile anchor | Role | State grants |
| --- | --- | --- | --- | --- | --- |
| 1 | ROT-BRIDGE / Root Bridge | (42,48) | (672,768) | Rest in sheltered hunter platform | — |
| 2 | ROT-CANOPY / Great Root Canopy | (51,35) | (816,560) | High route and visible irrigation seam | — |
| 3 | ROT-FORK / Crown Fork | (65,32) | (1040,512) | Early overlook and return path, no deep access before Warden | — |
| 4 | ROT-GARDEN / Forgotten Water Garden | (56,51) | (896,816) | Pond, M06 irrigation, optional rewards | GARDEN_RESTORED |
| 5 | ROT-HOLLOW / Moss Hollow | (70,48) | (1120,768) | Optional Titan, safe return | TITAN_DOWN, TITAN_MARKED |
| 6 | ROT-TUNNEL / Underroot Culvert | (46,55) | (736,880) | Lower service passage and overflow vista | — |
| 7 | ROT-EAST / Foundry Footbridge | (76,53) | (1216,848) | Natural passage into Reliquary Works | — |

## 4. Actual traversable connections

Every connection is two-way unless documented; conditions are persistent and must be checked in both directions. A crossing on the atlas is not a junction. For intersecting schematic routes, adjust local geometry/height or use an authored separated passage; do not accidentally connect them.

| Route | From → To | Mode | Condition / closure | Design |
| --- | --- | --- | --- | --- |
| PATH-020 | Split Walk ↔ Crown Fork | stairs | open | Early upper canopy overlook; no descent to lower Rootspan until Warden |
| PATH-033 | Garden Outlet ↔ Root Bridge | walk | WARDEN_DOWN | Water channel becomes root bridge |
| PATH-036 | Root Bridge ↔ Great Root Canopy | stairs | WARDEN_DOWN | Roots with authored stair terraces and safe lift |
| PATH-037 | Great Root Canopy ↔ Crown Fork | terraces | WARDEN_DOWN | Connects early overlook to main trunk only after bridge is safe |
| PATH-038 | Root Bridge ↔ Forgotten Water Garden | walk | WARDEN_DOWN | Lower roots descend toward garden valve M06 |
| PATH-039 | Forgotten Water Garden ↔ Underroot Culvert | stairs | GARDEN_RESTORED | Restored float deck gives access to underroot service |
| PATH-040 | Underroot Culvert ↔ Split Stone Regulator | viaduct | GARDEN_RESTORED, WARDEN_DOWN | S02 service tunnel, safe bilateral return |
| PATH-041 | Great Root Canopy ↔ Moss Hollow | stairs | WARDEN_DOWN | Marked hollow entry, optional Titan trigger |
| PATH-042 | Forgotten Water Garden ↔ Moss Hollow | walk | WARDEN_DOWN | Lower root loop, retreat permitted before arena seal |
| PATH-043 | Great Root Canopy ↔ Foundry Footbridge | terraces | WARDEN_DOWN | High trunk traverse to foundry bridge, separate from Titan arena |
| PATH-044 | Forgotten Water Garden ↔ Foundry Footbridge | terraces | WARDEN_DOWN | Lower contour bypass, rejoins footbridge without Titan |
| PATH-045 | Foundry Footbridge ↔ Workshop | walk | WARDEN_DOWN | Roots intrude on industrial maintenance walkway |
| PATH-049 | Storage Loft ↔ Great Root Canopy | viaduct | LOFT_RELAY, WARDEN_DOWN | S03 maintenance rail over root terrace |

### Local traversal profiles

- **Stairs:** Build walkable flights with 1–2 tile rises, 3–6 tile treads, and a ≥6 tile landing every 8–12 vertical tiles. Use lifts/ladders if the macro elevation exceeds practical stairs. Provide safe reversible down-route and mark drop-through surfaces.
- **Walk:** Start with 12–20 tiles of legible walking surface, then vary height with 1–2 tile steps. Introduce one sheltered side recess and preserve a 4-tile head clearance. Break long stretches with a landmark, change in surface or deliberate encounter.
- **Terraces:** Use staggered 6–12 tile platforms with ≤2 tile rises and ≤4 tile mandatory gaps; add a lower recovery deck, not a lethal void. Hide optional ledges in scenery only with a visible cue.
- **Viaduct:** Build a continuous bridge/maintenance gallery 6–10 tiles wide at minimum local landing, 4+ tile headroom, strong structural supports, occasional inspection recess and varied skyline. Long span needs side discoveries and periodic cover/rest niches.

## 5. Puzzles, secrets, rewards and lore

- **M06 at Forgotten Water Garden:** Route water from restored sluice to garden. Reward: GARDEN_RESTORED, HP01, MEM02. Wrong input resets locally; never gate critical route with this optional activity (M01 is safe onboarding practice).
- **M07 at Moss Hollow:** Activate hollow marker after Warden, defeat Titan. Reward: MAP04, alloy. Wrong input resets locally; never gate critical route with this optional activity (M01 is safe onboarding practice).

| Anchor | Discoveries / reward IDs | Environmental hint |
| --- | --- | --- |
| Root Bridge | — | Rest in sheltered hunter platform |
| Great Root Canopy | — | Root notch leads to hollow; loft relay hatch visible |
| Crown Fork | — | Early overlook and return path, no deep access before Warden |
| Forgotten Water Garden | AR06: Garden ecosystem; HP01: +10 max HP; MEM02: hidden memorial | Moss-covered release glyph beside dried pond |
| Moss Hollow | MAP04: optional map annotation | Distinct hollow trunk with root marker |
| Underroot Culvert | — | Lower service passage and overflow vista |
| Foundry Footbridge | — | Natural passage into Reliquary Works |

## 6. Encounters and hazards

**Great Root Canopy:** E01 (E01-ROT02), fall (HZ-ROT02). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**Forgotten Water Garden:** water (HZ-ROT03). Use authored safe waiting pockets and readable approach. Old marker coordinates are retired; place threats on the new terrain as described above.

**Mossbound Titan (Optional):** Root-covered maintenance guardian; root sweep, falling debris, expose side core. Counterplay: 0.9s tell; 1.3s recover; jump sweep, move from debris marker. MAP04 and alloy. Prototype HP 420; damage 20–26. Arena seal closes after safe entry, resets on death.

All other stretches are deliberately free of required combat. Do not populate every screen. Place hostiles only in traversable habitats, at least one camera look-ahead from protected interaction spaces, and never within rest station safety bubbles.

## 7. Scenery composition and ecosystem

**Root Bridge** — Rest shelter on restored root bridge; distant waterwheel turns after P01, canopy light returns.. Ambient design carried forward: 2 swifts above bridge; waterwheel turns; 1 mossback grazer on far bank. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Great Root Canopy** — Vertical root terraces with climbable edges and canopy bridges; foreground birds lift off; isolated Forager.. Ambient design carried forward: 3 swifts in canopy, 1 mossback far behind combat; bird flock flees on attacks. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Crown Fork** — Early overlook and return path, no deep access before Warden. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Forgotten Water Garden** — Garden terraces with dry pond, cracked irrigation stone and hidden memorial; valve restores water and wildlife.. Ambient design carried forward: Dry moss and insects before M06; after M06 pond 4 glassfin, 1 ripple eel, 2 reed crabs; birds feed above. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Moss Hollow** — Root-wrapped maintenance chamber; optional Titan rises from beneath a hollow tree, reward nook opens afterward.. Ambient design carried forward: Dormant roots and falling leaves; no fauna during arena. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Underroot Culvert** — Lower service passage and overflow vista. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Foundry Footbridge** — Natural passage into Reliquary Works. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

Layer assignments: L00–L03 horizon/silhouette/midground; L04 noncombat wildlife; L05 near walls/props and lore; L06 collision; L07 actors; L08 telegraphs/ability effects; L09 foreground fade; L10 atmosphere. Use only the layers that fit the place. See [construction standards](../CONSTRUCTION_STANDARDS.md).

## 8. Save, transitions and acceptance

Rest stations: Root Bridge. Workbenches: none. All save IDs use landmark IDs, not scene filenames. Save durable changes, flags, discovery, resource transactions; do not save ephemeral hazard phase.

For each path, walk it in both directions with the real controller, test first entry at zero EE and full heat, verify camera sightlines, check before/after state, prove the required gate cannot be bypassed, check return from optional branches, and test save/load after persistent changes. Only accept the region after blind playtest.
