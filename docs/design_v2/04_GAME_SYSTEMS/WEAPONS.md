# Weapon catalogue and overheat specification

**Version:** 2.0 | **Date:** 2026-11-27 | **Status:** Approved V2 direction; implementation details are working specifications

All ranged weapons are energy-based, use stored EE and dissipate heat automatically. No reload, magazines, ammunition, ammo pickups, shell ejection or magazine animation. Starting Hunter Rifle = legacy Expedition Rifle. Blade = Combat Knife, utility melee. One primary equipped, alternates swapped at rest stations; per-weapon thermal state persists during swap. No mid-fight weapon-switch exploit. Values are tunable seeds.

| ID | Weapon | Unlock | Damage | EE/shot | Heat/shot | Min shot interval | Cooling rate | Role |
|---|---|---|---:|---:|---:|---:|---:|---|
| RIF01 | Hunter Rifle | Starting | 12 | 2 | 13 | 0.25s | 25/s | Reliable medium range |
| WPN01 | Scatter Carbine | REL04 | 6×4 pellets (24 max) | 4 | 24 | 0.55s | 30/s | Close burst, spread |
| WPN02 | Precision Rifle | VER04 | 32 | 5 | 30 | 0.85s | 22/s | Slow accurate long range |
| WPN03 | Vaelari Resonator | FIN04 | 16 | 2 | 10 | 0.35s | 27/s | Efficient heat, ancient design (major efficiency advances in III) |
| BLD01 | Combat Blade | Starting | 18 | 0 | 0 | 0.50s full cycle | — | Close range fallback |

## Shared thermal model
Heat range 0–100, warm ≥75, overheated at 100, locked until ≤35. 0.5s delay after last accepted shot before passive cooling. Firing while locked does not add heat or delay cooling. Example continuous starting rifle: 8 accepted shots reach 100 (7×13=91 then eighth clamps 100); cools to 35 after 0.5+65/25=3.1 seconds if no other effect. This is thermal behavior, **not an eight-shot magazine**; burst spacing can allow indefinite firing subject to EE. No reload input or animation. Each shot accepted only if fire interval, heat lock, alive state and EE valid. UI shows heat percentage, overheat icon, current EE; cooling sound and vents. Blade has no heat. Rest cools all weapons to zero.

Upgrades: heat sink increases cooling 15%; focusing lens raises rifle damage 15% rounded; insulated grip reduces heat per shot by 10% rounded; ancient resonator is a complete optional weapon, not a separate special ability. Apply upgrades only at workbench; no duplicate stacking. Weapons remain viable without upgrades; mandatory boss telegraphs and vulnerability windows permit alternate blade attacks while cooling. Design projectile hitboxes, falloff/spread and VFX as data Resources, not hard-coded per scene. No real-world weapon models or ammunition details.
