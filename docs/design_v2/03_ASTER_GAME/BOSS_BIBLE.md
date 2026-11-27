# Boss bible — four required and two optional encounters

**Version:** 2.0 | **Date:** 2026-11-27 | **Status:** Approved V2 direction; implementation details are working specifications

Every encounter has a rest point or safe checkpoint shortly before it. Retry resets boss health, attack timers, projectiles and arena hazard state, preserves previously collected unique rewards and mandatory progress outside arena. Arena gates lock only during live encounter; defeat or retreat at authored entrance resets safely. Required bosses give permanent unlocks; no optional boss required. All damage and HP are prototype values.

| ID | Boss | Room | Role | HP | Damage | Flag | Lore / moves | Telegraph / counter |
|---|---|---|---|---:|---|---|---|---|
| B01 | Sluice Warden | SLU03 | Required | 320 | 18–24 | WARDEN_DOWN | Maintenance construct; slam shockwave; double slam <50%; attack stuck arm/core. | 1.0s wind-up; 1.4s recovery; phase chain 2 with clear pause. Safe mode opens bridge exit. |
| B02 | Mossbound Titan | ROT04 | Optional | 420 | 20–26 | TITAN_DOWN | Root-covered maintenance guardian; root sweep, falling debris, expose side core. | 0.9s tell; 1.3s recover; jump sweep, move from debris marker. MAP04 and alloy. |
| B03 | Wayfinder Colossus | RES03 | Required | 620 | 18–28 | COLOSSUS_DOWN | Damaged alignment construct; rear beam, ceiling marker, fold punch, resonance pulse. | 0.8–1.2s warnings; 1.5s exposed core; all avoidable pre-Rewind. Phase2 combines two known attacks sequentially. |
| B04 | Reliquary Keeper | REW02 | Required | 380 | 18–24 | KEEPER_DOWN | Mithril vault guardian; paired conductors isolated first; shield pulses and core windows. | Shield opens after pulse for 1.6s; dodge charge; short encounter. No Rewind required. |
| B05 | Rift Devourer | FOL04 | Optional | 760 | 20–30 | DEVOURER_DOWN | Displaced Voruun predator; marked rift strike, delayed pool, charge. | 1.0s tells; 1.5s recovery; use Rewind safely; HP04, MAP06, MEM05. |
| B06 | Fold Guardian / Last Custodian | GAT01 | Required | 1000 | 20–32 | GUARDIAN_DOWN | Containment system; Phase1 strikes/beams; Phase2 portal attacks; Phase3 delayed markers and exposed core. | 1.0s minimum initial tell, 1.6s opening; phase thresholds 70%, 35%; no new last-second mechanic. |

## Encounter sequences
- B01: alternate single slam and sweep, then two slams below 50%. Jump floor wave or dodge, hit stuck arm. Final core exposure; WARDEN_DOWN triggers safe mode, bridge exit and reward (40 EE if room reward collected, alloy x4).
- B02: telegraphed root sweep and marked debris; stagger at exposed side. At 40% alternate debris then sweep, never simultaneous unavoidable zones. MAP04, alloy x4; HP01 is garden, not this boss.
- B03: cycle fold punch, ceiling strike, rear beam, then resonance pulse. Body position does not indicate beam origin; markers do. Below 50% chain two attacks with independent markers and safe lane. Exposed core after pulse. Reward 60 EE and relic component x2; flag opens Sanctuary.
- B04: P07 isolates external shield supply, remaining internal shield cycles. Pulse then committed charge, core exposed, repeat; below 35% shorter wind-up but never below fair reaction time. Reward 35 EE and relic x1. Keeper defeat opens relic chamber, P08 still required.
- B05: telegraphed rift strike, delayed pool, charge. Rewind-compatible arena with marked safe origin; safe before/after destinations. Optional and mastery-focused. Reward HP04/MAP06/MEM05 + material. Consumer cannot release destroyed Echoes.
- B06: phase 1 containment directional beam and strikes; phase 2 folds with clearly marked origin and destination; phase 3 place delayed markers (2.0s delay) and alternate learned moves. Rewind does not cancel timers or boss health. Final sequence exposes core during a known containment cycle. Guaranteed safe route via ordinary movement even if EE depleted; Rewind provides advantage. Phase transition clears conflicting hazards. On defeat plays directive, permanently opens GAT02 and provides separate reserve power to P12 (not dependent on player resource). No further surprise boss after final gate.

## Boss acceptance
Each hit has anticipation, active and recovery frames. Arena camera always shows marked origin or directional cue. Avoid combinations that occupy every reachable safe location. Test with starting weapon, zero optional upgrades, minimum EE, default accessibility and reduced effects. Defeat flag and unique reward commit together. No duplicate boss reward on reentry, reload or Rewind. Boss rush is outside I scope.
