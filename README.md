# Echoes of the Aether: Aster

Godot production started in this folder. Open `project.godot` with Godot 4.7.2 Standard
and press F6 on `world/sandbox.tscn`, or F5 to run the title screen and begin the expedition.

The active build is a graybox campaign prototype driven by the 64-room V2 manifest.
It includes condition-gated progression, an exploration map, day/night tint, checkpoint
state, puzzles, encounters, pickups, upgrades, combat systems, and the campaign's
distress/refuge ending. Temporary room geometry and generic enemy behavior remain; this
is not a finished or release-ready game.

See `docs/PRODUCTION_STATUS.md` and `docs/REQUIREMENTS.md` for scope and dependencies.
Read `docs/design_v2/README.md` and `00_MASTER_CANON/CANON_DECISIONS.md` first for design.

You can also run `Start Game.ps1` to play or `Start Game.ps1 -Editor` to open Godot.

Start planning with [Production plan](docs/PRODUCTION_PLAN.md) and [Asset tracker](docs/ASSET_PRODUCTION_TRACKER.csv).

Platform configurations and known requirements: [Platform support](docs/PLATFORM_SUPPORT.md).

Current production build: choose Begin/Continue Expedition from the title screen. Press
M for the explored-only map. The six-room mechanics sandbox remains available for
regression and combat iteration.

Character sprites and environment visuals are temporary. The player-directed priority
is to finish the game with placeholders, then replace and polish assets. See
[production status](docs/PRODUCTION_STATUS.md) for scope and test coverage.
