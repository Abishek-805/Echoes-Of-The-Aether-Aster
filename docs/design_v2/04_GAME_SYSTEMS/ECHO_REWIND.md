# Echo Rewind — complete gameplay contract

**Version:** 2.0 | **Date:** 2026-11-27 | **Status:** Approved V2 direction; implementation details are working specifications

Aster's only special ability, ancient Personal Continuity Device, acquired permanently at REW03 (Ch2 end); tutorial REW04. Right forearm device, fist-clench, cyan pulse, afterimages along actual path. Not free teleportation, resurrection, world rewind or gate repair.

| Parameter | Prototype value |
|---|---|
| History | 6 seconds, 360 physics snapshots at 60 Hz |
| Cost | 25 EE, charged once on validated activation |
| Cooldown | 14s after playback ends; persists through room transitions |
| Playback | Up to 0.75s real simulation time |
| Health recovery | Up to half recent eligible combat damage, capped by old HP and max HP |
| Destination | Oldest safe valid same-room snapshot up to 6s; prefer earlier valid point, no arbitrary coordinates |

## State table
Rewind: position, velocity clamped, facing, movement state where safe, selected temporary status durations, eligible recent health loss (partial). Preserve: weapon heat, fire timers, EE, Rewind cooldown, healing charges, inventory, upgrades, quest flags, enemy HP/AI/timers, world switches, loot, room topology, death. World continues during playback. While rewinding Aster cannot attack, collect or interact; brief playback collision handling avoids damage from swept path, no post-playback invulnerability beyond normal dodge rules. If destination becomes unsafe during playback, choose nearest safe validated snapshot along trajectory; if none, return to safe activation origin and refund once. No arbitrary wall crossing; only explicitly tagged Rewind-passable shutters traversed in recorded path can be bypassed while closed. Ordinary walls cannot be crossed. Snapshot room ID and topology version validated; hard transition clears history (authored shortcuts use same-room shutters then separate room edges). Pause records nothing.

## Health ledger
Example 100 HP -> 60 after 40 damage; rewind to snapshot before hit restores 20 to 80. For each eligible damage event in chosen time interval, mark it consumed on successful recovery; cap gain by max(0, snapshot HP-current HP) and half unused damage, rounded down. Do not undo heals or costs, never decrease HP from a rewind. Clear ledger on death/load/rest; only live combat damage is eligible. No repeated recovery from the same hit. Status rewind cannot restore buffs consumed externally. Death cannot be reversed.

## Validation pseudocode
```text
if not acquired or dead or cooling or EE < 25: reject
select safe recorded path with same room and valid topology
if no safe destination: reject without cost
reserve cost, lock actions, play path backward while world ticks
validate endpoint; fallback along path or safe origin + refund
on success: commit EE cost, eligible health ledger, cooldown
clear old snapshots; record fresh history
```

If pit boundary not reached, may rewind. Lethal boundary/0 HP triggers death first. If no usable history (fresh load/room entry), indicator says recording; use not consumed. Service station at every mandatory Rewind gate supplies sufficient EE and resets local mechanism, cooldown can expire safely. Tutorial P09: start pad, switch within four seconds, shutter closes behind, rewind to pad while switch remains active. Later optional shutters use same pattern. Duration remains 6s for all mandatory puzzles; accessibility may extend puzzle timing without altering combat. Upgrades cost/cooldown/recovery only; see inventory. Test duplicate loot, heat bypass, cooldown reset, death, pause, moving platforms, collision changes, save/load and interrupted animation.
