# Godot technical architecture

**Version:** 2.0 | **Date:** 2026-11-27 | **Status:** Approved V2 direction; implementation details are working specifications

Godot 4.x project direction, GDScript, local single-player desktop first. This is architecture, not a built repository. Keep later multiplayer separate: no networking dependency in Game I. Data-driven Resources and signal-based composition; avoid global hard-coded scene paths. Choose exact engine patch and export targets when implementation begins.

```text
res://
  autoload/  session.gd save_manager.gd audio_manager.gd settings.gd
  actors/player/  player.tscn movement.gd health.gd combat.gd echo_collector.gd rewind.gd
  actors/enemies/  base_enemy.gd states/ archetypes/ bosses/
  world/  room_loader.gd room_state.gd room_graph.gd rooms/ mechanisms/ interactables/
  systems/  inventory.gd energy_cell.gd weapon_heat.gd progression.gd journal.gd map.gd
  data/  weapons/ enemies/ bosses/ puzzles/ rooms/ dialogue/ localization/
  ui/  hud/ map/ journal/ inventory/ menus/ accessibility/
  art/ audio/ tests/ tools/
```

Scene root Room has EntryMarkers, static TileMapLayer(s), camera bounds, collision groups, authored mechanisms, encounter manager, map geometry and stable IDs. `Player` CharacterBody2D owns movement; Health handles damage ledger; Weapon controller validates firing and heat; EnergyCell owns EE transactions; EchoCollector consumes unique token and releases; Rewind owns only player snapshots. SaveManager serializes versioned durable state, not scene nodes. Quest system applies flags with prerequisite checks. Room loader uses graph edges and flags, loads scenes at validated entry marker; clears Rewind history on hard transition. AI uses state machines, attack definitions Resources and animation event hitboxes. Boss phase manager checks thresholds, cleans hazards. UI subscribes to signals rather than polling every frame.

| System | Key events | Invariants |
|---|---|---|
| Energy | echo_released(id,credit,overflow), energy_changed | unique token once, clamp |
| Weapon | shot_accepted, heat_changed, overheated, cooled | atomic EE+heat; no firing while locked |
| Health | damaged(id,amount), healed, died | death irreversible within attempt |
| Rewind | acquired, started, ended, rejected | only personal snapshots; costs/heat/flags not rewound |
| World | room_entered, flag_set, mechanism_solved | deterministic gated graph |
| Progression | item_collected, boss_defeated, objective_changed | unique durable IDs |
| Save | checkpoint_committed, load_failed | atomic file+backup; no invalid spawn |

Physics fixed 60 Hz. Render may vary; heat, cooldowns and snapshot time derive simulation delta, not frame count. Pause stops world tick. 360 snapshots maximum per player; no entire-world recording. Collision layer plan: world static, one-way platforms, player body/hurtbox, enemy body/hurtbox, player attack, enemy attack, hazard, interaction, Rewind tagged shutter. Use masks explicitly. Performance targets: stable 60fps on chosen reference PC, bounded active rooms, pooled transient particles/projectiles, no orphan timers, profile before optimization. Target hardware/export specs must be tested, not guaranteed.

## Data validation
Use [room manifest](DATA/rooms.csv), [edges](DATA/edges.csv), [puzzles](DATA/puzzles.csv), [enemies](DATA/enemies.csv), [bosses](DATA/bosses.csv), [collectibles](DATA/collectibles.csv) as planning/import seeds. Validate all IDs, gate flags, unique pickups and post-Warp reachable regions; generate Resource definitions manually or importer. Markdown remains authoritative for narrative/rules. Do not generate mechanics blindly from text; tests define behavior. Debug tools: teleport to known checkpoint in developer builds, reset flags, display heat/EE and Rewind snapshots, boss phase and collision debug; strip or disable in release. No external server/API required.
