# Aster story runtime integration

Status: integrated working implementation based on approved V2 story/dialogue documents. Direction entries are readable text cards rather than final animated cinematics.

## Runtime files

- `data/story_scenes.json`: sequential dialogue and direction, with stable line IDs.
- `systems/story_sequence.gd`: pausable CanvasLayer presenter. It supports Continue, Skip scene, mouse/touch, Enter/Space and Escape.
- `tests/story_contract.gd`: validates required scenes, stable unique line IDs, text and flag payloads.
- `tests/story_integration_contract.gd`: validates the TOW01 intro, pause/resume, Guild Hall trigger and skip flags.

## Campaign integration

`world/campaign.gd` instantiates `res://systems/story_sequence.gd` above the HUD and connects `sequence_finished(scene_id, set_flags)`. It merges each emitted key/value into `CampaignState.flags` and saves. `play_story(scene_id)` checks the scene completion flag before presentation. The presenter pauses the tree and restores the previous pause state after completion or skip.

Example integration:

```gdscript
story_sequence = load("res://systems/story_sequence.gd").new()
add_child(story_sequence)
story_sequence.sequence_finished.connect(_on_story_finished)

func _on_story_finished(_scene_id: String, updates: Dictionary) -> void:
    for key: String in updates:
        state.flags[key] = updates[key]
    state.save()
```

The campaign triggers `CIN01_TOWN` from TOW01 for a fresh save, and other scenes at the event/record interactions listed below. Completion flags prevent replay when continuing a save. The presenter itself does not implement a browsable dialogue journal.

## Trigger and flag mapping

| Trigger | Scene ID | Completion/progression effect |
|---|---|---|
| Fresh campaign at TOW01 | `CIN01_TOWN` | `INTRO_DONE` |
| Guild Hall TOW03, briefing interaction | `GUILD_BRIEFING` | `BRIEFED` |
| Artificer Yard TOW04, tutorial interaction | `ARTIFICER_TUTORIAL` | `TUTORIAL_DONE` |
| First entry HUN03 when `WARP` is false | `ECHO_WARP` | `WARP`, `WARP_SCENE_SEEN` |
| CAM02 camp record interaction | `SURVEY_CAMP` | `CAMP_RECORD_SEEN` |
| SUR03 archive interaction after vault puzzle | `SURVEY_VAULT` | `VAULT_MAP`, `VAULT_SCENE_SEEN` |
| VER02 record interaction | `VERAYAN_RECORD` | `VERAYAN_RECORD_SEEN` |
| SIL02 memory interaction | `SILENT_GALLERY` | `MEMORIAL_SEEN` |
| RES02 reservoir diagram interaction | `RESERVOIR_RECORD` | `RESERVOIR_RECORD_SEEN` |
| REW03 relic acquisition after P08 | `ECHO_REWIND` | `REWIND_ACQUIRED`, `REWIND_SCENE_SEEN` |
| FOL03 archive fragment interaction | `NALORA_FRAGMENT` | `NALORA_FRAGMENT_SEEN` |
| FIN03 final warning interaction | `FINAL_WARNING` | `FINAL_WARNING_SEEN` |
| GAT01 boss defeated, before leaving arena | `FOLD_GUARDIAN` | `GUARDIAN_SCENE_SEEN` |
| GAT02 gate interaction, after guardian | `BROKEN_GATE` | `GATE_DIAGNOSED` |
| GAT04 distress packet confirmed | `DISTRESS_REFUGE` | `SIGNAL_SENT`, `END_COMPLETE`, `ENDING_SEEN` |

The campaign uses each scene completion flag to prevent repeated playback. Boss defeat
and puzzle completion remain gameplay state. `GATE_DIAGNOSED` is a diagnosis only;
Aster does not escape. `SIGNAL_SENT` is a low-power diagnostic message and does not
reopen the passage. The post-credit message remains anonymous; do not reveal Orion's
name in Aster's game.

## Narrative consistency contract

Validation: `tests/story_contract.gd` checks scene content, line IDs and presenter
behavior; `tests/story_integration_contract.gd` checks the fresh opening, pause/continue,
guild briefing and skip-to-progression behavior.

- Aster is already a capable hunter. Echo Rewind is acquired at the end of Chapter 2, not available at game start.
- The Warp physically damages the exit/remote anchor. Rewind changes Aster's personal state only; it cannot repair the gate, rewind creatures or mechanisms, restore spent Echo Energy, or reduce weapon heat.
- The Collector releases an Echo safely and stores the yielded energy. Weapons spend stored energy and build heat; they do not use ammunition or reload.
- The V2 approved story resolves Aster's hunt, local sanctuary mystery and personal growth, while leaving him trapped. The game ends on his distress packet and refuge, handing off to Orion's game.
- Nalora and the broader Echo Warp origin are only foreshadowed. Aster does not learn the full ancient civilization history here.
- The dialogue strings in the data file use the V2 dialogue baseline. IDs are stable localization handles; text may be revised without changing IDs.

## Implementation staging notes

Direction entries currently appear as readable text cards. Later production can replace them with timed camera movement, character animation and sound without changing scene IDs, flags or the campaign trigger contract. Skip always applies the same flags as viewing the entire sequence. No newly authored dialogue choice changes canon or the story outcome.
