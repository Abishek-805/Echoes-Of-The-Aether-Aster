# Guild Town — geographical construction sheet

**Status:** proposed V4. Bounds (4,5)–(29,24) atlas units; one unit = 16 tiles = 256 logical pixels as a planning scale. These are terrain areas, not level rooms. The drawing is editable SVG: [local map](../MAPS/TOW.svg).

## 1. Place and historical purpose

Terraced frontier settlement on the west cliff; the east road is the only public entrance to the sanctuary. Main street is broad and safe. Orphanage hill is reached by two short flights of steps, with a return street descending to the guild. The workshop is outdoors beneath an awning; practice targets face a stone backstop. Build the skyline before the interior spaces. Use warm clay, bronze, cloth and mossy stone. No combat, no secret boss, no mandatory currency grind. The release ceremony shows an Echo departing before any energy tutorial. Mira's orphanage has ordinary toys, laundry and a handrail at child height. Copperwings perch on roof ridges, lantern moths cluster around flowers; town NPCs move short loops rather than blocking the player. After Warp, the surface is unreachable, not destroyed; exterior remains a historical map landmark.

## 2. Terrain geometry and tile placement

Street: 40–60 tiles between prominent storefront silhouettes; terraces with 1-tile steps. Guild doors are visible interactables rather than load screens. Practice lane 24 tiles long with backstop at +20, player at +4, safe exit behind. Put the memorial fountain at center of a broad 20-tile square. Roofs are background unless an explicit stair leads up.

Set anchor foot surfaces at the coordinates in the table after multiplying by 16 tiles; refine surrounding contour locally. Keep ≥4-tile head clearance; target ≤2-tile rise and ≤4-tile mandatory gap. Do not interpolate steep atlas lines into unclimbable slopes: use the listed path profiles. The exact microgeometry is a blockout task, not an approved collision layout.

## 3. Landmarks and placement anchors

| Map mark | ID / landmark | Atlas (x,y) | Tile anchor | Role | State grants |
| --- | --- | --- | --- | --- | --- |
| 1 | TOW-MEM / Release Square | (7,15) | (112,240) | Opening memorial and fountain, safe streets | — |
| 2 | TOW-ORP / Orphanage Hill | (11,8) | (176,128) | Mira, children and rooftops | — |
| 3 | TOW-GUILD / Guild Hall | (16,14) | (256,224) | Riven testimony and expedition authorization | BRIEFED |
| 4 | TOW-YARD / Artificer Terrace | (22,18) | (352,288) | Safe firing and heat lesson, workshop | TUTORIAL_DONE |
| 5 | TOW-EXIT / East Road | (28,17) | (448,272) | Surface threshold, closes behind Warp | — |

## 4. Actual traversable connections

Every connection is two-way unless documented; conditions are persistent and must be checked in both directions. A crossing on the atlas is not a junction. For intersecting schematic routes, adjust local geometry/height or use an authored separated passage; do not accidentally connect them.

| Route | From → To | Mode | Condition / closure | Design |
| --- | --- | --- | --- | --- |
| PATH-001 | Release Square ↔ Guild Hall | walk | open | Broad public street and fountain terraces |
| PATH-002 | Release Square ↔ Orphanage Hill | stairs | open | Orphanage hill staircase with roof vista |
| PATH-003 | Orphanage Hill ↔ Guild Hall | stairs | open | Descending public alley |
| PATH-004 | Guild Hall ↔ Artificer Terrace | walk | BRIEFED | Market ramp to artificer |
| PATH-005 | Artificer Terrace ↔ East Road | walk | TUTORIAL_DONE | East road |
| PATH-006 | East Road ↔ Trailhead Shelter | walk | TUTORIAL_DONE / closed on WARP | Surface passage physically cut by Warp; persistent closure |

### Local traversal profiles

- **Walk:** Start with 12–20 tiles of legible walking surface, then vary height with 1–2 tile steps. Introduce one sheltered side recess and preserve a 4-tile head clearance. Break long stretches with a landmark, change in surface or deliberate encounter.
- **Stairs:** Build walkable flights with 1–2 tile rises, 3–6 tile treads, and a ≥6 tile landing every 8–12 vertical tiles. Use lifts/ladders if the macro elevation exceeds practical stairs. Provide safe reversible down-route and mark drop-through surfaces.

## 5. Puzzles, secrets, rewards and lore

- **M01 at Artificer Terrace:** Practice cooling: release trigger until heat below safe line. Reward: basic tutorial completion, no reward lock. Wrong input resets locally; never gate critical route with this optional activity (M01 is safe onboarding practice).

| Anchor | Discoveries / reward IDs | Environmental hint |
| --- | --- | --- |
| Release Square | AR01: Release house custom | Opening memorial and fountain, safe streets |
| Orphanage Hill | — | Mira, children and rooftops |
| Guild Hall | DAWN01: Riven testimony | Riven testimony and expedition authorization |
| Artificer Terrace | — | Safe firing and heat lesson, workshop |
| East Road | — | Surface threshold, closes behind Warp |

## 6. Encounters and hazards

All other stretches are deliberately free of required combat. Do not populate every screen. Place hostiles only in traversable habitats, at least one camera look-ahead from protected interaction spaces, and never within rest station safety bubbles.

## 7. Scenery composition and ecosystem

**Release Square** — Sunlit release-house courtyard; bronze awnings, public fountain, departing Echo rising behind rooftops; procession of hunters and children.. Ambient design carried forward: 2 Copperwings roof; 4 distant hunters walk; fountain splash. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Orphanage Hill** — Quiet orphanage courtyard and interior alcove; Mira beside height marks carved into a doorway; birds nest above the roof.. Ambient design carried forward: 2 Copperwings perched ; caretaker and children in safe scene. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Guild Hall** — Guild hall built around a huge expedition map; Riven at scarred table, Liora at map wall, Garran by contract board.. Ambient design carried forward: 2 stationary guild NPCs and 1 map reader; no wildlife indoors. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**Artificer Terrace** — Bram's open forge yard; target lane with protective backstop, cooling vents and cell demonstration, no hostile damage.. Ambient design carried forward: forge sparks behind target; no wildlife in firing lane. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

**East Road** — Surface threshold, closes behind Warp. Position decorative actors behind playable collision and adjust to the new contour; do not reuse old local x coordinates.

Layer assignments: L00–L03 horizon/silhouette/midground; L04 noncombat wildlife; L05 near walls/props and lore; L06 collision; L07 actors; L08 telegraphs/ability effects; L09 foreground fade; L10 atmosphere. Use only the layers that fit the place. See [construction standards](../CONSTRUCTION_STANDARDS.md).

## 8. Save, transitions and acceptance

Rest stations: none; use adjacent regions, with protected story saves where required. Workbenches: Artificer Terrace. All save IDs use landmark IDs, not scene filenames. Save durable changes, flags, discovery, resource transactions; do not save ephemeral hazard phase.

For each path, walk it in both directions with the real controller, test first entry at zero EE and full heat, verify camera sightlines, check before/after state, prove the required gate cannot be bypassed, check return from optional branches, and test save/load after persistent changes. Only accept the region after blind playtest.
