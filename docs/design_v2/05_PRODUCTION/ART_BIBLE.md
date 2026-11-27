# Art bible — pixel-art visual production

**Version:** 2.0 | **Date:** 2026-11-27 | **Status:** Approved V2 direction; implementation details are working specifications

## Direction
2D side-scroll science-fantasy, not medieval magic or military realism. Functional gear, living sanctuary landscape, ancient seamless structures contrasted with modern bolted human additions. Inspired by challenging Metroidvania atmosphere and dungeon anime, never copy protected art, silhouettes or maps. Logical canvas 640×360, 16px tiles, Aster about 32×48, camera pixel snap; sprites at native logical resolution; nearest filtering, integer scaling where possible. Dimensions are prototype targets; test readable hitboxes before locking.

| Biome family | Reused in | Palette / silhouette |
|---|---|---|
| Eldaran frontier | TOW OUT HUN CAM | Warm bronze #A77C50, greenery #88A47D, ropes and angular beams |
| Rootspan waterways | SLU ROT | Moss, bronze, layered water channels, suspended roots |
| Ancient archive | REL SUR SIL | Pale alloy #D6C3A4, curved monumental frames, carved archive marks |
| Warped network | WAR FOL FIN GAT | Slate #202B34, violet #AA85CA, misaligned but readable geometry |
| Verayan annex | VER | Cool steel #7695B7, modular diagnostic stations |
| Reservoir/vault | RES REW | Cyan #56CDC4, flowing conduits and symmetrical vault geometry |

Danger muted red #D56C6C; cyan EE, violet Warp, amber heat warm, striped red overheat. Color never sole signal. Enemy silhouettes unique: quadruped Forager, tall heavy Guard, low Skitter, fixed turret, shield Sentinel, broad Mithril, floating Leech, angular Stalker. Variants share animation bases but distinct shape/material accents. Voruun organic fractured forms, not automatically evil. Boss scale communicates role, not visual clutter.

## Sprite production
Aster layer order body/suit/jacket/harness/armor/gear; compact pack and vents, right-forearm mount inert until relic. Orion lean modular tools, Intel mount inert until II. Source layered sprite project, export PNG strips with stable animation names and frame metadata. Pivot feet centered; weapon muzzle socket and blade hitbox event separate from sprite. Side view aim upper/lower, mirror with hand/socket corrections. Suggested initial frames: idle 6, run 8, jump 4, fall 3, landing 3, mantle 6, dodge 6, aim 4, fire 4, blade 6, heal 6, interact 4, collect/release 4–6, heat warning/cooling 4, Rewind activate 5, playback afterimage effect, exit 4, stagger 3, defeat 8. 8–12 fps animation tuning, physics independent. No reload or shell assets. Enemy attacks show wind-up and recovery, do not obscure marker. VFX: release upward mote and separate cell-fill cyan; heat vent hiss/steam; Rewind personal afterimages only; reduced motion alternative. Keep foreground readable, distant parallax layers muted. Assets from creators or verified licenses only; maintain source/license attribution manifest.

## Cinematic art
Opening town, Warp, archive, memorial, relic, Guardian, gate, refuge/post-credit: reuse gameplay sprites, parallax backgrounds, controlled camera and a few dedicated panels. No full animated film requirement. Prior character art guides in archive retain useful garment, materials and animation references, with timing and heat supersession documented. Final sprites are not included; production checklist tracks their creation.
