# Quest, progression and persistent flags

**Version:** 2.0 | **Date:** 2026-11-27 | **Status:** Approved V2 direction; implementation details are working specifications

No XP grinding or hunter rank ladder. Main story tracks objective, current chapter and permanent flags; optional knowledge/loot rewards skill and exploration. One required route with loops; no hidden optional requirement. All flags default false, set once by named source. See [world map](../03_ASTER_GAME/WORLD_MAP.md), [puzzle bible](../03_ASTER_GAME/PUZZLE_BIBLE.md), [boss bible](../03_ASTER_GAME/BOSS_BIBLE.md).

| Objective | Trigger | Completion flag | Next objective |
|---|---|---|---|
| Q01 Hear rumor | New game | BRIEFED (TOW03) | Prepare with Bram |
| Q02 Prepare / first Echo | TOW04 | TUTORIAL_DONE; FIRST_RELEASE (OUT02) | Survey route |
| Q03 Find alternate exit | HUN03 with FIRST_RELEASE | WARP | Camp / map / Sluice |
| Q04 Find relic route | CAM01 | VAULT_MAP (SUR03 after P02/P01/B01/P03/P04) | Warped Verge |
| Q05 Follow foreign connection | WAR01 | MEMORIAL_SEEN (SIL03 after P05 and scene) | Reservoir |
| Q06 Recover relic | RES01 | REWIND_ACQUIRED (P06/B03/P07/B04/P08) | Rewind tutorial |
| Q07 Find emergency gate | REW04 | ANCHORS_STABLE (P09/P10/P11) | Final guardian |
| Q08 Survive guardian | GAT01 | GUARDIAN_DOWN (B06) | Inspect gate |
| Q09 Send distress | GAT02 | GATE_DIAGNOSED; SIGNAL_SENT (P12) | Refuge |
| Q10 End | GAT04 | END_COMPLETE | Credits/post-credits |

Optional flags: TITAN_DOWN, DEVOURER_DOWN, GARDEN_RESTORED, LOFT_RELAY, LOOP_MARKED, REWIND_RETURN_OPEN; side story IDs and unique collectible flags. P04 ARCHIVE_ALIGNED unlocks SUR03; VAULT_MAP is separate on inspection. P08 only accepts Sluice, archive and Reservoir state and Keeper defeat. P10 requires Rewind tutorial. Every milestone save commits all prerequisite flags together. WARP closes TOW04–OUT01 in both directions, but town critical records are auto-retained. END_COMPLETE never sets escape flag; no gate opening in I. New game resets flags and map. Chapter labels derive from VAULT_MAP and REWIND_ACQUIRED. Journal tracks objective and clue history, not a list of generic tasks.
