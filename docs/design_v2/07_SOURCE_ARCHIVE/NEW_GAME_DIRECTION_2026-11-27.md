# New Game Direction — 2026-11-27

## Purpose and status

This document records a new direction for the *Echoes of the Aether* games, discussed
on 2026-11-27. It is separate from the existing canon, GDD and technical documents.
Those older documents remain intact as historical material and a source of ideas,
characters, worldbuilding and mechanics to review while developing this direction.

The detailed first draft for Aster's game is in
[ASTER_GAME_PROPOSAL_V1.md](ASTER_GAME_PROPOSAL_V1.md). It is the evolving detailed
design; this direction record and the canon set hold the trilogy-wide decisions.

The organized canon set for the new trilogy is in [CANON](CANON/README.md). The
creator has confirmed that ideas discussed in chat so far are intended for the games
and are canon; details explicitly called flexible remain open to revision.

Use the new trilogy canon and this evolving brief for current direction. Do not assume
that older co-op requirements automatically apply to the first or second game. Specific
older material becomes part of a new game only after it has been reviewed for fit.

## Confirmed direction

The project is planned as three related games:

1. **Aster's game** — the first game, a single-player story centered on Aster.
2. **Orion's game** — the second game, a single-player story centered on Orion.
3. **Aster and Orion's co-op game** — the third game, bringing both characters together
   in one cooperative game.

The games share the *Echoes of the Aether* setting and may draw on the existing world,
story and system material. Their exact chronology, narrative connections and release
relationship have not yet been decided.

## First game: Aster

- The immediate development focus is Aster's single-player game.
- Current target playtime is approximately **8–10 hours**. Treat this as an early scope
  goal to review as the story and gameplay are developed.
- The player follows Aster as the central playable character.
- Design the first game around one player. Do not make a second human player, online
  multiplayer or simultaneous co-op necessary to complete its core experience.
- Existing Aster-related material in the old canon is a starting reference, subject to
  review and adaptation for single-player play.
- The project is intended to use Godot, as stated in the project conversation.
- The visual direction is a pixel-art game. **Hollow Knight** and **Hollow Knight:
  Silksong** are inspirations, especially for challenging monsters and bosses. The
  user also draws inspiration from **Sword Art Online** and other dungeon-based anime,
  especially dungeon exploration, improving skills and obtaining loot from defeated
  monsters. These are creative references; the story, characters and gameplay mechanics
  are the user's original ideas.

The detailed plot, chapter structure, gameplay loop, supporting-character roles,
controls, scope and technical architecture for this version remain to be developed.

### Provisional three-chapter structure

The user proposed a three-chapter structure for Aster's game. Treat the outline below
as a working structure that can be refined:

1. **Chapter 1 — The trail to the relic:** Aster explores the dungeon and faces a
   relatively simple mid-boss built around repeated attacks. At the end of the chapter,
   he finds a map or similar clue pointing toward the Echo Rewind relic.
2. **Chapter 2 — Echo Rewind:** Aster follows the clue toward the relic, faces a large
   monster as the chapter's mid-boss, and reaches the Echo Rewind relic at the end of
   the chapter. He acquires Echo Rewind here.
3. **Chapter 3 — The final gate:** With Echo Rewind, Aster fights a main boss that uses
   space-time abilities. This is the final boss before the gate. After the fight, Aster
   reaches the final gate, which has been broken by the Echo Warp and cannot be opened;
   he is trapped, leading into Orion's game.

The user suggested spatial and temporal attack patterns for a mid-boss, including
attacks arriving from behind or above and a laser coming from behind while the boss is
elsewhere. The final boss should use space-time attacks that make Aster's newly acquired
Echo Rewind useful. The exact boss roster, attack patterns, chapter lengths and the
division of encounters between chapters remain open.

## Main creative goal: the story across all three games

The central goal is to develop a coherent main story, beginning with Aster's first
game. Story decisions should establish:

- How Aster's game begins and what sets its events in motion.
- The central journey, conflict and stakes of Aster's game.
- How Aster's game ends and what it resolves or leaves open.
- Which monsters or aliens Aster faces, and how they fit the story and world.
- How combat and the overall gameplay approach support Aster's story.
- How the story continues through Orion's solo game and reaches the later co-op game.

The three games should form a connected larger narrative while giving each game's
protagonist a meaningful story. Specific plot events, endings, enemy identities and
combat details are open until developed and confirmed.

The trilogy should feel like one continuous saga rather than three unrelated games.
Each installment should have its own protagonist and satisfying story arc while
carrying the central mysteries, consequences and relationships forward. Development
should begin by completing Aster's game's story before fully outlining the later games.

The immediate goal is to fully develop Aster's game before production begins: its
complete story, plot beats and foreshadowing, world regions, puzzles, combat, enemy and
boss roster, progression, collectibles and production scope. The user welcomes design
suggestions and iterative refinement while the plan is developed.

### Genre and trilogy structure — working direction

- Aster's game is intended to use Metroidvania-style exploration, but its exact map,
  chapter count and ability-gated progression remain flexible.
- Orion's game is intended to be a shorter escape story, provisionally one or two
  chapters. It should continue Aster's cliffhanger and deepen their friendship.
- The finale, **Echoes of the Aether: The Lost Echoes**, may use six chapters. This is
  an early idea to revisit after Aster's story is complete.
- Foreshadowing should connect the separate releases into one unfolding saga and give
  players reasons to look forward to later games. The amount and placement of clues
  remain open.

### Metroidvania design guide — current direction, flexible

A Metroidvania usually centers on one connected world. The player explores, finds new
abilities or tools, then uses them to reach places that were previously inaccessible.
Returning to a familiar region should reveal a new path, shortcut, story clue or useful
reward, so backtracking feels purposeful.

For Aster, a possible fit is to make the dungeon a connected set of distinct regions
with shortcuts and landmarks. Echo Rewind can support traversal and puzzle ideas once
Aster acquires it, but the core route should remain playable before he finds it. New
routes can also open through keys, repaired mechanisms, environmental changes or
knowledge learned from clues. These are options to explore, not confirmed mechanics.

Multiple mini-bosses can test individual skills or introduce enemy patterns throughout
the journey, while major bosses mark important story turns. Bosses, puzzles and
foreshadowing should build on what the player has learned, and the map should make the
main objective legible without removing the pleasure of discovery.

### Player flow and puzzle goals — recommendations to refine together

The user wants a story-based game that rewards exploration, experience and thinking.
Puzzles should feel challenging without becoming frustrating. A possible repeatable
player loop is:

1. Explore a connected region and notice a blocked route, unusual landmark or story
   clue.
2. Gather information or an item: for example, a map fragment, key, relic, inscription
   or mechanism part.
3. Use clues from the environment and earlier discoveries to choose a route or solve a
   puzzle.
4. Face enemies or a mini-boss that tests movement, combat and any newly learned idea.
5. Reach a new area, shortcut, reward or story reveal that changes how the player
   understands the dungeon.

Possible path gates include keys, missing map pieces, relics, repaired mechanisms,
ability-based traversal and puzzles. These should serve the world and story, rather than
exist only to delay progress. Collectibles should have clear value: map information,
Echo resources, equipment or skill upgrades, relic lore, or clues that foreshadow the
later games.

For word-sequence or route puzzles, teach the player how to read the clues before
asking for a difficult inference. A wrong answer can reset the local puzzle or send the
player to a nearby checkpoint, but should communicate what went wrong and avoid making
them repeat a long section without new information. Difficulty can rise through more
clues to combine, less direct hints and multi-step reasoning, with optional hints or
easier retries if playtesting shows players are stuck.

The user is considering story-based sub-stories and different endings for the final
game. This remains a later-game possibility; decide it after the main trilogy story and
Aster's game are developed.

### Core world-design principle: the world itself is a puzzle

The user's central design direction is that the whole dungeon—not only specific quest
rooms—should function as one interconnected puzzle. Aster must observe and understand
the dungeon's structure and history in order to find a way out. Locations, routes,
architecture, relics, creatures and Echo behavior should all contribute clues to how
the world works.

Design implications and suggestions:

- Give the dungeon a consistent underlying logic. Repeated symbols, materials,
  mechanisms, Echo flows and architectural changes should teach the player how its
  ancient systems fit together.
- Make geography carry information. Landmarks, sightlines, shifted corridors and
  connections between regions can help the player build a mental model and recognize
  where the Echo Warp has changed the dungeon.
- Make local puzzles part of larger systems. Restoring one mechanism might change
  lights, water, lifts or doors elsewhere, helping the player understand cause and
  effect across the map.
- Let optional lore deepen the explanation, while critical route clues remain
  discoverable enough to complete the main escape story.
- Let enemy behavior and environmental effects reveal rules too: where Echoes collect,
  what creatures seek, which areas are unstable, and what changes after a mechanism is
  activated.
- Tie discoveries to story questions: why the relic was protected, how the two dungeons
  became connected, what the Echo Warp changed, and which structures could offer Aster
  a route onward.
- Track a world-level clue chain alongside the area puzzles. Each region should give
  the player at least one piece of evidence that changes their understanding of the
  larger dungeon mystery or escape route.

This should feel like exploration and deduction rather than a literal riddle in every
room. Keep the world mystery, its answers and the exact escape method open for
collaborative design.

### How to build the world and its puzzles — design method

The creator's current contribution is the main story and trilogy direction. Detailed
world building, map layout, puzzle design and moment-to-moment game flow are to be
developed collaboratively from that foundation; the user welcomes practical proposals.

For each story beat, propose a game area by answering: what happened here, who built
or uses it, what the player is trying to do, what clue draws Aster forward, what blocks
the route, and what discovery or reward makes the visit matter? This keeps places,
puzzles and collectibles connected to the story instead of feeling randomly placed.

Introduce puzzles through landmarks and understandable environmental clues. A reliable
pattern is: notice a clue, work out what it refers to, test an idea, receive clear
feedback, and see the world respond. Puzzle solutions should be inferable from evidence
in the area or from something the player learned earlier. A multi-step word or symbol
sequence can be challenging, but the player should be able to recover locally after a
mistake and understand enough to try differently.

Develop the game in layers: first establish Aster's beginning-to-ending story; then
divide it into major dramatic beats; turn those beats into regions and connections;
place exploration, puzzles, combat, mini-bosses, collectibles and story clues in those
regions; then review pacing, difficulty and scope before production. The user can focus
on story choices while the assistant proposes implementation-ready game-design options
for review.

### Aster's world and route — current canon layout, editable during development

This is the current layout established in the conversation. Names are descriptive
working names. The creator can revise this layout as story and production develop.

#### World concept

Use the guild town on Eldara as a small, safe hub and the dungeon below it as the main
interconnected game world. The dungeon is a vast constructed ecosystem, with open-air
biomes, ruins and relic sites rather than a sequence of cave corridors. It has a
believable purpose: ancient builders made layered chambers and defended routes to
preserve powerful relics. Modern hunters use accessible outer areas for expeditions and
trade the valuable finds through the guild.

When the Echo Warp happens, it folds paths from Veraya's dungeon into Eldara's dungeon.
It does not merge the planets. Initially this can appear as impossible doorways,
overlapping architecture and unfamiliar enemy traces. Later the player can explore a
connected region from the other dungeon, foreshadowing Orion and the wider crisis.

#### Opening sequence — Guild Town to the dungeon

The following is a proposed opening sequence for review, not a locked script or level:

1. **Establish the town.** A short cinematic shows a normal day in Eldara's guild town.
   Show hunters returning from expeditions, trading monster loot and preparing gear.
   This gives context for Aster's profession and the dungeon economy without a long
   lore speech.
2. **Introduce Aster through action.** Let the player see that Aster is an experienced
   hunter: he prepares his equipment, recognizes signs of danger and handles a small
   practical task confidently. Keep his orphan background for a quieter optional
   conversation or later reveal rather than front-loading exposition.
3. **Present the relic lead.** Aster hears that the dungeon may hold the legendary
   Echo Rewind relic. An old expedition record or a returning hunter's account says a
   famous team reached a space-time-distorted area but could not reach the relic.
   Aster decides to investigate because dungeons have yielded relics before.
4. **Prepare and leave.** Give the player a brief choice of starting equipment or a
   simple gear check, then show Aster setting out alone. Do not imply Echo Rewind is
   already available.
5. **Teach movement safely.** In the first dungeon approach, use a low-risk route to
   teach jumping, climbing or interacting, based on the eventual controller. Use
   landmarks to show the route back and the deeper route forward.
6. **Introduce the first environmental puzzle.** A path is blocked by a mechanism
   built for a clear purpose, such as an old bridge lift. Nearby markings and the
   machine's state indicate what is missing. Aster finds a loose power part or reroutes
   a nearby Echo channel, tries the mechanism, and sees the bridge respond. Keep this
   first puzzle short and safe; later puzzles can combine clues and steps.
7. **Introduce combat and Echo collection.** Place a small encounter after a rest point.
   Teach one enemy tell, one dodge or defense response, and one attack opportunity.
   When Aster defeats an Echo-bearing creature, show Echoes being collected and how
   they power his equipment through controlled release.
8. **End the opening route on a discovery.** Aster reaches a mapped hunting area, finds
   evidence that the relic rumor is real, and sees a deeper route blocked by a larger
   guardian or unstable mechanism. This points into the next dungeon region without
   revealing Echo Rewind too early.

**Why this opening works:** the player learns who Aster is by watching what he does,
understands why he enters the dungeon, practices movement, puzzle solving and combat in
low-risk situations, and sees the first story mystery in the environment.

**Pacing suggestion:** keep the opening cinematic brief, move into playable control
early, and alternate tutorial moments with exploration. Avoid stacking a puzzle, combat
arena and long exposition in the same first room.

#### First dungeon route — room-by-room proposal

This route expands the opening sequence into a first playable slice. It is designed to
teach the player the dungeon's language while already offering a real deduction. Room
names and mechanisms are placeholders.

| Order | Room | What Aster does | Clue, challenge or reward |
|---|---|---|---|
| 1 | **Dungeon Mouth** | Enters from the Outer Wilds and sees the main route descend. A safe side alcove shows the return landmark. | Establishes the dungeon's scale and a clear forward direction. No forced combat. |
| 2 | **Hunter's Trail** | Crosses a short traversal section and fights one common Echo-bearing monster. | Teaches the enemy's attack tell, dodge timing and how released Echo energy is collected. |
| 3 | **Old Survey Camp** | Finds traces of earlier hunters and the first torn map piece. | A note and marked wall describe the legendary team's last known route and warn that their compass readings stopped matching the surroundings. |
| 4 | **The Split Walk** | Reaches a visible fork. One branch leads toward the relic route; the other ends at a sealed shortcut that can be opened from the far side. | Makes the connected-map idea legible. Exploring the side branch yields a mechanism part and opens a shortcut back to the camp. |
| 5 | **Echo Sluice** | Reconstructs how to power an old bridge mechanism using environmental clues, then activates it. | Main puzzle of this slice; see the proposed solution below. A nearby checkpoint keeps retries local. |
| 6 | **The Rootspan** | Crosses the restored bridge through a living, open-air dungeon space. | A breather and vista show that the dungeon contains varied environments, not only caves. A hidden optional cache rewards exploration. |
| 7 | **Relic Watch** | Fights a stronger enemy or mini-boss guarding the next route. | Tests the combat cues learned earlier, with a safe approach and visible attack tells. |
| 8 | **Survey Vault** | Finds the rest of the map or a route chart and sees the next destination. | Chapter-one objective: a map points toward Echo Rewind's location. The route ahead is visibly unstable, foreshadowing the warp. |

##### Echo Sluice puzzle — challenge proposal

**Goal:** restore the bridge by routing Echo flow through three conductors in the
correct order. The sequence is not guessed from a single hidden switch; it is deduced
from evidence collected in the room and nearby camp.

1. At the sluice, Aster finds three inactive conductors marked with distinct symbols.
   A damaged diagram on the control plinth shows that the center conductor must be
   activated last, but its first two symbols are missing.
2. A wall relief depicts the same symbols beside three landmarks visible through the
   room: a root arch, a hanging bell and a split stone. Their order in the relief
   supplies the sequence for the first two conductors.
3. A nearby Echo pulse repeats the sequence as a short light pattern. The pulse confirms
   the order but does not solve it automatically; the player has to match the symbols.
4. The working solution is **Root Arch → Hanging Bell → Split Stone**. The first two
   order clues come from the relief; the plinth states that Split Stone (the center
   conductor) must be activated last. Aster activates the conductors in that order. A
   correct sequence restores the bridge and
   opens a route loop. An incorrect sequence shuts down only this mechanism briefly,
   then lets him retry; feedback identifies which step was inconsistent with the clue.

The room can be made harder by obscuring one clue behind an optional side route or by
combining a visual clue with the pulse pattern. Keep the full solution inferable before
the player commits. Avoid making the first substantial puzzle depend on an arbitrary
password or a long walk back to the start.

##### Map and collectible proposal

- **Critical-path map piece:** found at the old survey camp or in the Survey Vault; it
  records known routes and adds the next destination to Aster's map. It should not be
  missable if it is required to finish the chapter.
- **Optional map scraps:** reveal side paths, caches or a shortcut. Missing one should
  not block the main story.
- **Echoes:** gathered from defeated creatures and used to power equipment through
  controlled release, per the established system direction.
- **Monster materials:** possible crafting or upgrade ingredients; the actual economy
  and upgrade choices remain to be designed.
- **Relic records:** optional or tucked along the critical path; each can hint at the
  legendary team's expedition, the time distortion or the ancient civilization.

This slice should introduce one route loop, one main multi-clue puzzle, one safe
checkpoint, one common enemy pattern, one stronger encounter and one meaningful map
reward. More complexity can be layered on after this foundation is approved and
playtested.

##### Common enemy and AI — example

**Placeholder name: Echo Forager.** A small dungeon creature that feeds on loose Echo
energy. Its job is to teach observation, spacing and attack timing before Aster faces
larger enemies.

- **Idle/patrol:** wanders a short route and pauses to feed near Echo residue.
- **Notice:** turns toward Aster when he enters a visible range; a distinctive sound or
  animation warns that it noticed him.
- **Approach:** closes distance while staying on the ground; it does not track through
  walls or know Aster's location after losing sight.
- **Telegraph:** crouches and gathers Echo light for a brief readable moment.
- **Attack:** lunges once toward Aster's last seen position.
- **Recovery:** lands, pauses, and can be hit. If it misses, the pause gives Aster a
  clear opportunity.
- **Return/defeat:** if Aster escapes, it searches briefly near the last seen position
  then returns to its route; if defeated, it releases the Echoes it held.

This can be implemented as a small finite-state machine: **Patrol → Notice → Approach
→ Telegraph → Lunge → Recover → Patrol**. The important design rule is that the enemy
uses a short warning and attacks a remembered position rather than secretly tracking
Aster through the whole move. Its exact name, appearance, health and damage are open.

##### First mini-boss — example mechanics

**Placeholder name: Sluice Warden.** A stone-and-metal guardian positioned at the
Relic Watch arena. This is a proposed first major encounter, not an approved boss.
It teaches the player to read repeated attacks and punish recovery windows; it does
not require Echo Rewind.

1. **Arena read:** a clear, mostly flat space with safe footing, a checkpoint nearby
   and room to move around the guardian.
2. **Tracking:** the guardian turns or steps toward Aster, then commits to one attack.
   It cannot rotate instantly while an attack is underway.
3. **Heavy slam:** it raises one arm for about a second, marked by a sound and visible
   motion, then slams the ground. A low shockwave travels along the floor; Aster can
   jump over it or move to a safe position.
4. **Recovery:** the guardian's arm lodges in the floor and its Echo core becomes
   visible. This is the main damage window.
5. **Repeat with variation:** at low health, it can chain two slower slams with clear
   pauses between them. Change the rhythm, not the readability. Avoid surprise damage
   from off-screen attacks in this introductory fight.
6. **Defeat:** the guardian powers down and releases Echoes. The opened route leads
   toward the next story clue.

**AI states:** **Guard → Track → Wind-up → Slam → Stuck/Recovery → Guard**, with
**Stagger** and **Defeated** as interrupt/end states. Use the same visible wind-up each
time, and make the slam timing consistent enough to learn. Later bosses can layer in
space-time attacks, off-screen origins or time shifts after the game has taught the
player how to read danger.

If this fight feels too simple in playtesting, add a new pattern only after the base
slam is understood. If it feels too demanding, lengthen the tell or recovery window
before reducing player damage or inflating boss health.

#### Suggested area sequence and connections

| Placeholder area | Story and play purpose | Possible discoveries |
|---|---|---|
| **Guild Town** | Cinematic opening, establish Aster as an experienced hunter, hear the relic rumor, prepare for the expedition. Safe hub for return visits if useful. | Guild notices, expedition records, a past team's report about the time-distorted relic route. |
| **Outer Wilds** | First playable dungeon approach with living spaces, a clear route, basic traversal and low-risk combat. Establish that the dungeon is more than caves. | Common Echo-bearing creatures, salvage, first map marks. |
| **Hunter's Reach** | A known expedition area where Aster's hunting skill is visible. Introduce optional loops and a first mini-boss. | Monster drops, hunter traces and environmental clues. |
| **Reliquary Works** | Ancient mechanisms and guarded relic storage; introduce readable machinery puzzles and a chapter-one mid-boss. The chapter-ending map/clue points toward Echo Rewind. | Map fragment, relic inscriptions, mechanism keys. |
| **Warped Verge** | Chapter-two route where Eldara and Veraya dungeon structures begin to overlap. Stronger monsters show the consequences of the merge. | Unfamiliar architecture and clues to Orion's planet. |
| **Echo Rewind Sanctuary** | Destination indicated by the map. A major guardian encounter tests skills learned so far; Aster obtains Echo Rewind at the end of the chapter. | Echo Rewind relic and its origin clues. |
| **Folded Depths** | Chapter-three region designed around space-time instability. Echo Rewind supports new traversal and puzzle combinations. | Evidence of the warp's ancient cause and enemy displacement. |
| **Final Vault and Broken Gate** | Final boss with space-time attacks, then the warp-damaged final gate Aster cannot open. End on the established cliffhanger. | Foreshadowing of the ancient world and the Echoes' fate, without resolving Orion's rescue. |

These can be combined, split or reordered after the story beats and estimated playtime
are mapped. A practical first Metroidvania blockout is a small number of memorable
regions connected by loops and shortcuts, with one clear main route and optional
branches that reconnect. Avoid requiring Echo Rewind before Aster obtains it.

#### Suggested gate, clue and reward rules

- Put the reason for each obstacle in the world: a sealed relic vault, collapsed bridge,
  unpowered lift, dangerous guardian, or warp-distorted passage.
- Teach a puzzle idea in a low-pressure place before asking the player to use it under
  combat or time pressure.
- Use environmental clues (symbols, murals, machine behavior, enemy movement, light or
  sound) to point to solutions. Let the map record major landmarks and locked routes.
- Use keys and mechanism parts for local gates; use map fragments and inscriptions to
  guide routes or reveal lore; use Echoes as a resource; use gear and skill materials to
  support build choices. Avoid collectible types that have no clear use or story value.
- Make major routes readable through landmarks and a visible destination. Optional
  branches can contain upgrades, lore, extra relics or mini-bosses.
- Wrong puzzle inputs should reset the nearby mechanism and provide interpretable
  feedback. Reserve a full return to the beginning for a clearly signposted, deliberate
  challenge where the player keeps enough knowledge to make a new attempt.
- Place a safe rest or checkpoint before demanding boss fights. Follow intense combat
  with a breather, story reveal or exploration reward.

#### Story-to-gameplay rhythm

For each major region, alternate exploration and story discovery with combat spikes:
introduce a danger or clue, let Aster investigate, teach a new enemy or puzzle pattern,
build toward a mini-boss or major encounter, then give a safe moment to understand what
changed. This can create a cinematic-feeling story through playable scenes and
environmental reveals without requiring every beat to be a long cutscene.

Bosses can each reveal a piece of the dungeon's history or the consequences of the
Echo Warp. Mini-bosses should have distinct readable behaviors, with optional encounters
rewarding curiosity. The main boss belongs before the final gate as already proposed.
Names, number, exact abilities and story roles remain undecided.

### Confirmed story premise

- The setting is a spacefaring universe whose civilizations and technology depend on
  Echo technology, as described in the existing canon and GDD.
- Aster's first game begins on his home planet. Beneath it is a dungeon where citizens
  hunt monsters, earn rewards and sell their finds through guilds. The intended appeal
  includes the dungeon-hunting and guild-adventure feel of isekai anime.
- Orion is on a different planet, with a separate dungeon.
- Aster's planet is **Eldara**. Orion's planet is **Veraya**.
- An Echo warp causes space-time distortion that merges the two planets' dungeons. The
  planets and dimensions themselves do not merge. The merge makes monsters inside the
  connected dungeon stronger and forms the central lore connection between Aster's and
  Orion's stories.
- Aster's powers are already described in the existing GDD. Use that material as a
  reference for this new direction; do not replace or redefine his powers in this
  brief. One confirmed change in this new story is that Aster does not begin with Echo
  Rewind: he obtains it around the middle of his game. Adapt other established powers
  to single-player only when needed, and record any open adaptation separately for
  discussion.

The precise causes, timing and mechanics of the Echo warp, the dungeon's origin, and
the way the dungeon merger leads into the third co-op game remain open.

### Aster's story: current outline

- Aster is already an experienced and talented hunter when the first game begins.
- Orphaned as a child after his parents died, he grew up in an orphanage. Seeing the
  hunters around him inspired him to train and become a hunter himself.
- He is skilled with combat training and varied equipment, potentially including
  swords and guns. The exact starting loadout and combat progression are open.
- The opening is an animated, cinematic introduction in town on an otherwise normal
  day. Aster hears rumors of a legendary relic in the dungeon that can manipulate time,
  then enters on an expedition to find it. Dungeons are known to yield valuable relics,
  so Aster believes this legendary relic could truly be inside. A legendary adventuring
  team once reached a place near the relic but failed to obtain it because of the
  space-time distortion.
- During his expedition, the Echo warp merges the dungeons and seals the entrance,
  trapping Aster inside. The merged dungeon is an expansive world with environments
  such as trees and open sky, rather than only a network of cave tunnels.
- Aster's central goal becomes finding a way out. The relic he finds is the Echo
  Rewind device, which grants him that ability around the middle of the game. Before
  finding it, he does not have Echo Rewind.
- He fights monsters within the dungeon and gathers Echoes from them. The detailed
  rules for Echo collection and use should be drawn from the relevant existing system
  material and reviewed for this story.
- Dungeon enemies can include relic-like mechanical or stone constructs, such as stone,
  metal and mithril golems; larger monsters and challenging bosses are part of the
  intended combat experience. Specific enemy roster and boss encounters remain open.
- Hunter progression should include skills improving over time and loot recovered from
  defeated monsters. Exact skill, equipment and loot systems remain open.
- Aster reaches the final dungeon and cannot open its broken final gate. He remains
  trapped there, unable to get out on his own. This is the specific cliffhanger ending
  of Aster's game and the direct story handoff to Orion's game. The exact reason the
  gate is broken and what makes it impossible for Aster to open remain to be developed.

The Echo warp is already described in the existing GDD. The current story direction
attributes the warp activity to the ancient civilization on the planet; after that
civilization's presence or activity, Echo warps began occurring frequently and
randomly. The planet has not yet been named. The precise ancient cause and how it
produces the current dungeon merger remain open.

### Orion's story and the connection to co-op

- Orion's game takes place on a different planet and follows his own story and
  perspective on the dungeon crisis. Orion also enters a dungeon and is trapped when
  an Echo warp occurs.
- Orion is the player-controlled protagonist of his game. Aster appears as a non-player
  character ally who accompanies Orion and fights alongside him; the player does not
  control Aster in this game.
- Orion is an experienced engineer and strategist. Those strengths make him able to
  understand the dungeon situation and help Aster escape where Aster cannot solve it
  alone.
- Both characters help each other escape the merged dungeon. Orion uses engineering,
  strategic thinking and puzzle solving to open the final gate where Aster is trapped;
  Aster fights as Orion's ally. Their cooperation and growing friendship form the
  ending of Orion's game.
- By the end of Orion's game, Aster and Orion become close friends and begin their
  journey together. The later co-op game continues from their partnership.
- The exact timing of the dungeon merger relative to each game's events, how the
  separate dungeons connect, the specific gate puzzle and escape plan, and the details
  of their journey remain open.

## Second game: Orion

- Orion is the central character of the second, single-player game.
- Its gameplay and story should be developed for one player.
- Its chronology and relationship to Aster's game remain open.

## Third game: co-op

- The third game places Aster and Orion together in a cooperative experience.
- The existing co-op canon may provide useful source material for this game, after
  review during its development.
- The co-op game's mechanics, technical implementation and relationship to the first
  two games remain open.

## Working rule for future updates

As new decisions are made in conversation, add or revise them in this document. Keep
the existing canon and GDD unchanged unless the user separately asks to reconcile or
revise those older documents. Mark undecided details as open rather than filling them
in by assumption.

## Confirmed names and working title

- Aster's planet: **Eldara**.
- Orion's planet: **Veraya**.
- The first game's working title is **Echoes of the Aether: Aster**.
- The second game's working title is **Echoes of the Aether: Orion**.
- The user currently refers to the third game as **Echoes of the Aether**. Its story
  focuses on the Echoes trapped on the planet of the ancient civilization; that planet
  is not yet named.

### Preferred working subtitle for the third game

The user responded positively to **Echoes of the Aether: The Lost Echoes** as the
third game's title. Treat this as the preferred working title, subject to revision.

### Ancient planet name — preferred working name

The ancient planet where the trapped Echoes are found has the preferred working name
**Nalora**, the user's chosen spelling. It remains open to revision.

Other options, not selected: **Ilythra** and **Vaelith**.

## Finale story: current outline

The following plot details were provided by the user and are part of the new working
direction. They expand the earlier outline; the older GDD and canon remain untouched.

### Nalora and the ancient civilization

- Aster and Orion decide to search for Nalora after learning about the power of
  legendary relics. Nalora is rumored to be the ancient planet where those relics were
  created. The planet's existence is uncertain and nobody they know has seen it.
- The ancient civilization made powerful relics and spread them to other peoples across
  the universe. Relics were left within dungeons as significant keepsakes or memorials,
  and the dungeons also protect them.
- Nalora is at the edge of the known universe. Aster and Orion find it during their
  expedition and expect to find inhabitants, but discover a world occupied by monsters.
- The ancient civilization attempted a project to gather Echoes from across the
  universe onto Nalora. The project failed. The large concentration of Echoes caused
  Echo Warp: a space-time distortion likened to a black hole.
- The Echo Warp displaced the ancient people from Nalora across space, killing many.
  Some reached other worlds but were killed by the overwhelming number of aliens.
  The civilization was largely wiped out; whether descendants or other survivors
  remain is deliberately open for possible later stories.
- The aliens were displaced from their own, still-unnamed planet to Nalora. They now
  occupy Nalora and consume Echoes to survive. They burn the Echoes outright as an
  energy source, unlike equipment that releases Echoes and converts the released energy
  into power. Their presence and the trapped Echoes make the planet dangerous.

### The Lost Echoes game

- Aster and Orion's expedition to Nalora is the opening premise of the third game,
  currently titled **Echoes of the Aether: The Lost Echoes**.
- Ordinary weapons and equipment are intended to release Echoes in a controlled way,
  converting the released energy into usable power rather than burning up the Echoes.
  Ancient civilization technology demonstrates more efficient Echo use; the heroes'
  understanding of efficient methods develops in the final game. Exact early-game
  efficiency limits and the learning progression remain open.
- They find a broken ship. Their main goal is to solve the ship's related puzzles and
  escape from the planet while facing the monsters and uncovering more relics.
- Aster's only ability is **Echo Rewind**. He does not gain a separate teleportation
  ability in this game.
- In the Orion game, Orion's established ability is **Echo Intel**. He has the concept
  for **Echo Relay**, but is unable to complete it because its space-time teleportation
  is too advanced.
- **Echo Relay** is not a usable ability in the first or second game. Discovering or
  completing it is a quest in the third game, **Echoes of the Aether: The Lost Echoes**.
  Do not describe Echo Relay as Orion's completed ability before that quest or treat
  “Echo Teleport” as a separate ability.
- In **Echoes of the Aether: Orion**, Orion finds or acquires Echo Intel. It helps him
  analyze devices and understand how to repair them. This is the origin intended for
  the new Orion-game direction; older character material describes Echo Intel as an
  established ability, so the new direction supersedes that origin for this trilogy.

The GDD's older story outline does contain a different escape-from-an-ancient-planet
ending, but its story and format conflict with this new three-game direction. This
document preserves the user's newly described finale as current; the old GDD remains
untouched as reference material.

