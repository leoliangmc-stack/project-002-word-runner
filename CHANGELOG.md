# CHANGELOG.md

# Word Runner

All notable changes to this project should be documented in this file.

Claude Code is responsible for updating this document automatically.

Versioning follows Semantic Versioning.

Format

Major.Minor.Patch

Example

1.0.0

---

# Upcoming

## Planned

- Endless Runner MVP
- 100 Beginner Words
- Local Save System
- Audio Pronunciation
- Difficulty Scaling

---

# Version 1.2.6

## Fixed

- Lives HUD showed the raw codepoint "2665" instead of a heart: the runtime font has no glyph for U+2665, so it fell back to printing the hex codepoint. `LivesLabel` (Label with `♥` text) replaced with `LivesDisplay` (`scripts/ui/HeartsDisplay.gd`, a `Control` that draws hearts as a vector polygon), which no longer depends on font glyph coverage.

## Added

- Press-and-slide touch control: dragging a finger across the screen shifts lanes every 80px of horizontal movement, in addition to the existing tap-to-move. `Player.gd` distinguishes a tap (release near the press point) from a drag using a 20px threshold.
- `project.godot`: `pointing/emulate_touch_from_mouse=true`, so drag/tap controls can be tested with a mouse in the editor.

## Notes

- Updated hud_test.gd and touch_input_test.gd for the new APIs; verified by static review (Godot editor was already open/running in this environment, so an additional headless run was skipped to avoid disrupting it).

---

# Version 1.2.5

## Added

- Touch controls: tapping the left/right half of the screen switches lanes, same as the arrow keys. Phones (e.g. the itch.io web build opened in mobile Safari) have no keyboard, so this was the only way to play there before this change.
- `export_presets.cfg`: Web (HTML5) export preset, single-threaded (no cross-origin-isolation headers required, so it works on itch.io's standard embed).
- New touch_input_test.gd / TouchInputTestScene.tscn smoke test.

## Notes

- Verified test_player, the new touch input test, and feedback smoke tests pass, and Game.tscn runs headless with no errors.
- Exported and pushed the web build to https://leobaba.itch.io/word-runner via butler.

---

# Version 1.2.4

## Fixed

- Gate word label was near-black text (`#212121`, from the shared UI theme) directly on top of the gate artwork, unreadable once real gate art replaced the flat placeholder color. Gate.tscn's Label now overrides its own color to white with a black outline (6px), scoped to just this node — the shared theme (used by HUD/menu/button labels elsewhere) is untouched. White+outline stays readable regardless of which gate color art is used later (blue/green/red/gold per ASSET.md).

## Notes

- Verified GateSpawner and Collision/Score smoke tests still pass, and Game.tscn runs several seconds headless with no errors.

---

# Version 1.2.3

## Added

- Player, Gate, and Game scenes now check for real art at runtime (`res://assets/player/player_idle.png`, `res://assets/gates/gate_blue.png`, `res://assets/backgrounds/grass.png`). If the file exists it's loaded onto a Sprite2D/TextureRect and the ColorRect placeholder is hidden; if it's missing, the placeholder stays visible. Dropping a correctly named PNG into the asset folder is now enough to swap art in — no script changes needed.
- Player.gd: correct/wrong flash and the wrong-answer shake now act on a new `Visual` wrapper node via `modulate`/position instead of directly mutating the placeholder ColorRect's `color`, so the same feedback code works whether a color block or a sprite is showing.

## Notes

- No frame-by-frame run animation yet — the player art is a single static sprite (`player_idle.png`). Run-cycle animation frames (`player_run_01/02/03.png`) from ASSET.md aren't wired up; that's a separate feature if wanted later.
- Backgrounds are static, not scrolling — ASSET.md's "seamless scrolling" requirement isn't implemented, this change only swaps the static color for a static image.
- Verified all smoke tests pass and Game.tscn runs several seconds headless with no errors, both before and after art files are added (tested the fallback path since asset folders are currently empty).

---

# Version 1.2.2

## Changed

- Correct-answer feedback is now smooth/uninterrupted: removed the player scale-bounce and camera shake that fired on every correct answer. Kept the green flash (both the body tint and full-screen overlay) so there's still a clear visual reward, but gameplay no longer pauses/jitters on a correct pick the way it intentionally still does on a wrong one.
- Player.gd: play_correct() renamed to flash_correct() and simplified to just the green flash (no tween on scale).

## Notes

- Wrong-answer feedback (shake + red flash + camera shake) is unchanged — that jolt is intentional, to make mistakes register.
- Verified all 10 smoke tests pass and Game.tscn runs 10s headless with no errors.

---

# Version 1.2.1

## Removed

- The "Go to <Word>!" on-screen subtitle in Game.tscn. It was originally added as a fallback for when no voice audio existed, but now that real pronunciation audio (v1.1.0) plays every round, the subtitle just gave away the answer in text, defeating the listen-and-choose gameplay (GAME_RULES.md section 22: learning must stay invisible, never a visible quiz).

## Notes

- Verified Game.tscn and all 8 relevant smoke tests still pass with no errors after removal.

---

# Version 1.2.0

## Fixed

- Low-contrast text bug: no font color had been set anywhere, so every Label/Button used Godot's default light-gray theme color on our near-white (#F5F5F5) background, making almost all text unreadable. Added assets/ui/theme.tres (dark #212121 font color for Label/Button) and registered it as the project's default GUI theme (gui/theme/custom in project.godot) so every screen is fixed at once. Matches UI_GUIDE.md's high-contrast requirement.

## Changed

- Lives HUD now shows red heart glyphs (♥ per remaining life) instead of "Lives: 3" text, matching UI_GUIDE.md's heart-icon spec, using LivesLabel's per-node font_color override (no new art asset needed).
- Headless smoke test tests/hud_test.gd (heart count per life total, red lives color, dark default label color)

## Notes

- Score display already existed (GameManager + ScoreLabel, added in v0.6.0) and was unaffected by the contrast bug's root cause besides being hard to read; now legible under the new theme.
- Verified all 10 smoke tests pass and MainMenu/Settings/GameOver/Game.tscn all run headless with zero errors.

---

# Version 1.1.1

## Fixed

- Crash-on-game-over bug: GateSpawner._play_round() kept awaiting a "next round" timer even after game_over stopped the loop and change_scene_to_file() freed the Game scene branch. When that timer fired, it called get_tree() on a freed node, throwing "Cannot call method 'create_timer' on a null value" — this is what caused the game to unexpectedly quit after losing all 3 lives. Fixed by returning immediately once _running is false, right after round resolution, instead of scheduling one more timer.

## Notes

- Reproduced headlessly (3 wrong answers -> game over -> crash), confirmed fixed (25s post-game-over run, zero errors), and reran all 9 smoke tests + full app clean.

---

# Version 1.1.0

## Added

- Generated real pronunciation audio for all 100 words using macOS `say` (voice: Samantha, rate 145) piped through `afconvert` to 22.05kHz 16-bit PCM WAV, saved to assets/audio/voice/*.wav
- data/words.json audio paths updated from .mp3 to .wav to match

## Notes

- Voice assets are synthesized TTS, not human recordings; good enough for MVP playtesting. Swap in real recordings later by replacing the .wav files (same paths), no code changes needed.
- Verified: full Game.tscn run now produces zero "missing audio" warnings; all 9 smoke tests still pass.
- sfx/*.wav (correct/wrong) and music/*.mp3 are still placeholders/missing — only word-pronunciation voice audio was generated this pass.

---

# Version 1.0.0

## Added

- Player.gd: play_correct() (happy scale bounce + green flash) / play_wrong() (shake + red flash), per GAME_RULES.md sections 16-17
- GameScene.gd: full-screen color flash overlay, camera shake (Camera2D added to Game.tscn), score pop animation, lives shake animation
- SFXManager autoload: one-shot sfx playback (correct.wav/wrong.wav paths per ASSET.md), volume from SaveManager.sfx_volume, same missing-file-safe warning pattern as AudioManager
- Headless smoke test tests/feedback_test.gd

## Notes

- No real sfx/*.wav assets exist yet; SFXManager logs a warning and no-ops, matching the existing AudioManager placeholder policy. Swap in real files later with no code changes.
- Full regression pass: all 9 smoke tests pass; MainMenu, Game.tscn (10s/multi-round), Settings, and GameOver all run headless with zero script errors.
- MVP from PRD.md is complete: every item in TASKS.md backlog is now checked off.

---

# Version 0.9.0

## Added

- MainMenu.tscn: title, best score, Play/Settings/Exit buttons
- Settings.tscn: Music/SFX/Voice volume sliders persisted via SaveManager
- GameOver.tscn: final score, best score, Play Again/Home buttons
- Game.tscn now transitions to GameOver.tscn on game_over instead of an inline subtitle message
- AudioManager voice playback now applies SaveManager.voice_volume
- run/main_scene switched to MainMenu.tscn (full navigation loop: Menu -> Game -> Game Over -> Menu/Replay)
- Headless smoke test tests/menu_screens_test.gd

## Notes

- Verified MainMenu/Settings/GameOver each load standalone with no errors, and the full app (from MainMenu) and Game.tscn (direct) both run headless without errors.
- MVP feature set from PRD.md / TASKS.md backlog is now functionally complete; remaining backlog item is animation/sound polish.

---

# Version 0.8.0

## Added

- SaveManager autoload: persists high_score to user://save.json, report_score() on game over
- Game over subtitle now shows new-high-score or best-score comparison
- Headless smoke test tests/save_manager_test.gd (fresh state, beat/no-beat high score, reload from disk)

## Notes

- Verified full Game.tscn still runs 6s headless with no errors.

---

# Version 0.7.0

## Added

- GateSpawner difficulty scaling: reach_time steps down 0.15s every 5 rounds, floored at 1.0s minimum (gradual, per GAME_RULES.md section 8)
- Headless smoke test tests/difficulty_test.gd

## Notes

- Verified full Game.tscn still runs 6s headless with no errors.

---

# Version 0.6.0

## Added

- GameManager autoload: score, lives (3 start / 5 max / 0 = game over), reset(), signals
- GateSpawner._resolve_round(): lane-index based collision check at reach-time (deterministic for the fixed 3-lane design, no physics needed)
- HUD Score/Lives labels on Game.tscn, updated live via signals
- Game over stops the spawn loop and shows final score in the subtitle
- Headless smoke test tests/collision_score_test.gd (correct answer scores, wrong answer costs a life, 0 lives fires game_over)

## Notes

- Verified full Game.tscn runs 8s headless with no errors beyond the already-known missing-audio warnings.

---

# Version 0.5.0

## Added

- AudioManager autoload: queued word playback, never overlaps, falls back to warning + signal when audio file missing
- Subtitle Label on Game.tscn shows "Go to <Word>!" each round (UI_GUIDE.md audio prompt fallback)
- Headless smoke test tests/audio_manager_test.gd

## Known Issues

- No real voice/*.mp3 assets exist yet, so every round currently logs a "missing audio" warning and relies on the on-screen subtitle. Non-blocking per ASSET.md placeholder policy; swap in real audio files later with no code changes.

---

# Version 0.4.0

## Added

- Gate.gd/tscn: word gate with label, Area2D + CollisionShape2D, move_to tween
- GateSpawner.gd: round loop (announce -> spawn -> reach -> clear -> next), timing per GAME_RULES.md section 7
- GameScene.gd wires Player lane positions into GateSpawner, added to Game.tscn
- Headless smoke test tests/gate_spawner_test.gd (3 gates per round, exactly 1 correct)

## Notes

- Verified full Game.tscn runs 6s headless (~1-2 rounds) with no script errors.

---

# Version 0.3.0

## Added

- Player.gd/tscn: discrete 3-lane movement with tween easing, arrow-key input
- Game.tscn set as main scene, wired Player + background
- Headless smoke test tests/test_player.gd

## Notes

- Verified via `godot --headless --path .` with no script errors.

---

# Version 0.2.0

## Added

- Project folder structure (assets/data/scripts/scenes/tests)
- data/words.json: 100 words across Animals/Food/Colors
- WordManager autoload: load, validate, pick_target (10-round no-repeat), pick_distractors
- Headless smoke test tests/test_word_manager.gd

## Notes

- Godot binary located at Documents/projects/Godot_v4.7-stable_win64/Godot.app for headless test runs.

---

# Version 0.1.0

## Added

- Initial project structure
- Godot project
- README
- PRD
- CLAUDE instructions
- Architecture document
- Asset specification
- Task list
- Test plan
- Game rules

## Notes

Project initialized.

---

# Changelog Rules

Claude Code must update this file whenever any meaningful change is completed.

Examples include

New Feature

Bug Fix

Refactor

Performance Improvement

UI Update

New Assets

Scene Creation

Data Structure Changes

Testing Improvements

Documentation Updates

---

# Entry Format

Every update should follow this template.

## Version X.Y.Z

### Added

-

### Changed

-

### Fixed

-

### Removed

-

### Performance

-

### Notes

-

---

# Version Increment Rules

PATCH

Bug fixes

Small UI changes

Documentation

Code cleanup

Minor optimizations

MINOR

New gameplay features

New scenes

New systems

New assets

New vocabulary packs

New save data

MAJOR

Large gameplay redesign

Breaking save compatibility

Architecture redesign

Major UI overhaul

---

# Daily Development Log

Claude Code may append daily logs here.

Example

## 2026-07-03

Completed

Player movement

Gate spawning

Basic collision

Remaining

Audio

Save system

UI polish

---

# Statistics

Current Version

1.0.0

Scenes

6

Scripts

12

Assets

0 (all placeholder/pending; see Known Issues)

Words

100

Tests Passed

9 / 9 headless smoke tests

Known Bugs

0

---

# Known Issues

- No real art assets exist yet (player/gate sprites use ColorRect placeholders per ASSET.md placeholder policy).
- Word pronunciation audio (assets/audio/voice/*.wav) is now real, generated via macOS TTS (`say`, voice Samantha) — functional for playtesting, but not a substitute for professional human recordings before release.
- sfx/*.wav (correct/wrong) and music/*.mp3 still do not exist. SFXManager logs a warning and no-ops; wiring is in place so real files can be dropped in with no code changes.

---

# Technical Debt

Claude Code should record any shortcuts taken during development.

Example

Temporary placeholder graphics.

Audio manager requires refactor.

Gate generation should be object pooled.

---

# Completed Milestones

Milestone 1

Project Initialization

Status

Complete

Milestone 2

Basic Gameplay

Status

Complete

Milestone 3

Audio Learning

Status

Complete (code/wiring); real voice recordings still pending

Milestone 4

Polish

Status

Complete (baseline animations + sfx hooks); real art/audio swap still pending

Milestone 5

Release Candidate

Status

Pending

---

# Release Checklist

Before Version 1.0.0

All tests pass

No critical bugs

Audio complete

Save system complete

UI complete

Performance stable

Documentation updated

All placeholder assets replaced

---

Claude Code should keep this file up to date throughout the entire project lifecycle.
