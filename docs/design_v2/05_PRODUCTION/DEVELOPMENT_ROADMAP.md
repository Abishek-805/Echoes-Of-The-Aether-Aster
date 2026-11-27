# Development roadmap and scope gates

**Version:** 2.0 | **Date:** 2026-11-27 | **Status:** Approved V2 direction; implementation details are working specifications

No calendar promises without team and measured velocity. Target main route 8h plus ~2h optional; 64 authored rooms, 6 art families, 16 regions, 4 required/2 optional bosses. Milestones are exit criteria, not dates. Implement in Godot with graybox first, then final art. Main route always has priority over optional branches.

| Milestone | Deliverable | Exit criteria |
|---|---|---|
| M0 Design lock | Current V2 canon, data manifests, heat/EE specification | IDs and flags verified; no story conflict |
| M1 Player sandbox | Movement, camera, collision, controls, blade and energy rifle | Responsive controls, heat lock/cool, no resource exploit |
| M2 Combat and Collector | Forager AI, drop/interaction, safe release, stored EE, HP | One release token once, zero-EE fallback, readable tells |
| M3 Connected vertical slice | Town→outer loop→Sluice→Warden, room/map/save | Playable mini-story; pause/load/retry; stable loop |
| M4 Rewind prototype | 6s snapshots, P09 and test arena | World unchanged, safe shutter traversal, no EE/heat/loot duplication |
| M5 Full graybox | All 64 rooms, critical flags, 4 bosses, chapter events | Start to END_COMPLETE without debug or optional items |
| M6 Optional and narrative | 2 optional bosses, 7 side stories, 56 collectible IDs, dialogue | Full completion possible after Warp; no optional dependencies |
| M7 Art/audio/UI | Final assets, effects, accessibility, localization ready | Visual and audio clarity; no missing assets on main route |
| M8 QA/balance | Difficulty, performance, save migration, bug triage | Critical/high bugs closed, regression passes, measured playtime |
| M9 Release | Desktop builds, credits/licenses, settings, distribution | Clean install and full end-to-end test on reference devices |

Pacing test original accepted 2h45/2h45/2h30; revised target 2h15/2h15/3h30 for midpoint relic and mastery. Measure and adjust rooms, not pad with repeated traversal. Build one weapon and one enemy before variations; prototype Rewind early even though acquired later. Never implement co-op networking in I. II and III detailed production only after I's core is stable; architecture remains reusable without promising multiplayer readiness.
