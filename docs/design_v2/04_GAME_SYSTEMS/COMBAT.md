# Combat, damage and thermal rules

**Version:** 2.0 | **Date:** 2026-11-27 | **Status:** Approved V2 direction; implementation details are working specifications

Aster is already trained. Combat is readable, spacing-based and combines rifle, blade, dodge and later Rewind. **Weapons do not reload. There is no ammunition or magazine system.** Energy-powered ranged weapons draw stored EE per shot and accumulate heat; weapon heat is the sole firing-cycle limiter, independent of available EE. Heat cools automatically, never via a reload animation. Melee costs no EE and cannot overheat.

## Prototype combat
100 HP, 100 EE capacity, 3 healing charges restoring 30 HP each; starting rifle 12 damage, blade 18. Hurt invulnerability 0.6s, dodge i-frames 0.15s; hitboxes enabled only during active frames; per attack per target once unless explicitly multi-hit. Defense modifies damage with minimum 1; no random critical hits. Heal 0.8s commitment, interrupted before completion without consuming charge; after commit no undo. At 0 HP death state locks input and reloads checkpoint, not in-world resurrection. No free HP from Rewind beyond defined half recovery. [Weapon details](WEAPONS.md).

## Shared heat state machine
Ready (heat <75) → Warm (≥75 and <100) → Overheated (heat ≥100) → Cooling lockout until ≤35 → Ready. A valid shot at heat below 100 can reach 100, then locks next shots. No shot, EE debit or damage if overheated, insufficient energy, dead, rewinding or fire cooldown active. Add heat and debit EE in same accepted shot transaction. Passive cooling after 0.5s since last valid shot; 25 heat/s baseline rifle. Cooling continues while trigger is held and locked, while using blade or while stored; no cooldown exploit by switching weapons or Rewind. Each weapon tracks heat independently. No manual vent/reload. Warm threshold amber icon + pulsing vent, overheat warning red striped gauge + hiss; cooling resumes automatically. Weapon heat is distinct from Rewind cooldown and energy level.

## Attack timing baseline
Rifle 0.25s interval, blade 0.12s anticipation/0.10s active/0.28s recovery; blade can be used when gun overheats or EE empty. Aster can dodge from recovery, not cancel a committed shot's resource cost. Aim direction locks at attack activation. Enemy damage and telegraphs see [enemy bible](../03_ASTER_GAME/ENEMY_BIBLE.md). Bosses test timing, not resource farming. Damage flashes and sound supplement visuals; screen shake optional. No unavoidable attacks; mandatory fights beatable with starting gear and zero optional upgrades.
