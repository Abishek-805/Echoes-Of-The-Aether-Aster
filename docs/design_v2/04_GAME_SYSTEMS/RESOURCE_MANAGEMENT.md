# Resource management — Echo Collector and Echo Energy

**Version:** 2.0 | **Date:** 2026-11-27 | **Status:** Approved V2 direction; implementation details are working specifications

## Creator-approved core
When Aster or Orion interacts with a releasable Echo or collects one liberated by a defeated enemy, their carried **Echo Collector** briefly captures it, performs controlled release, and stores the energy produced by that release in its integrated cell. The Echo continues to Aether. The player never stores souls in a persistent inventory and never burns them. **Echo Energy (EE)** is stored power, not an Echo. Weapons, Rewind, Intel and later Relay use EE. Energy and heat are independent; no ammunition, magazines or reload.

## Collector hardware and presentation
Chest harness device, reinforced cylindrical release chamber, observation window, separate energy storage cell, faint cyan trails. State: Idle → Detect → Capture → Release → Store → Idle. On collection (proximity pickup for defeated enemy drops; E for bound environmental Echo), transfer token ownership once, play short 0.35s capture and 0.45s upward release cue, commit energy atomically. Animation does not lock combat. Queue concurrent tokens by unique ID; presentation may batch trails, ledger processes each once. If player dies before completion, rollback uncommitted token with checkpoint; if committed, preserve according to save transaction. Full capacity never blocks safe release; surplus dissipates and HUD displays “Echo released · energy full”. No storing a token for later currency. Memory imprints are inspectable but never yield EE. Voruun destruction produces no released Echo; residual energy pickups are explicitly separate.

## Economy prototype
- EE cap 100 at start; initial cell 60 EE, town tutorial can restore minimum 60. Each valid rifle shot costs 2 EE; other weapons in [weapon table](WEAPONS.md). Rewind costs 25 EE. Blade/dodge and ordinary mechanisms cost no EE. Healing uses charges, not EE.
- Enemy yields 6–18 EE (based on stored bound Echoes; variants as enemy bible); energy conversion includes modern efficiency losses. Optional capacity upgrade +20 (max 120). Ancient efficiency gains deferred to III.
- Rest stations restore HP, charges and EE to at least 50, not reduce higher stored energy; all mandatory bosses and puzzle stations supply enough for intended attempts. P09 guarantees ≥25 and can repeat; optional Rewind challenge station also ensures retry. Aster's starting blade guarantees combat without EE. Final diagnostic terminal uses guardian reserve separately, never drains player EE.
- Guild Marks town-only; alloy/biological/relic materials for deterministic upgrades. Ordinary enemies respawn on rest as gameplay abstraction; no individual soul duplication. Collect once per encounter spawn generation. Unique world Echo tokens never respawn.

## Accounting example
Aster at 90/100 EE collects a token yielding 18 EE: Echo passes to Aether, stored EE becomes 100, 8 surplus dissipates. Fires rifle five times: 90 EE, weapon heat increases according to timing. Activates Rewind: 65 EE, prior weapon heat remains current and no energy is restored. At EE=0 firing disabled, blade and dodge work; rest raises EE to 50.

## Data and transaction
`EchoPickup {id, source_type, yield_ee, encounter_generation, released}`; `EnergyCell {current, capacity}`; `ReleaseTransaction {pickup_id, credited, overflow, committed}`. Unique ID + generation prevents duplicate event handling. Energy clamp [0,capacity]; never negative. On accepted pickup, `credit = min(yield, cap-current)`, `overflow = yield-credit`, flag release committed. On shot/ability activation check available EE before debit; reject invalid requests without cost. Events must not rewind or re-credit across save/load. Store only EE and released IDs in save, not a persistent inventory of Echoes. Audio/visual distinction: upward Echo departure vs cyan cell-fill effect. HUD label “Echo Energy” with gauge; no Echo count or ammo count.
