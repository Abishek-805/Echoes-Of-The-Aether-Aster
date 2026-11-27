# First authored slice — 2026-11-27

Open project.godot, F5, Begin/Continue Expedition. New Expedition starts fresh. The
original mechanics sandbox remains available as world/sandbox.tscn for regression work.

## Delivered

- Six compressed slice rooms using OUT01, OUT02, CAM02, SLU02, SLU03 and ROT01 IDs.
- Hunter route and combat, inspectable Dawn camp clue, correct P01 sequence, bridge,
  Warden gate, Rootspan endpoint and a Sluice return shortcut to Trailhead.
- Original Aster idle/run/blade sprite drafts; layered PNG source preserved, one palette,
  stable pivot; Forager draft, five background compositions and terrain tile.
- Warden behavior: visible wind-up, ground waves, exposed recovery, double slam phase.
  Warden visuals are still code-drawn placeholders.
- Persistent flags, clue/visit records, unique reward ledger, pending unclaimed boss
  reward, checkpoint return and versioned JSON save with backup recovery in user://.
- Title Begin/Continue/New, gamepad/touch controls and pause inherited from foundation.

## Design scope

This is a compressed first-slice route, not the full V2 64-room graph. It intentionally
omits intervening V2 rooms and P02/map alignment. That does not change the final canon
room graph. No Rewind is available. Town opening, scripted Warp, full Collector
capture/release animation, mantle, healing, audio, final art and the full campaign are
not included yet. Current rooms are simple authored test layouts; wider branches and
more demanding navigation follow movement and art review.

## Review findings

A native Godot screenshot was captured and inspected at art/previews/in_game_camp.png.
Aster and the ground read distinctly; sprite volume and footsteps, backdrop detail,
lighting variation and action poses need additional refinement. These assets are
working visual drafts, not final approved production art. The Warden needs a dedicated
sprite family. Backgrounds are intentionally muted and reuse common architecture;
future rooms need more distinctive landmarks.

## Checks completed

- All 13 scripts compiled; scene/path checker: zero errors/warnings.
- Existing sandbox and platform checks: zero failures.
- Expedition checks: wrong P01 attempt resets locally, exact sequence raises bridge,
  gate conditions, armor/recovery behavior, defeat unlock, no duplicate boss reward,
  pending reward survives reentry, slice endpoint and isolated save/backup recovery.
- Pixel audit: Aster run sheet and Forager pass color limit, alpha, orphan-pixel and
  grid checks. Automated audit is not aesthetic acceptance. Hero contact sheet inspected
  and leg separation revised before integration.

These are targeted automated checks plus a captured-scene inspection, not a complete
human playthrough or mobile/browser performance test. Controls and difficulty need a
hands-on play review before expanding the slice.

## Next batch

1. Refine Aster's silhouette and action poses against V2 and the approved reference.
2. Make a matching Warden sprite/animation set and distinguish the Sluice landmark.
3. Complete Collector capture/release and combat feedback, then tune the actual loop.
4. Add map alignment and authored extra rooms after the slice's feel and visual target
   are accepted. Expand the critical path before optional content.
