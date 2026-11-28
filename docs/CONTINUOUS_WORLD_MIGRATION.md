# Continuous World V4: Production Integration

The supplied V4 package is kept verbatim under `references/continuous_world_v4/` as the current geography and construction reference. Its diagrams are concept and topology references; they are not collision-ready level art. The package describes 16 connected regions, 87 landmarks, 105 path links, 14 rest points, 12 major puzzles, 16 minor challenges, six bosses, and 56 collectibles.

## Decisions carried into the build

- Keep the approved Aster story, character canon, Echo rules, heat-based weapons, and broken-gate cliffhanger.
- Use the V4 geography as the target for replacing the provisional room-grid world. A region is a place in one landscape, not a completed level.
- Keep the user's confirmed double jump, air shooting, day/night cycle, and explored-only map. Where V4 conflicts with these controls, the user-directed controls take precedence.
- Keep the concept images as visual and layout references. Replace graybox art only after the mechanics and traversal have been proven.
- Treat the asset links in the lore export as candidates. Verify each current license and actual pack contents before downloading; start that work after the core mechanics milestone.

## Current implementation gap

The playable prototype still loads a campaign graph of 64 legacy room IDs and room-sized graybox layouts. It has real movement/combat foundations, story flags, puzzles, saves, and an explored-only map, but it does not yet implement V4's continuous terrain, region streaming, landmark graph, or geography-based map. The V4 JSON's `legacy` room references provide a migration bridge; they are not the final world architecture.

## Migration sequence

1. Preserve the current playable campaign as a mechanics/regression sandbox while keeping all current saves readable.
2. Import V4 `world.json` as the authoritative region, landmark, path, prerequisite, and puzzle source. Retain stable IDs so journal entries, rewards, saves, and route conditions can migrate safely.
3. Replace the room-grid map with an atlas view that reveals landmarks and paths only as Aster explores. M remains the map shortcut on keyboard; touch and gamepad retain visible map access.
4. Build one continuous graybox terrain spine for the opening route: Guild Town, Outer Wilds, Hunter's Reach, Survey Camp, and the first Echo Sluice approach. Use natural elevation changes and authored passages, not room-completion transitions.
5. Add persistent world-state and technical chunk streaming behind the continuous traversal. Chunk boundaries must not reset Rewind history; only a true fold, death, reload, or hard cinematic can do so.
6. Reconnect the existing puzzle, encounter, collectible, checkpoint, and story systems to landmark/path IDs. Play through main and optional routes with actual movement before adding decorative asset packs.
7. After mechanics and traversal hold up, verify and download the selected free art/audio packs, record their exact licenses and attributions, then adapt them to a consistent pixel-art palette.

## First-slice acceptance

The first continuous-world slice is ready to expand when Aster can travel from town into the wilds without room-transition screens, discover the same named landmarks shown in the V4 notes, use the map to orient, solve the opening world-system puzzle, save and reload without losing discoveries, and return through a shortcut. This is a graybox production milestone; it does not claim the whole game is complete.

