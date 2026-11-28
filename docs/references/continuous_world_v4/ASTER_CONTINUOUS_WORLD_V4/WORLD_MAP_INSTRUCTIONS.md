# Master world map — The Fractured Sanctuary

## Overview
This package translates the existing illustrated map into a geographical build plan. It retains sixteen established regions but removes the 64-room restriction. Landmarks are points within large landscapes, not levels. The 87 landmarks in this draft are navigation and placement anchors, not a new cap or a requirement to create that many scenes. The 105 paths are actual design links, some optional or locked, rather than automatic connections between nearby marks. The source illustration is in [REFERENCE](REFERENCE/CONCEPT_MAP.png); technical map in [MAPS](MAPS/WORLD_BLUEPRINT.svg). If concept and blueprint differ, the topology and canon govern construction, concept guides visual atmosphere.

## Geographical map creation
1. Lay out the surface ridge and east-facing town on upper west cliff, wilds in center, hunter ridge east, survey camp under it. Place Hanging Bell visible from Outer Wilds, Hunter's Reach and Camp. Split Rock is east-northeast of survey board (116,29), not the earlier V3 compass direction. Create the ridge traverse west toward Sluice.
2. Place waterworks on west slope and Great Root in central valley beneath the ridge. Water flows down from catchment through Sluice outlet into main channels and reservoir; side garden valve independently restores pond. Build upper canopy route discoverable early; lower trunk cannot reach foundry before Warden. Foundry on east side, linked by root bridge; archive occupies western middle cliff, connected by elevated service viaduct. Bell, tree and gate silhouettes recur; these are actual landmarks, not decorative random mountains.
3. Below archive, create fractured promenade. Establish explicit fold A to Verayan research annex, optional fold B after P05 + M10, and return fold C from foreign sky to memorial terrace. Veraya is a separate planet; atlas proximity does not imply literal shared terrain. Show distinct sky, modern equipment and underlying Vaelari signatures. Fold links only connect authored mouths.
4. Below memorials and central roots, place the Echo Reservoir as a basin with surrounding inspection decks. Separate water from Echo conduit energy. Place protected Rewind Sanctuary east, built atop reservoir supply line. Below the basin, lower service viaduct leads west to Folded Depths. Optional archive and Veraya returns recontextualize earlier terrain. The final stabilizer viaduct lies east, and monumental gate sits farthest southeast. It has no exit in Aster's game.
5. Build playable terrain as a continuous contour along each named route. Use region sheets for microgeometry and placement; match endpoints, correct schematic intersections, and verify traversal first. Do not make equal-sized rooms or create level complete screens. Ordinary path changes and camera continuity are important; technical chunks are invisible.

## Region index
| Map region | Construction sheet | Main geographic role | Suggested first-pass character |
| --- | --- | --- | --- |
| Guild Town | [Detailed guide](REGIONS/TOW.md) · [SVG map](MAPS/TOW.svg) | Opening memorial and fountain, safe streets | Terraced frontier settlement on the west cliff; the east road is the only public entrance to the sanctuary |
| Outer Wilds | [Detailed guide](REGIONS/OUT.md) · [SVG map](MAPS/OUT.svg) | First rest, ridge overlooks town | A broad open-air foothill valley between the town and the sanctuary rim |
| Hunter's Reach | [Detailed guide](REGIONS/HUN.md) · [SVG map](MAPS/HUN.svg) | Old ropes and trail tags | A ridgeline of wooden hunting platforms wrapped around stone spires, not a straight corridor |
| Old Survey Camp | [Detailed guide](REGIONS/CAM.md) · [SVG map](MAPS/CAM.svg) | Post-Warp safe shelter and rest | A small expedition site tucked beneath the hunter ridge |
| Echo Sluice | [Detailed guide](REGIONS/SLU.md) · [SVG map](MAPS/SLU.svg) | Rest under pressure gauge, dry waterfall | This is the hydraulic control head of the sanctuary: gravity-fed catchment above the valves, pressure gallery below, water falling toward the garden and Echo Reservoir |
| Rootspan | [Detailed guide](REGIONS/ROT.md) · [SVG map](MAPS/ROT.svg) | Rest in sheltered hunter platform | The Great Root dominates the middle of the map |
| Reliquary Works | [Detailed guide](REGIONS/REL.md) · [SVG map](MAPS/REL.svg) | Rest/workbench, first alloy view | Old manufacturing and repair facilities built to service relics |
| Survey Vault | [Detailed guide](REGIONS/SUR.md) · [SVG map](MAPS/SUR.svg) | Rest, vista toward bell tower | A tall archive sunk into the rock below the sluice, reached from the foundry along a high viaduct with water flowing beneath |
| Warped Verge | [Detailed guide](REGIONS/WAR.md) · [SVG map](MAPS/WAR.svg) | Rest on stable Eldaran slab | A fractured connection zone, not an alternate planet by itself |
| Veraya Fold | [Detailed guide](REGIONS/VER.md) · [SVG map](MAPS/VER.svg) | Rest and first Verayan view | This is physically Veraya, connected only through authored Warp throats |
| Silent Gallery | [Detailed guide](REGIONS/SIL.md) · [SVG map](MAPS/SIL.svg) | Quiet names and stone colonnade | A memorial garden below the archives; enters from Veraya through a localized return fold across the map, not a literal underground corridor between planets |
| Echo Reservoir | [Detailed guide](REGIONS/RES.md) · [SVG map](MAPS/RES.svg) | Rest/workbench, water/EE separation shown | A vast, partially open cistern with transparent conduits and a towering release manifold visible from several elevations |
| Rewind Sanctuary | [Detailed guide](REGIONS/REW.md) · [SVG map](MAPS/REW.svg) | Rest, paired shield isolators | A protected relic complex at the end of the reservoir supply bridge |
| Folded Depths | [Detailed guide](REGIONS/FOL.md) · [SVG map](MAPS/FOL.svg) | Rest, ancient warning and archive return | The deepest unstable service tunnels loop under the upper sanctuary |
| Final Approach | [Detailed guide](REGIONS/FIN.md) · [SVG map](MAPS/FIN.svg) | Rest, first anchor, warning directive | Monumental converging architecture |
| Warp-Broken Gate | [Detailed guide](REGIONS/GAT.md) · [SVG map](MAPS/GAT.svg) | Fold Guardian, Last Custodian | A colossal gate at the farthest edge of the accessible sanctuary, approached through a broad containment court |

## Story and gameplay ordering
The player begins at Release Square, can explore the orphanage and town alleys, learns cooling and EE, then travels through the Wilds. At Hunter's Reach they can explore the upper canopy and ridge loop; the Warp cuts town access and opens Camp descent. They restore the Sluice, defeat Warden, explore Rootspan, power foundry, obtain survey record, align stable fold, travel across Veraya, witness the memorial, stabilize reservoir, defeat Colossus, access Keeper, acquire Rewind and train. They explore Folded Depths, align the three folds, restore the final stabilizers, defeat the Guardian, diagnose the gate, transmit the beacon and establish refuge. Main story linear milestones, traversal and optional exploration nonlinear.

## Required progression flags
| Event | Location | Prerequisite |
| --- | --- | --- |
| BRIEFED | Guild Hall | none |
| TUTORIAL_DONE | Artificer Terrace | BRIEFED |
| FIRST_RELEASE | Brook Crossing | TUTORIAL_DONE |
| WARP | Fracture Crossing | FIRST_RELEASE |
| MAP_ALIGNED | Survey Crossing | WARP |
| SLUICE_OPEN | Split Stone Regulator | MAP_ALIGNED, ROOT_VALVE, BELL_VALVE |
| WARDEN_DOWN | Bridge Warden | SLUICE_OPEN |
| WORKS_POWER | Service Relay | WARDEN_DOWN |
| ARCHIVE_ALIGNED | Survey Display | WORKS_POWER |
| VAULT_MAP | Cartographic Vault | ARCHIVE_ALIGNED |
| TOPOLOGY_ALIGNED | Three-Anchor Junction | VAULT_MAP |
| MEMORIAL_SEEN | Memory Theatre | TOPOLOGY_ALIGNED |
| RESERVOIR_STABLE | Release Manifold | MEMORIAL_SEEN |
| COLOSSUS_DOWN | Alignment Court | RESERVOIR_STABLE |
| KEEPER_EXPOSED | Vault Vestibule | COLOSSUS_DOWN |
| KEEPER_DOWN | Keeper Court | KEEPER_EXPOSED |
| REWIND_ACQUIRED | Personal Continuity Shrine | SLUICE_OPEN, VAULT_MAP, RESERVOIR_STABLE, KEEPER_DOWN |
| REWIND_TRAINED | Return-Path Terrace | REWIND_ACQUIRED |
| FOLDS_ALIGNED | Fold Junction | REWIND_TRAINED |
| ANCHORS_STABLE | Anchor Control | FOLDS_ALIGNED, STAB_A, STAB_B, STAB_C |
| GUARDIAN_DOWN | Containment Court | ANCHORS_STABLE |
| GATE_DIAGNOSED | Broken Transit Gate | GUARDIAN_DOWN |
| SIGNAL_SENT | Emergency Beacon | GATE_DIAGNOSED |

## Permanent shortcuts
| Path | From / to | Unlock | Physical reason |
| --- | --- | --- | --- |
| PATH-035 | High Spillway ↔ Split Walk | SLUICE_OPEN, SPILL_OPEN | S01 catchment ladder and service ledge; separate deck above ridge viaduct |
| PATH-040 | Underroot Culvert ↔ Split Stone Regulator | GARDEN_RESTORED, WARDEN_DOWN | S02 service tunnel, safe bilateral return |
| PATH-049 | Storage Loft ↔ Great Root Canopy | LOFT_RELAY, WARDEN_DOWN | S03 maintenance rail over root terrace |
| PATH-062 | Unmapped Loop ↔ Research Gallery | LOOP_MARKED, TOPOLOGY_ALIGNED | S04 Warp throat B after both anchor checks |
| PATH-078 | Overflow Alcove ↔ Broken Promenade | RESERVOIR_STABLE, OVERFLOW_ISOLATED | S05 long maintenance return shaft along basin rim |
| PATH-086 | History Landing ↔ Sealed Shelf | REWIND_TRAINED, SHELF_OPEN, ARCHIVE_RETURN | S06 deep maintenance lift, separate shaft; shelf-side latch reachable after main route |
| PATH-088 | One-Way Gallery ↔ Service Alcove | REWIND_TRAINED, REWIND_RETURN | S07 dormant paired maintenance fold unlocked by M16, not arbitrary teleport |

## Save points, service and story closure
| Rest station | Coordinates | Service |
| --- | --- | --- |
| Trailhead Shelter | (33,17) | Rest |
| Camp Shelter | (110,33) | Rest |
| Conduit Entry | (28,31) | Rest |
| Root Bridge | (42,48) | Rest |
| Workshop | (84,54) | Rest + workbench |
| Archive Steps | (34,62) | Rest |
| Fracture Landing | (43,79) | Rest |
| Foreign Atrium | (86,73) | Rest |
| Flow Deck | (42,101) | Rest + workbench |
| Vault Vestibule | (88,104) | Rest |
| History Landing | (38,116) | Rest |
| Stabilizer Walk | (48,135) | Rest |
| Last Rest | (84,131) | Rest + workbench |
| Refuge Terrace | (105,142) | Rest + workbench |

## Major puzzles
| ID | Placement | Exact solution | Permanent consequence |
| --- | --- | --- | --- |
| P01 | Split Stone Regulator | Operate Root Arch Valve, then Bell Feeder Valve, then Split Stone Regulator. Press commit. If order is wrong clear only the local command buffer; valves remain physically accessible. | Raises bridge to Warden; local spillway can later be unlocked by M05; water reaches main channels. |
| P02 | Survey Crossing | Align bell west-northwest, Split Rock east-northeast, Camp Arch at origin; confirm maintenance link to Echo Sluice. | Reveals the westbound upper service ridge; mismatch highlights the incorrect landmark. Compass directions supersede old V3 positions. |
| P03 | Service Relay | Connect source to service relay, relay to receiver; leave dead archive branch isolated. | Door opens to REL03; disconnected receiver icon or overload alarm on mistake. |
| P04 | Survey Display | Receiver → Archive → Anchor. | Access SUR03; incorrect order resets plates; critical map automatically recorded on entry. |
| P05 | Three-Anchor Junction | Select continuously pulsing matched diamond; wrong anchor mouths loop to the same junction. No shortcuts to Veraya before TOPOLOGY_ALIGNED. | WAR03 opens; wrong doors loop safely to WAR02 with mismatched landmark feedback. |
| P06 | Release Manifold | Vault power ON, Release ON, Full storage OFF. | Reservoir stabilizes, local fauna reduced, arena accessible; full storage alarms, no fatal penalty. |
| P07 | Vault Vestibule | Disable left and right isolators; lock offline for encounter. | Arena opens and core shield windows become available; wrong panel harmless feedback. |
| P08 | Personal Continuity Shrine | Set Sluice=Flow, Survey=Archive, Reservoir=Release; confirm when all three prior flags true. | Relic installed, save immediately; missing inputs identify exact system. Keeper already defeated. |
| P09 | Return-Path Terrace | Charge ≥25 EE, walk from pad through shutter to switch within 4 s, activate, press F to rewind to pad. | World switch remains active; next door opens. Reset button restores shutter and gives EE, no progress loss. |
| P10 | Fold Junction | Connect diamond A to A, split diamond B to B, ring C to C; follow resulting maintenance corridor. | FIN01 accessible; wrong pair gives local mismatch. No extra powers. |
| P11 | Anchor Control | Activate A/B/C in any order, open release line, energize receiver at Anchor Control. | Final approach becomes stable. The physically broken transit interface remains broken. |
| P12 | Emergency Beacon | Isolate transit load, connect reserve source to beacon receiver, confirm distress packet. | Signal sent, refuge unlocked; invalid routing shows broken-interface warning. No player EE cost or gate repair. |

## Map layer instructions
Player map should reveal only traversed geography, known passages and explicitly observed landmarks. On discovery draw the terrain footprint/route silhouette, not schematic region boxes. The historical layer records pre-Warp Eldara survey and previous routes; current layer records merged connections. Use violet paired-mouth fold glyphs, red cut line at town, visible icon when a locked door has been inspected. The full technical map is developer-only and should not reveal all secrets to the player. Unknown regions appear as fog/blank; annotations add flavor, not required progress.

## Art and implementation handoff
Read [CONSTRUCTION_STANDARDS](CONSTRUCTION_STANDARDS.md) before painting. Use [DATA/world.json](DATA/world.json) for anchor/route flags and [DATA/routes.csv](DATA/routes.csv) for exact endpoints. Use individual region SVGs in an editor as reference; draw irregular terrain with the provided geometry standards. Validate continuous navigation and transitions before art. The old V3 .tmj layouts are historical only. Do not import them as levels.
