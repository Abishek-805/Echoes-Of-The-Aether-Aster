# Echoes of the Aether — V2 development documentation

**Version:** 2.0 | **Date:** 2026-11-27 | **Status:** Approved V2 direction; implementation details are working specifications

**Start here.** This package expands the approved design into a structured game bible and implementation planning reference. It is not a playable Godot build. The creator approved prior lore/story suggestions and required two corrections: heat-only weapons (no ammunition/reload), and safe Echo release with stored Echo Energy. Those are enforced throughout active files. Historical originals preserved unchanged under `07_SOURCE_ARCHIVE/`; do not use conflicting legacy mechanics as current authority.

## Reading order
1. [Trilogy master canon](00_MASTER_CANON/TRILOGY_MASTER_CANON.md), [decision register](00_MASTER_CANON/CANON_DECISIONS.md), [Echo and Aether](00_MASTER_CANON/ECHO_AND_AETHER.md).
2. World and character bibles in `01_WORLD_BUILDING/` and `02_CHARACTERS/`.
3. [Aster complete story](03_ASTER_GAME/COMPLETE_STORY.md), chapter scripts, [world graph](03_ASTER_GAME/WORLD_MAP.md), [64-room manifest](03_ASTER_GAME/ROOM_SPECIFICATIONS.md), puzzles, enemies, bosses, side stories and dialogue.
4. [Echo Energy resource system](04_GAME_SYSTEMS/RESOURCE_MANAGEMENT.md), [weapon heat](04_GAME_SYSTEMS/WEAPONS.md), [Rewind](04_GAME_SYSTEMS/ECHO_REWIND.md), other gameplay specs.
5. [Godot architecture](05_PRODUCTION/TECHNICAL_ARCHITECTURE.md), [roadmap](05_PRODUCTION/DEVELOPMENT_ROADMAP.md), [QA](05_PRODUCTION/QA_AND_RELEASE.md), CSV data in `05_PRODUCTION/DATA/`.
6. Future games: [Orion](06_FUTURE_GAMES/ORION_GAME_DIRECTION.md), [The Lost Echoes](06_FUTURE_GAMES/THE_LOST_ECHOES_DIRECTION.md).

## Usage rules
Treat approved names/story and latest creator changes as canon. Detailed stats, room allocations, exact puzzle implementation, script drafts and art parameters are working design seeds to prototype and test. Read the decision register before changing a shared system. Do not silently import old co-op assumptions. No hidden escape in I, no Rewind before Ch2 end, no Intel before II acquisition, no Relay before III. The intentionally unresolved metaphysical and sequel mysteries are recorded, not missing design tasks. Detailed Godot implementation, pixel geometry, final assets, full localization, playtesting and later-game production are not yet complete.

## File index
- [The Vaelari and the Great Fracture](00_MASTER_CANON/ANCIENT_CIVILIZATION.md)
- [Canon decisions and conflict resolution](00_MASTER_CANON/CANON_DECISIONS.md)
- [Echo, release and Aether](00_MASTER_CANON/ECHO_AND_AETHER.md)
- [Historical timeline and reveal order](00_MASTER_CANON/HISTORICAL_TIMELINE.md)
- [Source register and authority audit](00_MASTER_CANON/SOURCE_REGISTER.md)
- [Trilogy master canon](00_MASTER_CANON/TRILOGY_MASTER_CANON.md)
- [Universe laws and constraints](00_MASTER_CANON/UNIVERSE_LAWS.md)
- [Creature ecology and Echo-dependent life](01_WORLD_BUILDING/CREATURE_ECOLOGY.md)
- [Culture, economy and everyday life](01_WORLD_BUILDING/CULTURE_AND_ECONOMY.md)
- [Eldara — world of hunters](01_WORLD_BUILDING/ELDARA.md)
- [Nalora — world of the lost](01_WORLD_BUILDING/NALORA.md)
- [Resonance Sanctuary architecture and visual grammar](01_WORLD_BUILDING/SANCTUARY_ARCHITECTURE.md)
- [Veraya — world of innovation](01_WORLD_BUILDING/VERAYA.md)
- [Aster — character bible](02_CHARACTERS/ASTER.md)
- [Character arcs and thematic continuity](02_CHARACTERS/CHARACTER_ARCS.md)
- [Orion — character bible](02_CHARACTERS/ORION.md)
- [Supporting cast and faction voices](02_CHARACTERS/SUPPORTING_CHARACTERS.md)
- [Boss bible — four required and two optional encounters](03_ASTER_GAME/BOSS_BIBLE.md)
- [Chapter 1 — The Forgotten Trail](03_ASTER_GAME/CHAPTER_01.md)
- [Chapter 2 — The Fractured World](03_ASTER_GAME/CHAPTER_02.md)
- [Chapter 3 — Beyond the Final Gate](03_ASTER_GAME/CHAPTER_03.md)
- [Aster — complete story and narrative structure](03_ASTER_GAME/COMPLETE_STORY.md)
- [Dialogue and cinematics — scene script baseline](03_ASTER_GAME/DIALOGUE_AND_CINEMATICS.md)
- [Enemy bible — eight archetypes and four variants](03_ASTER_GAME/ENEMY_BIBLE.md)
- [Puzzle bible — 12 major sequences and 16 smaller challenges](03_ASTER_GAME/PUZZLE_BIBLE.md)
- [Room specifications — 64-room production manifest](03_ASTER_GAME/ROOM_SPECIFICATIONS.md)
- [Side stories, collectibles and completion](03_ASTER_GAME/SIDE_STORIES.md)
- [Connected world map and progression graph](03_ASTER_GAME/WORLD_MAP.md)
- [Combat, damage and thermal rules](04_GAME_SYSTEMS/COMBAT.md)
- [Echo Rewind — complete gameplay contract](04_GAME_SYSTEMS/ECHO_REWIND.md)
- [Inventory, equipment upgrades and economy](04_GAME_SYSTEMS/INVENTORY_AND_UPGRADES.md)
- [Movement, input and camera](04_GAME_SYSTEMS/MOVEMENT.md)
- [Quest, progression and persistent flags](04_GAME_SYSTEMS/QUEST_AND_PROGRESSION.md)
- [Resource management — Echo Collector and Echo Energy](04_GAME_SYSTEMS/RESOURCE_MANAGEMENT.md)
- [Save, checkpoint, death and completion behavior](04_GAME_SYSTEMS/SAVE_AND_CHECKPOINTS.md)
- [UI, map, journal and accessibility](04_GAME_SYSTEMS/UI_AND_ACCESSIBILITY.md)
- [Weapon catalogue and overheat specification](04_GAME_SYSTEMS/WEAPONS.md)
- [Art bible — pixel-art visual production](05_PRODUCTION/ART_BIBLE.md)
- [Asset checklist and production manifest](05_PRODUCTION/ASSET_CHECKLIST.md)
- [Audio and music bible](05_PRODUCTION/AUDIO_BIBLE.md)
- [Development roadmap and scope gates](05_PRODUCTION/DEVELOPMENT_ROADMAP.md)
- [QA and release acceptance matrix](05_PRODUCTION/QA_AND_RELEASE.md)
- [Godot technical architecture](05_PRODUCTION/TECHNICAL_ARCHITECTURE.md)
- [Game II — Echoes of the Aether: Orion](06_FUTURE_GAMES/ORION_GAME_DIRECTION.md)
- [Game III — Echoes of the Aether: The Lost Echoes](06_FUTURE_GAMES/THE_LOST_ECHOES_DIRECTION.md)

[Validation report](05_PRODUCTION/VALIDATION_REPORT.md) records package checks. Original files and checksums are in [source register](00_MASTER_CANON/SOURCE_REGISTER.md).
