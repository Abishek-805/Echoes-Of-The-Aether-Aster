# Production requirements and open work

## Current toolchain

- Godot 4.7.2 Standard, GDScript and the Compatibility renderer.
- Windows development machine, Git, Python/Pillow and Node are available.
- No .NET SDK, online service, paid asset generator or Aseprite installation is needed
  for the current 2D placeholder production phase.
- PixelForge (`pixel-art`), pxl, pixelfx, Godot movement, scene, UI, export, AI,
  level-design, and asset-pipeline skill instructions are installed. These guide work;
  they are not all runtime dependencies.
- The global `opengame-workflow` skill adapts OpenGame's template/debug process to
  Godot. The OpenGame CLI itself is a separate Phaser/web framework and is not part of
  this Godot project's runtime.

## Game requirements in the active build

- Aster solo first; the rescue setup hands into Orion's solo game; *The Lost Echoes*
  remains the finale.
- The campaign data has 64 room records, 70 connections, 12 major and 16 minor puzzles,
  56 collectibles, five weapon entries and six bosses.
- World map is opened with **M**, and the UI only reveals explored rooms and known
  connections. Day/night affects outdoor lighting.
- Player-directed movement overrides older conflicting V2 movement restrictions:
  double jump and airborne shooting are required.
- Echo Energy is stored energy, not ammunition. Ranged weapons spend stored energy,
  heat up during continuous fire, stop while overheated, and cool automatically.
  Melee remains available. Rewind cannot restore spent energy or weapon heat.
- Rewind changes Aster's personal position/condition and does not reverse world state.
  It is acquired late in Chapter 2. Aster ends Game I trapped by the Warp-damaged gate.
- Enemy drops are claimed once by stable room/enemy ID, even if the encounter respawns
  after resting; duplicate deaths do not duplicate Echo Energy or materials.
- The 56 room collectibles are world pickups, with health/weapon/blueprint effects
  applied on the first claim. Their geometric markers and placement are working specs.
- Use temporary placeholder visuals to complete the playable game before replacing
  them with final art. See [player-directed overrides](PLAYER_DIRECTED_OVERRIDES.md).

## Remaining production work

- Expand graybox room data into authored, navigable level compositions with distinct
  routes, vertical spaces, landmarks and diegetic clues. A data entry is not a finished
  room.
- Complete and tune the critical path, bosses, puzzle presentation, rewards, damage,
  encounter reset rules, secrets and side stories through hands-on play.
- Finish safe Rewind edge cases, save integrity, collectible/unlock audit, map UX,
  interaction prompts, inventory/crafting balance and player settings.
- Improve camera/room transitions, accessibility, controller navigation, touch safe
  areas and configurable controls.
- Replace placeholder character/environment/UI art and add animation, VFX, SFX and music
  after the full playable route is stable.
- Run clean exports and hardware/browser play checks for every supported target.

## Platform-specific prerequisites

- Desktop: matching export templates and launch tests on actual Windows, Linux and macOS.
- Web: Web export templates, hosted browser run, WebGL2 and save persistence checks.
- Android: templates, JDK 17, Android SDK, signing and physical-device tests.
- iOS: macOS/Xcode, templates, team/bundle IDs, signing and physical-device tests.
- Consoles: platform-holder approval, developer hardware/SDK, an authorized Godot
  provider/port, native service integration and certification. The project does not
  claim console support based on a PC controller or generic preset.

## Validation standard

Headless contracts prove data and selected mechanics only. Each completed region still
needs an interactive playthrough on a clean save, a save/load round trip, and review of
all critical clues, routes, enemies and rewards. Release builds require fresh-install
verification and measured performance; no minimum specification or release date is set.
