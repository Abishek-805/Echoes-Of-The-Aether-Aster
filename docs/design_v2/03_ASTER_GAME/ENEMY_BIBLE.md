# Enemy bible — eight archetypes and four variants

**Version:** 2.0 | **Date:** 2026-11-27 | **Status:** Approved V2 direction; implementation details are working specifications

HP, damage per main strike, EE yield and timings are tuning seeds. EE yield is energy obtained by release of bound unconsumed Echoes, or explicitly marked residual energy; never the creation of genuine Echoes. Typical non-boss rooms use 1–3 enemies. Do not spawn enemies inside protected rest alcoves (rooms may contain a separately bounded combat area), mandatory safe tutorial paths or the Silent Gallery memory theatre. A creature with no bound Echo yields materials only. First Forager is a guaranteed release tutorial.

| ID | Archetype | Origin | HP | Damage | EE | Material class | Encounter rooms | Behavior / counterplay |
|---|---|---|---:|---:|---:|---|---|---|
| E01 | Echo Forager | Echo-adapted fauna | 45 | 12 | 8 | Biological | OUT02 HUN01 ROT02 | Crouch/glow → lunge last seen pos → 0.8s recover; dodge or jump. |
| E02 | Stonebound Guard | Construct | 85 | 18 | 12 | Alloy | REL02 REL03 SUR01 | Raised arm, frontal guard; flank during 1.1s sweep recovery. |
| E03 | Rift Skitter | Warp-touched fauna | 38 | 10 | 7 | Biological | WAR01 WAR03 FOL01 | Marked crack, audible click, leap, retreat; no off-screen attack. |
| E04 | Prism Turret | Construct | 55 | 14 | 10 | Alloy | SUR01 SUR02 REL04 | Painted beam line locks before firing; cover, jump or flank. |
| E05 | Veraya Sentinel | Construct | 100 | 20 | 14 | Alloy | VER01 VER03 RES01 | Shield pulse then committed charge, vulnerable in recovery. |
| E06 | Mithril Keeper | Construct | 135 | 22 | 18 | Relic | REW01 FIN01 | Plating opens during cooldown; attack exposed core. |
| E07 | Echo Leech | Echo-adapted fauna | 30 | 8 | 6 | Biological | RES01 RES02 SIL03 | Drifts toward exposed source; drain hazard telegraphed, interrupt with blade. Fewer after P06. |
| E08 | Fold Stalker | Warp-touched predator | 115 | 20 | 16 | Biological | FOL02 FOL03 FIN02 | Spatial marker then attack from corresponding fold; evade before strike. |

| ID | Variant | Base | HP | Damage | EE | Room | Difference |
|---|---|---|---:|---:|---:|---|---|
| V01 | Metalbound Guard | E02 | 110 | 20 | 14 | REL03 | More frontal armor, longer recovery; not a new mechanic |
| V02 | Saturated Forager | E01 | 65 | 15 | 11 | HUN03 WAR01 | Two lunges with separate tells |
| V03 | Prism Array | E04 | 75 | 16 | 12 | VER04 FIN04 | Two sequential marked beams |
| V04 | Voruun Scout | E08 | 125 | 22 | 10 | FOL04 | Rare displaced consumer; drops only residual EE or unconsumed bound Echoes |

## Shared AI contract
Patrol → Notice (line of sight/hearing, not through walls) → Approach → Telegraph → Attack → Recovery → Patrol. If target lost: Search last seen position up to 3s, then return. Guard, Stagger and Defeated are additional states. Prototype ranges: sight 240 px, hearing 100 px, leash 400 px at 1x logical render; enemy-specific tuning allowed. Telegraph locks attack direction when defined. No damage outside active hit window or from unmarked off-screen space. Contact damage only when explicitly an attack. Stagger 0.2s ordinary; bosses ignore routine stagger except authored vulnerability. Room unloading resets transient AI but not persistent boss states. Defeat atomically creates reward token(s); repeat ordinary encounters after rest are gameplay abstractions. Reward tokens cannot be collected twice in one encounter cycle. P06 switches encounter variant to lower-density leeches. [Ecology](../01_WORLD_BUILDING/CREATURE_ECOLOGY.md).
