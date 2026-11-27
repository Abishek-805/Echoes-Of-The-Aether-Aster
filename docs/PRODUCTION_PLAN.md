# Aster — production plan

Status: proposed execution plan for review, 2026-11-27. This is the production entry
point. V2 remains authoritative for story; balance values and exact geometry remain
working specifications. The current sandbox is an early engineering experiment with
temporary visuals. Next work starts with visual and world planning, before expansion.

## What we are making

Echoes of the Aether: Aster is a Godot single-player pixel-art adventure. Target scope:
64 rooms, 16 regions, six biome families, three chapters, four required and two optional
bosses, eight enemy bases plus four variants, 12 major/16 minor puzzles, seven side
stories, 56 collectibles, five weapons and 14 rest stations. The target experience is
about eight hours on the main route plus optional content; measured playtime decides
whether this scope is realistic. Aster finds Rewind near the midpoint and ends trapped
at the warp-damaged gate. Orion and the co-op finale receive only the assets necessary
for Aster's game now.

The main production risk is the amount of consistent art, animation and authored level
content. We manage it by finishing one small representative section, measuring its
cost, then building the remaining game in repeatable batches.

## 1. Reference and continuity audit

Deliverables: reference contact sheet, approved/rejected asset inventory, short canon
conflict list, style board and source/license register.

Review existing Aster.png, Orion.png, world concepts and candidate sprites in the old
project and Concept art folder. Their presence does not mean they are final or cleared
for distribution. Preserve original files and record which details each reference
controls: identity, costume, material, palette, architecture or mood. Use the V2 Aster
bible for character identity; older hand-mounted versus V2 forearm Rewind details need
an explicit art decision before character animation. Aster begins without active
Rewind. Neither generated artwork nor unrelated downloaded packs decide canon.

Exit: one documented reference set governs character and world design. Conflicts are
resolved before affected production begins. No bulk generation yet.

## 2. Technical and visual target

Working frame: 640×360 logical view, side view, 16-pixel base grid, approximately
32×48 Aster, nearest filtering, stable foot pivot and integer scaling where feasible.
Treat dimensions as prototype targets until a native-scale scene proves the design is
readable. Collision and jump metrics determine ledges and gaps, not decorative tiles.

Make one style board showing Aster, a Forager, a guardian silhouette, a terrain strip,
a landmark, one mechanism, HUD, foreground and distant scenery. Define shared lighting,
outline thickness, palette roles, material shading, background contrast and detail
limits. Cyan identifies EE/release, violet the Warp, amber heat; add shapes and motion
so color alone is never needed to understand danger or interaction.

Exit: the user can view a native-scale image and an enlarged preview and judge how
Aster, the creatures and world look together. Record the chosen board as the visual
reference. Changes later propagate through a revision log.

## 3. Aster first: character production

First finish one facing-right Aster idle and mirrored-left inspection with correct
hands, Collector, muzzle and gear sockets. Preserve editable source layers for body,
suit, jacket, harness, armor and equipment. Match body volume, face, hair, costume,
boots, weapon and Collector across frames. Mirroring must not accidentally move the
Rewind device to the wrong anatomical arm.

Production order: idle → run → jump/fall/landing → blade → rifle fire/aim → hurt →
dodge → interact/Collector → defeat → mantle/drop → heal → heat/cooling → Rewind.
Create only the subset needed for the slice first; keep shared pivots and event markers.
V2 frame counts are initial animation targets, not permission to ship repeated frames.
Contact-sheet review and in-engine motion review are required for each action.

Exit: movement and two attack actions look stable over a real background at gameplay
scale; muzzle flashes, hitboxes, footsteps and blade timing match the pose. The hero
must be convincing before expanding the roster.

## 4. World design and the world-scale puzzle

Use six reusable environment kits, not 64 independently illustrated rooms. Each kit
contains terrain edges/corners/transitions, platforms, collision rules, props, readable
interactive objects, a landmark, three or fewer initial parallax layers and lighting
rules. Rooms must differ through function, silhouette, routes and story evidence.

| Family | Coverage | Design role |
|---|---|---|
| Eldaran frontier | Town, Outer Wilds, Hunter's Reach, camp | Warm inhabited life, hunter culture, contrast before Warp |
| Rootspan waterways | Sluice and Rootspan | Living roots, bridges, water and Echo infrastructure |
| Ancient archive | Works, Survey Vault, Silent Gallery | Relic custody, memorials, functional old machinery |
| Warped network | Verge, Depths, approach and gate | Altered connections, violet disruption, fair danger markers |
| Verayan annex | Veraya Fold | Recognizably different manufacture linked to the same systems |
| Reservoir/vault | Reservoir and Rewind Sanctuary | Controlled flow, storage, guarded relic and release clues |

Before dressing a room, write its ID, original purpose, player objective, entrances,
exits, gate flags, landmark, clue, environmental consequence, enemy pressure, reward
and reset/save behavior. Connect every main puzzle to the larger system. A solution
should reveal or change a relationship: a bridge seen elsewhere rises, a flow reroutes,
a map connection becomes understandable. Establish a shared six-symbol language from
V2; repeat it consistently in maps, machines, records and architecture.

Build room graphs first, then graybox spaces at measured movement scale. Check routes
before/after the Warp, optional-return paths, required keys and clue accessibility.
Critical clues cannot sit behind the gate they solve. Distinguish authored safe
Rewind shutters from ordinary walls. Rewind changes Aster, never the world state.

Exit: the world-level clue chain and all critical route gates make sense without final
art. No required clue is communicated solely by color or sound.

## 5. First complete playable slice

Build an authored town/outer-route/Sluice/Warden loop using a small subset of the V2
room graph. The sandbox is a mechanics reference, not the final layout.

Slice content: short opening/briefing, Aster's initial controls, Forager, EE release,
map clue, a multi-room Sluice cause-and-effect puzzle, a shortcut, one rest/save point,
Sluice Warden and a clear endpoint. Later Rewind gets a separate test arena so its
safety and resource rules are solved early without granting it in Chapter 1.

Slice art: Aster action subset, Forager action set, Warden action set, one foreground
kit, bridge/conductors/rest station, background, EE/release/heat/hit effects, compact
HUD and essential audio. Use this scene as the quality target for everything later.

Exit: start-to-end play without debug actions; save/load and retry work; no softlocks;
zero-EE blade remains viable; heat/cooling is readable; character and enemy tells read
at native scale. User play feedback approves the feel and visual target. Record hours
spent per room, action and enemy; use those measurements to estimate later batches.

## 6. Full-game build order

1. Finish core systems: safe Rewind, healing, checkpoint transactions, persistent room
   state, map/journal/inventory, upgrades, input remapping and controller support.
2. Build Chapter 1 critical route and environment kits. Confirm its clues lead to the
   Chapter 2 relic hunt; do not require Rewind early.
3. Build Chapter 2 route, Verayan differences, puzzles, Colossus and Keeper. Integrate
   relic acquisition and the safe Rewind tutorial at the intended midpoint.
4. Build Chapter 3, Rewind mastery, final routing, Fold Guardian, gate diagnosis,
   distress signal and refuge ending. Aster cannot escape in Game I.
5. Add optional bosses, branches, side stories, alternate weapons and collectibles
   after the full required route can be completed.
6. Complete art, dialogue, cinematics, music, settings and accessibility in room-sized
   batches. Reuse approved families; review new biomes before producing all variants.

Every chapter ends with a playable build and story review. Full graybox completion
precedes detailed decoration of every room. Art for the slice is developed early to
prove the quality target, not deferred until the campaign is finished.

## 7. Asset pipeline and acceptance

Every asset follows: brief and reference → palette/size/pivot definition → editable
source → draft frames → contact sheet/native preview → revise → engine export →
in-game review → accepted manifest entry. Status values: planned, draft, technical
pass, visual review, accepted, revision needed. A successful tool call is not acceptance.

Keep stable IDs, semantic animation names, source path, export path, dimensions,
frame count, FPS, pivot, hitbox events, source/license, reference revision and review
notes. Preserve source layers; build atlases only from accepted assets. Tiles must
pass a repeated 3×3 preview, seams and silhouette checks. Character animation must
pass baseline, volume and identity checks. Effects must not obscure attack warnings.
Final files need license/provenance records and readability in the actual Godot scene.

Use pixel-art/PixelForge or pxl for controlled pixel authoring, palette enforcement,
previews and export. pixelfx supplies effects from its library or authored code after
that library is available. Godot animation/tilemap skills own import and playback.
Use the right skill per asset; running every installed skill would not improve it.
No Aseprite purchase is needed. No paid generation or pack purchases are assumed.

## 8. Tools, audio and release requirements

Available: Godot 4.7.2, Git, Python/Pillow and Node. Remaining setup as needed: matching
Godot export templates, optional ffmpeg for motion previews, an optional free editor
for pixel touch-ups, source audio tools and an organized licensed audio library.
No online server is required for this game. Keep tools and dependencies versioned in
documentation and install additions when their production stage needs them.

Audio starts with slice cues: footsteps, jump/land, blade, rifle/overheat/cooling,
Forager/Warden tells, damage, safe release, puzzle success, rest and ambient loop.
Dialogue stays text-based. Cinematics reuse sprites, parallax and a small number of
panels. Schedule sound and music passes alongside completed regions.

Release requires a complete critical route, validated saves and collectible ledger,
no Rewind energy/heat/loot exploits, clear combat tells, accessibility settings,
measured performance, clean Windows export and tested fresh install. Record hardware
and measured playtime; do not promise minimum specs or a release date before evidence.

## 9. Scope decisions and review rhythm

Aim for the V2 scope, but estimate after the slice. If the workload is too large, first
reduce decorative variants, repeated optional encounters, cinematic panels and optional
branches while preserving the story, world puzzle and required encounters. Present any
actual content reduction for the user's decision before changing canon.

At each review show: a playable build, a short clip/contact sheet, manifest changes,
known issues and the next concrete batch. No dates until measured production speed is
available. Avoid bulk-generating hundreds of mismatched assets to meet a count.

## Immediate next deliverable

A reference/asset inventory and one Aster + Eldaran frontier visual benchmark, then a
small set of stable hero movement/attack animations. Review these before expanding
room art, characters or bosses. No further campaign implementation is needed to make
this production decision concrete.
