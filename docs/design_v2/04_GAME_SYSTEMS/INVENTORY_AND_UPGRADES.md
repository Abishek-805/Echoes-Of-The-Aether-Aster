# Inventory, equipment upgrades and economy

**Version:** 2.0 | **Date:** 2026-11-27 | **Status:** Approved V2 direction; implementation details are working specifications

Inventory categories: equipped primary, discovered primary alternatives, always-equipped blade, Collector, Rewind (locked until relic), healing charges, materials, blueprints, quest items, archives/map records. Guild Marks separate, no Echo inventory or ammo. Unique items cannot be discarded/sold. Workbenches TOW04, REL01, RES01, FIN03, GAT04. Rest stations allow swapping primary; workbench applies blueprints. No random upgrade rolls. Upgrade values tuning seeds.

| Blueprint | Room | Upgrade | Cost (alloy/biological/relic) | Effect |
|---|---|---|---|---|
| BP01 | OUT04 | Heat sink | 4/0/0 | +15% cooling for equipped human ranged weapon |
| BP02 | SLU04 | Reinforced vest | 3/3/0 | -10% incoming damage, floor 1 |
| BP03 | REL04 | Focusing lens | 5/0/1 | +15% ranged damage rounded |
| BP04 | VER04 | Insulated grip | 4/0/1 | -10% heat per shot rounded |
| BP05 | RES04 | Energy cell extension | 3/0/2 | +20 EE cap, once |
| BP06 | FIN04 | Rewind efficiency module | 2/0/3 | cost 25→22 EE, cooldown 14→12s; no duration change |

Each blueprint upgrade crafted once, global gear modifier where applicable. HP01–04 each +10 max HP and +10 current HP (max140); optional, no stat gate. B01 alloy x4; B02 alloy x4; B03 relic x2; B04 relic x1; B05 relic x2. Ordinary enemies yield one material of listed class (elite variants two), fixed reward caches supply additional alloy/biological/relic. No mandatory upgrade purchase or grinding. Guild Marks 60 at start; town optional bandage pouch 30 (one heal supply at rest, not fourth permanent charge), alloy pack 20 (alloy x3), map annotation 10 (optional label). After Warp Marks cannot be spent; no required town return. Critical items are journaled and never consumed by optional systems. Workbench UI shows compare before/after, exact cost and insufficient resources; transaction atomic, no refund duplication. Save stores owned weapons, upgrade IDs, counts, quest flags and healing charges; inventory sorted by category.
