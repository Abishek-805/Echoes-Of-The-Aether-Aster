# Package validation report

**Version:** 2.0 | **Date:** 2026-11-27 | **Status:** Static validation passed; runtime tests not run

This validation is static, not a gameplay simulation. Original archive files preserved byte-for-byte; legacy links and conflicting historical wording are intentionally not edited. Active V2 supersedes them.

| Check | Result |
|---|---|
| Uploaded original source copies | 10/10 byte-identical |
| Room manifest | 64 unique IDs, 16 regions, 6 biome families |
| Graph endpoints | All room IDs resolve |
| Critical path | Walked intended 51-room route against prerequisite flags, END_COMPLETE reached without optional flag |
| Endgame reachability | 60/64 rooms reachable from refuge; only 4 town rooms sealed by Warp as intended |
| Puzzle coverage | 12 required, 16 smaller challenges |
| Creature coverage | 8 enemy bases + 4 variants, 4 required + 2 optional bosses |
| Collectibles | 56 unique IDs; explicit room placements |
| Relative active Markdown links | Resolved (archive historical links excluded) |
| Authority | New heat/EE rules override legacy reload/Collector and ability timing |

No Godot scenes, scripts, art, actual timing tests or build were requested/created. Runtime QA matrix remains unexecuted. Numerical combat/thermal values and authored geometry require playtesting. Future games have continuity outlines rather than full level manifests. Story mysteries explicitly marked open. Review the [decision register](../00_MASTER_CANON/CANON_DECISIONS.md) before implementation.
