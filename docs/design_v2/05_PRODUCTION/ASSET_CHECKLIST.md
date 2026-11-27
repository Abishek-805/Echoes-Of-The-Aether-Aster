# Asset checklist and production manifest

**Version:** 2.0 | **Date:** 2026-11-27 | **Status:** Approved V2 direction; implementation details are working specifications

Track each item in source-controlled manifest (ID, type, owner, status, license, file, review date). Targets, not completed assets.

| Family | Quantity / coverage | Required assets |
|---|---|---|
| Aster | 1 character, 18+ animation groups | turnaround, gear layers, expression/portrait, movement, blade, energy fire, cooling, collect/release, Rewind, hurt/death |
| Orion | 1 later-game character; post-credit hand/terminal only I | limited I tease; full later assets separate |
| Supporting cast | 5 town NPC + Seren recorded figure | silhouettes, portraits, idle/talk, minimal interactions |
| World | 6 biome tile families, 64 rooms | ground/wall/platform tiles, hazards, props, backgrounds, anchors, landmarks |
| Enemies | 8 bases + 4 variants | idle, move, tell, attack, recover, stagger, defeat, drops |
| Bosses | 6 | arena, phase states, telegraph effects, core/shield feedback, defeat |
| Weapons | 4 ranged, 1 blade | inventory icons, silhouettes, muzzle, vent effects, thermal cues |
| Collector & EE | 1 device | capture/release/storage/overflow effects, UI icons |
| Puzzles | 12 major, 16 minor | six symbols, conductors, receivers, anchors, map displays, switches and hints |
| UI | 1 suite | title, slots, HUD, map layers, journal, inventory, settings, pause, credits/end |
| Cinematics | 8 sequences | opening, Warp, vault, gallery, relic, guardian, gate, refuge/post-credit |
| Audio | cue library and themes | see [audio bible](AUDIO_BIBLE.md) |

Definition of done: source layers preserved; named exports correct; pixel alignment, pivots, hitbox event markers and licenses checked; scene integrated; readable at gameplay scale; reduced effects supported. No ammo/reload art or sound work. Maintain separate legacy archive and source license register; unused reference art is not automatically licensed for release. Optional content assets only after critical route playable.
