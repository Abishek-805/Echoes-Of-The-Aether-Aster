# Static validation and open work

This V4 package was generated from the approved V2 design and the V3 puzzle, encounter and collectible content, then re-authored as continuous geography. V3 room tile coordinates and room count are intentionally retired. The generated concept map is reference art, not authoritative topology.

## Checks performed
- 16 named regions; 87 unique geographical anchors; 105 unique path records, all endpoints resolve.
- Required flag simulation reaches final refuge without optional rewards: PASS.
- With all optional actions, all 82 post-Warp accessible anchors are reachable and all town anchors remain inaccessible: PASS.
- With each of 23 required story flags individually suppressed, even with optional actions enabled, final refuge remains unreachable: PASS. This is a graph reachability test, not an execution proof of puzzles.
- 56 unique collectibles, 14 permanent rest locations, 12 major puzzles, 16 minor puzzles and six bosses retained: PASS.
- Optional paths cannot bypass the required Warp topology lock; all seven shortcut records retain explicit prerequisites. S06 additionally requires local archive return latch.
- Prior P02 compass mismatch corrected to reflect new map (bell west-northwest, split rock east-northeast). P01 distributed across a compact feeder loop, P11 across a multi-elevation stabilizer loop. Both keep established solutions. V3 room coordinates are not reused.

## Limitations and required next steps
- Atlas is a macro schematic, not exact collision tiles. Some schematic paths cross; crossings are not junctions. Resolve each physical crossing by offsets or explicitly separated passages at blockout stage. Veraya uses a separate spatial domain. Do not assume all lines are collision geometry.
- No actual playable Godot scenes, scripts, final art, TMJ replacement or runtime physics tests. Suggested platform dimensions and pace remain prototype assumptions; actual route length, collision, camera, load transitions, branch appeal and boss safety need playtesting.
- The map uses suggested scaled coordinates, not literal kilometres; the artistic concept's scale and extra icons are not canonical. Validate no fake doors/incorrect boss placement.
- Runtime acceptance: every critical/optional traversal with actual controller; all reset cases, zero EE, overheat, full EE, Rewind history across technical chunks, backtracking, save/load, death, gate closure, and streaming tests. Blind test geography and pacing before finalizing layout. No claim of production-complete game.
