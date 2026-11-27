# Movement, input and camera

**Version:** 2.0 | **Date:** 2026-11-27 | **Status:** Approved V2 direction; implementation details are working specifications

Baseline Aster has run, jump, drop-through, mantle/climb authored ledges, dodge, aim, ranged attack, melee, heal and interaction. No double jump, magic dash, teleport or extra special power. All pre-Rewind routes use these verbs. Prototype logical resolution 640×360; tiles 16×16, player approx. 32×48. Physics 60 Hz. Initial movement speed 150 logical px/s; jump impulse 300 px/s, gravity 900 px/s², coyote 0.10s, buffer 0.12s, variable height release. Dodge 0.25s at 300 px/s, invulnerability 0.15s, recovery 0.35s; no resource cost. Mantle only designated edges; no ledge bypass of locked progression. Movement responsive, not simulation heavy.

| Action | Keyboard/mouse | Gamepad (default mapping) |
|---|---|---|
| Move/aim | A,D / pointer | Left stick / right stick |
| Jump / drop | Space / S+Space | South / down+South |
| Dodge | Left Shift | East |
| Fire | Left mouse | RT |
| Melee | Right mouse | RB |
| Interact | E | West |
| Heal | Q | LB |
| Rewind (after unlock) | F | LT |
| Switch equipped primary at rest | 1/2 or UI | D-pad at rest UI |
| Map / Journal / Inventory | M / J / I | View opens tabbed menu |
| Pause | Esc | Menu |

No reload button. R is unbound by default. Heat dissipates automatically. Controls fully remappable, hold/toggle aim options, controller dead-zone and sensitivity. Prevent conflicting bindings and show dynamic prompts. Camera follows with look-ahead, vertical dead zone, room bounds; boss arenas fixed or constrained; show marked off-camera threats, disable shake option. Camera motion never changes physics history. Falling into pits uses explicit hazard boundary; before death Rewind may recover, after death cannot. Save and loading behavior in [checkpoints](SAVE_AND_CHECKPOINTS.md).
