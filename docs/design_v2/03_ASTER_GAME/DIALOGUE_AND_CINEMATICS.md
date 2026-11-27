# Dialogue and cinematics — scene script baseline

**Version:** 2.0 | **Date:** 2026-11-27 | **Status:** Approved V2 direction; implementation details are working specifications

Dialogue here is a newly drafted implementation script consistent with approved plot; line timing and localization remain editable. Critical information appears as gameplay objectives and journal entries too. No full voice acting required; text portraits and audio motifs suffice. Six to eight major short cinematics, other beats in gameplay. Skipping a cinematic applies the same flags and journal records as watching it.

| Scene | Trigger | Direction and dialogue | Gameplay exit |
|---|---|---|---|
| CIN01 Town | New game TOW01 | Hunters return. A release light ascends. Mira: “Back before the lamps go out?” Aster: “It's a familiar route.” Mira: “Familiar isn't safe.” | Control, AR01 journal |
| Talk guild | TOW03 | Garran: “Survey the known route. Take a team if you go deeper.” Riven: “We could see the vault. Every step took us farther away.” Liora: “Match the bell, arch and split rock.” Aster: “I'll find the route.” | BRIEFED, DAWN01 |
| Talk Bram | TOW04 | “The rifle runs on stored Echo Energy. Let the vents breathe. The Echo itself must go free.” Practice fire, wait for cooling, interact with sample. | TUTORIAL_DONE |
| CIN02 Warp | HUN03 | Sound cuts, water reverses momentarily, violet fracture, foreign geometry appears. Aster: “That wasn't here.” Inspect collapse: “The entrance is gone. Beacon's dead.” | WARP, checkpoint |
| Camp | CAM02 | Aster: “The Dawn team saw this before. There has to be a service route.” | Critical landmark record |
| CIN03 Vault | SUR03 | Archive projects relic and gate symbols. Aster: “Personal Continuity Device. And an emergency passage. Both are deeper.” | VAULT_MAP |
| Foreign record | VER02 | Anonymous voice: “The structures aren't moving. The connections between them are changing.” Aster: “Verayan manufacture? How?” | AR12 |
| CIN04 Gallery | SIL02 | Residual scene: parent and child, light fades. Aster remembers orphanage. “A memory. Not a person.” | MEMORIAL_SEEN |
| Reservoir | RES02 | “Supply, release, storage. The last one is already full.” | puzzle prompt |
| CIN05 Relic | REW03 | Record: “Personal continuity device, rescue and research personnel.” Aster attaches device; cyan pulse, steps return. “Just me. Everything else stayed.” | REWIND_ACQUIRED |
| Depths | FOL03 | Fragment: “Convergence center… Nalora… release capacity exceeded…” Aster: “This started somewhere else.” | AR21 |
| Final warning | FIN03 | “When both anchors lose agreement, isolate the passage. Do not force the connection.” | final checkpoint |
| CIN06 Guardian | GAT01 defeat | “Preserve the passage. Protect the living. Release the departed.” Light fades; reserve source available. | GUARDIAN_DOWN |
| CIN07 Gate | GAT02 | Gate attempts opening then stops. Diagnostic: REMOTE ANCHOR INTERFACE FRACTURED. Aster tries Rewind; gate unchanged. “No part. No stable passage. I can't fix this.” | GATE_DIAGNOSED |
| CIN08 Signal/refuge | GAT04 | Distress packet transmitted. Aster makes camp. “I made it this far alone. Maybe that's as far as alone can take me.” Fade, credits. Post-credits: terminal on Veraya, hand reaches. “Survivor detected. Transit anchor failure. Assistance required.” | END_COMPLETE |

Optional lines: inspect a memory “Someone wanted to remember this.” Heat warning “Need to let it cool.” Empty energy “Blade will do.” Rewind blocked “No safe position.” Repeated barks have cooldown and can be muted. Puzzle errors use exact system feedback, not mocking protagonist. Subtitle speaker tags, text speed, history, skip and replay essential scenes via journal after discovery. No later-game exposition in Aster scenes. Scene count includes closing/post-credit as one sequence.
