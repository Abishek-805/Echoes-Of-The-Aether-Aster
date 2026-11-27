# Puzzle bible — 12 major sequences and 16 smaller challenges

**Version:** 2.0 | **Date:** 2026-11-27 | **Status:** Approved V2 direction; implementation details are working specifications

Rules: teach in safe context, combine only learned rules, make every critical clue inspectable and journaled, give specific feedback. Three hint stages: landmark nudge → rule reminder → explicit answer (on request; no achievement penalty). Wrong answers reset only local mechanism; no long walk or irreversible resource cost. P09 and M14/M16 use same-room authored Rewind-passable shutters; all other collision remains solid. Critical EE terminals guarantee an attempt and retry. No random passwords or outside trivia.

## Required puzzles
| ID | Room | Result flag | Goal and clues | Exact solution | Result / recovery |
|---|---|---|---|---|---|
| P01 | SLU02 | SLUICE_OPEN | Restore bridge. Damaged plinth: center conductor last; relief: Root Arch before Hanging Bell; pulse confirms. | Root Arch → Hanging Bell → Split Stone (center). | Bridge lifts, opens Warden route and HUN shortcut; wrong order resets local sequence and highlights last invalid conductor. |
| P02 | CAM03 | MAP_ALIGNED | Align Dawn map with bell, split rock and camp arch; bell visible from OUT03; sketch in CAM02. | Pin bell to east, rock to west, arch to camp origin; accept maintenance link to SLU01. | Map route appears; wrong alignment shows landmark mismatch. |
| P03 | REL02 | WORKS_POWER | Power maintenance receiver. Wall flow diagram and arrows show source→relay→receiver; blocked archive branch. | Connect source to service relay, relay to receiver; leave dead archive branch isolated. | Door opens to REL03; disconnected receiver icon or overload alarm on mistake. |
| P04 | SUR02 | ARCHIVE_ALIGNED | Identify survey archive. Three plates show receiver, archive, anchor symbols; service note requires power before record before route. | Receiver → Archive → Anchor. | Access SUR03; incorrect order resets plates; critical map automatically recorded on entry. |
| P05 | WAR02 | TOPOLOGY_ALIGNED | Historical map shows three doors; two unstable anchors pulse irregularly. Current landmarks and anchor shape match stable route. | Choose paired diamond anchor with continuous pulse (middle door in initial layout). | WAR03 opens; wrong doors loop safely to WAR02 with mismatched landmark feedback. |
| P06 | RES02 | RESERVOIR_STABLE | Power vault and preserve safe release. Source feeds three toggles; storage indicator full. | Vault power ON, Release ON, Full storage OFF. | Reservoir stabilizes, local fauna reduced, arena accessible; full storage alarms, no fatal penalty. |
| P07 | REW01 | KEEPER_EXPOSED | Keeper shield fed by paired conductors; diagram marks maintenance isolators. | Disable left and right isolators; lock offline for encounter. | Arena opens and core shield windows become available; wrong panel harmless feedback. |
| P08 | REW03 | REWIND_ACQUIRED | Relic vault requires verified Sluice flow, Survey archive and Reservoir release. Three indicators and symbols correspond to earlier systems. | Set Sluice=Flow, Survey=Archive, Reservoir=Release; confirm when all three prior flags true. | Relic installed, save immediately; missing inputs identify exact system. Keeper already defeated. |
| P09 | REW04 | REWIND_TRAINED | Safe tutorial: return from one-way switch to starting pad after shutter closes. Ghost trail and prompt show personal path. | Charge ≥25 EE, walk from pad through shutter to switch within 4 s, activate, press F to rewind to pad. | World switch remains active; next door opens. Reset button restores shutter and gives EE, no progress loss. |
| P10 | FOL03 | FOLDS_ALIGNED | Reconstruct local connections. Three anchor panels show matching geometric halves and stable pulses. | Connect diamond A to A, split diamond B to B, ring C to C; follow resulting maintenance corridor. | FIN01 accessible; wrong pair gives local mismatch. No extra powers. |
| P11 | FIN02 | ANCHORS_STABLE | Three local stabilizers in FIN01 accessible from walk; warning: keep release path open before powering transit. | Activate three stabilizers (any order), open release line, then receiver at FIN02. | Stable approach, boss access; missing stabilizer shows numbered indicator. Physical final gate remains broken. |
| P12 | GAT03 | SIGNAL_SENT | Power separate diagnostic channel after guardian defeated and gate inspected. Reserve source can route to broken transit or beacon. | Isolate transit load, connect reserve source to beacon receiver, confirm distress packet. | Signal sent, refuge unlocked; invalid routing shows broken-interface warning. No player EE cost or gate repair. |

## Small environmental puzzles
| ID | Room | Solution / action | Reward or state |
|---|---|---|---|
| M01 | TOW04 | Practice cooling: release trigger until heat below safe line | basic tutorial completion, no reward lock |
| M02 | OUT04 | Match Source sign to receiver to open cache | MAP01, BP01 |
| M03 | HUN04 | Follow three hunter tags to find blind | DAWN02, MAP02 |
| M04 | CAM04 | Align torn map to bell silhouette | DAWN04, MAP03 |
| M05 | SLU04 | Open spillway valve after P01 | DAWN05, BP02 |
| M06 | ROT03 | Route water from restored sluice to garden | GARDEN_RESTORED, HP01, MEM02 |
| M07 | ROT04 | Activate hollow marker after Warden, defeat Titan | MAP04, alloy |
| M08 | REL04 | Connect loft relay to receiver, inspect cache | LOFT_RELAY, HP02, BP03, WPN01 |
| M09 | SUR04 | Read archive symbols to unlock shelf cache | lore and late return path |
| M10 | WAR04 | Trace matching anchor pairs | LOOP_MARKED, MAP05, MEM04 |
| M11 | VER04 | Align diagnostic display with source/receiver | BP04, WPN02; part reference only |
| M12 | SIL04 | Match memorial name to recorded imprint | MEM03, AR16 |
| M13 | RES04 | Isolate overflow line after P06 | HP03, BP05 |
| M14 | FOL04 | Rewind from safe ledge to latch; optional boss | HP04, MAP06, MEM05 |
| M15 | FIN04 | Align service conduit to receiver | BP06, WPN03 |
| M16 | FOL02 | Rewind through authored shutter to optional return switch | REWIND_RETURN_OPEN; shortcut to VER04 |

M01 is a guided practice, not a difficulty gate. M02–M16 are optional; any reward behind a minor puzzle is local and not needed for the main story. P01–P08 use only baseline movement/interaction, P09 introduces Rewind, P10–P12 combine learned rules. M14/16 become available only after acquisition. Wrong attempts preserve known clues; resets never undo permanent success. Accessibility: non-color symbols, replayable pulses, readable text, hold/toggle options and adjustable timing for Rewind practice.
