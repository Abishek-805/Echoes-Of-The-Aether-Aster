# Player-directed decisions

This note records later explicit direction from the project owner. These decisions
take precedence over conflicting earlier requirements while preserving all other
canon and story details.

## Movement and combat

- Aster's single-player game includes double jump.
- Aster can shoot while airborne, including while jumping.
- Keep the full game playable with temporary placeholder visuals until the campaign
  and its mechanics are complete. Replace or polish assets in a later production pass.
- The intended world should feel cohesive, readable, and lived in rather than like a
  sequence of bare box rooms. During graybox production, use landmarks, layered
  silhouettes, room purpose, environmental clues, and consistent mechanics to carry
  that feeling without delaying completion for final art.

## Core game features

- Include a day/night cycle.
- The world map opens with **M** on keyboard. It reveals rooms only as they are
  explored and must not reveal undiscovered layout or destinations.
- Include familiar Metroidvania traversal and combat features as appropriate to this
  game's established design: responsive jumping, double jump, jump shooting, melee,
  ranged weapons, dodge, healing, ability-gated routes, shortcuts, exploration,
  checkpoints, enemies, mini-bosses, and bosses.
- Do not add mechanics merely to meet a genre checklist if they conflict with canon or
  weaken the readable world puzzle. Every mechanic needs a world and gameplay purpose.

## Earlier conflicting decisions

The older V2 requirements disallow double jump and describe a narrower initial move
set. The later explicit player instruction supersedes those movement restrictions for
the current Godot game. Other canon remains in force, including Echo Energy rather
than ammunition, heat and automatic cooling, no Rewind restoration of energy or heat,
and Aster's final gate being blocked by the Echo Warp.

## Delivery expectations

Production should prioritize a complete playable game using placeholders first, then a
cohesive visual replacement pass. Platform presets do not count as verified builds:
each target needs a real export and runtime check, with console certification requiring
platform-holder access and kits.
