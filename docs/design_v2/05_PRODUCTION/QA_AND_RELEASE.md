# QA and release acceptance matrix

**Version:** 2.0 | **Date:** 2026-11-27 | **Status:** Approved V2 direction; implementation details are working specifications

Documentation is not a shipped game. Tests below are executable acceptance criteria for future implementation; package-level validation only covers structure and references. Severity: P0 crash/data loss/softlock; P1 critical progression, exploit or unreadable mandatory attack; P2 cosmetic or minor UX. P0/P1 must be fixed before release.

| Test ID | Scenario | Pass condition |
|---|---|---|
| QA01 | New game, skip cinematics | Same critical flags and records as watching; no Rewind before REW03 |
| QA02 | Hold rifle trigger with EE | Heat hits 100, firing locks until ≤35; auto cooling; no reload UI |
| QA03 | Burst fire, wait, switch weapon at rest | Per-weapon heat tracked; no combat swap exploit |
| QA04 | Empty EE | Shot rejected without heat/debit; blade/dodge work; minimum energy rest |
| QA05 | Collect bound Echo via interact or drop | Safe release once, EE credit once, no Echo inventory |
| QA06 | Full cell, two simultaneous pickups | Echoes released, overflow dissipates, no duplicate credit |
| QA07 | Kill consumer, collect residual energy | Does not restore destroyed Echoes; correct source type |
| QA08 | Rewind before acquisition | Control hidden/disabled, no activation |
| QA09 | Rewind with enemy damaged, switch activated | Position personal only; enemy and switch unchanged |
| QA10 | Rewind after firing/healing/pickup | EE, weapon heat, cooldown, charges, loot not rolled back |
| QA11 | Rewind after 40 recent damage | Restore up to 20 eligible HP once; no duplicate recovery |
| QA12 | Invalid snapshot, wall, occupied target, room transition | Valid fallback or no charge; no arbitrary wall bypass |
| QA13 | Death, pause, load | No resurrection, no paused history, fresh history on load |
| QA14 | P01 wrong sequence then correct | Local feedback; bridge opens and loop accessible |
| QA15 | Every P02–P12 from fresh state | Exact solution works; hints accessible; no hidden optional item |
| QA16 | Warp closes town | Town inaccessible; all other regions reachable; town records retained |
| QA17 | Mandatory path with no optional items/upgrades | Complete through distress; no resource softlock |
| QA18 | Boss retries/defeat/save/reentry | Encounter reset if failed; unique reward and flag durable on victory |
| QA19 | All 56 collectibles, optional bosses | All accessible in valid timeline, no town turn-in after Warp |
| QA20 | Gate inspection | Physically broken, cannot be opened; distress only, clear objective |
| QA21 | End/continue/replay credits | END_COMPLETE durable; no escape; load safe post-guardian snapshot |
| QA22 | Corrupt save or interruption | Backup recovery and clear error; no overwriting both copies |
| QA23 | Controller only / remapped keys | All gameplay and menus work; no conflict or stale prompt |
| QA24 | Color-blind/reduced flash/audio muted | Threats and puzzles readable without color/audio alone |
| QA25 | Long exploration, many particles | Stable frame rate on target system; bounded memory/timers |
| QA26 | Fresh install/offline | Starts, saves, loads, exits; credits and asset licenses present |

Test boundaries: zero EE, full EE, heat 74/75/99/100/35, death at activation, reload of saved game (not weapon action), simultaneous pickup and damage, room-transition race, last-frame shutter, boss phase overlap. Test default and assist mode. Record actual measured time, hardware, build commit, pass/fail and reproduction steps. Release checklist: signed-off story and mechanics, no missing files, complete credits, executable build, clean save slots, settings, end credits, controller support, crash/error logs, licenses. No claim of passing these runtime tests until game exists.
