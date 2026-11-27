# Canon decisions and conflict resolution

**Version:** 2.0 | **Date:** 2026-11-27 | **Status:** Approved V2 direction; implementation details are working specifications

| ID | Approved decision | Governs |
|---|---|---|
| D01 | Three games: Aster solo, Orion solo, Lost Echoes co-op | All scope |
| D02 | Aster orphan/experienced hunter; Gold rank, 24–27 range; self-reliant flaw | Character and story |
| D03 | Vaelari, Voruun, Convergence Project, Great Fracture, Resonance Sanctuaries | Lore names |
| D04 | Aster only Rewind, obtained Ch2 end; Orion Intel acquired II; Relay III | Ability gating |
| D05 | Weapon overheat only; no ammunition, magazines, reload input, reload animation, shell ejection, or ammo drops | Combat, HUD, animation, saves, QA |
| D06 | Collector releases Echoes on interaction/collection; stores released Echo Energy; Echo proceeds to Aether | Resource system |
| D07 | Defeats Fold Guardian; physical gate damage; distress call and refuge; no escape in I | Ending |
| D08 | Orion follows signal, gets trapped in secondary Warp, repairs interface with replacement and Aster's aid | II continuity |
| D09 | Nalora ship escape, restore release system, halt failed collection, single canonical ending | III continuity |
| D10 | Authored world topology, six symbols, four required bosses, two optional, no grinding | I design |
| D11 | All previous V2 suggestions accepted except explicit heat/energy corrections; prototype numbers adjustable | All specs |

## Reconciliations
- Old character docs have reload animation entries despite heat-based rifle description. D05 supersedes them. Expedition Rifle and Hunter Rifle are same starting model; Combat Knife and Combat Blade refer to same core utility blade. Orion is an inventor of an expedition rifle in legacy material; his personal involvement with Aster's starting rifle is not assumed before they meet. The later jointly used expedition design may be his.
- Legacy Collector temporarily stores Echoes; D06 requires immediate safe release, persistent storage only of EE. Legacy “Echo cost” means EE cost when applied to gear. Rewind is not present before acquisition; right forearm mount exists as inert ordinary equipment beforehand. Same timing rule for Intel in II.
- Old co-op ability timing and travel story are historical only. Legacy detailed Relay and smoke support are possible references for III, not active in I.
- Accepted pacing estimate was 2h45 + 2h45 + 2h30 = 8h, plus 2h optional. For Rewind to feel near midpoint, test a 2h15 + 2h15 + 3h30 split while retaining 8h core; do not pad or shorten plot. This adjustment is a working production choice, not a new canon event.
- Gate damage means the local interface to a remote anchor is physically broken; the remote endpoint survives. Orion brings the part from a trapped annex. No active gate network from outside is accessible to Aster. The emergency signal can travel through a separate low-power diagnostic channel, not people.

## Status discipline
Approved narrative and named entities are current canon. Newly elaborated room IDs, complete puzzle rules, scripts, stat tables, thermal values, art dimensions and QA acceptance tests are implementation candidates to validate. The creator can change any detail. Intentionally open: consciousness after death, absolute dates, exact ages within ranges, Voruun homeworld, surviving Vaelari, later game detailed levels. Do not invent fixes silently; update this register and affected documents together.
