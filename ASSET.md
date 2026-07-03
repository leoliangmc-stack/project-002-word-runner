# ASSET.md

# Word Runner - Asset Specification

Version: 1.0

---

# Purpose

This document defines all game assets required for the Word Runner project.

Claude Code must follow this specification when creating scenes, loading resources, and referencing assets.

If an asset does not exist yet, use a placeholder while keeping the same file name and directory structure.

Never hardcode asset paths inside gameplay logic.

---

# Asset Directory Structure

res://
│
├── assets/
│   ├── art/
│   ├── audio/
│   ├── fonts/
│   ├── ui/
│   ├── icons/
│   ├── effects/
│   ├── backgrounds/
│   ├── player/
│   ├── gates/
│   ├── words/
│   └── placeholder/
│
├── data/
│
└── scenes/

---

# Art Style

Style

• Cute
• Colorful
• Friendly
• Simple Shapes
• Rounded Corners
• Cartoon Style

Target Audience

Children aged 5+

Avoid

• Horror
• Dark themes
• Realistic violence
• Sharp edges
• Complex textures

---

# Resolution

Reference Resolution

1920 × 1080

Scaling

Keep all assets scalable.

Do not bake text into images.

Use vectors or high-resolution PNG files whenever possible.

---

# Player Assets

Folder

assets/player/

Required Files

player_idle.png

player_run_01.png

player_run_02.png

player_run_03.png

player_jump.png

player_happy.png

player_sad.png

player_shadow.png

Animation

Idle

Run

Celebrate

Fail

Future

Power-up

Invincible

---

# Word Gate Assets

Folder

assets/gates/

Required

gate_blue.png

gate_green.png

gate_red.png

gate_gold.png

gate_shadow.png

Word labels should NOT be baked into the image.

Words must be rendered dynamically by Godot.

---

# Background Assets

Folder

assets/backgrounds/

Recommended

grass.png

forest.png

desert.png

snow.png

space.png

city.png

Each background should support seamless scrolling.

---

# UI Assets

Folder

assets/ui/

Buttons

button_primary.png

button_secondary.png

button_disabled.png

Panels

panel_large.png

panel_small.png

Progress

progress_bar.png

Slider

slider.png

Checkbox

checkbox_on.png

checkbox_off.png

---

# Icons

Folder

assets/icons/

heart.png

coin.png

star.png

settings.png

pause.png

play.png

home.png

sound.png

music.png

trophy.png

restart.png

next.png

back.png

---

# Effects

Folder

assets/effects/

sparkle.png

explosion.png

success.png

wrong.png

confetti.png

dust.png

trail.png

Glow effects should use transparent PNG.

---

# Word Images

Folder

assets/words/

Each vocabulary item may include an image.

Example

dog.png

cat.png

apple.png

banana.png

bus.png

tree.png

Images should use transparent backgrounds whenever possible.

---

# Audio

Folder

assets/audio/

Subfolders

music/

voice/

sfx/

---

# Background Music

music/

menu.mp3

gameplay.mp3

gameover.mp3

victory.mp3

Requirements

Loop seamlessly.

Soft and cheerful.

Do not distract from spoken words.

---

# Voice Audio

voice/

One audio file per vocabulary word.

Example

dog.mp3

apple.mp3

banana.mp3

cat.mp3

horse.mp3

Requirements

Native English pronunciation.

Slow and clear.

No background noise.

Mono or stereo accepted.

---

# Sound Effects

sfx/

correct.wav

wrong.wav

button.wav

jump.wav

countdown.wav

coin.wav

combo.wav

gameover.wav

pause.wav

resume.wav

All effects should be shorter than one second.

---

# Fonts

Folder

assets/fonts/

Preferred Fonts

Fredoka

Baloo

Nunito

Comic Neue

Requirements

Easy to read.

Rounded.

Suitable for children.

Avoid serif fonts.

---

# Colors

Primary

#4CAF50

Secondary

#42A5F5

Warning

#FFB300

Danger

#F44336

Background

#F5F5F5

Text

#212121

Never use low-contrast text.

---

# Animations

Player

Idle

Run

Celebrate

Hit

Game Over

Gate

Appear

Idle

Glow

Disappear

UI

Button Hover

Button Click

Score Pop

Heart Shake

---

# Placeholder Assets

If production assets are unavailable,

Claude Code should automatically use

assets/placeholder/

Example

placeholder_player.png

placeholder_gate.png

placeholder_background.png

placeholder_icon.png

Gameplay development must never stop because of missing art.

---

# Naming Convention

Use lowercase.

Use underscores.

Good

player_run_01.png

button_primary.png

game_music.mp3

Bad

PlayerRun.PNG

Run1.png

musicFINAL.mp3

---

# File Formats

Images

PNG

Audio

WAV

MP3

Fonts

TTF

OTF

Data

JSON

---

# Optimization Rules

Compress PNG files.

Avoid oversized textures.

Reuse assets whenever possible.

Preload frequently used resources.

Lazy-load large assets.

---

# Asset Loading Rules

Never hardcode resource IDs.

Always use resource paths.

Centralize asset loading through an AssetManager.

Future asset replacements should not require gameplay code changes.

---

# Future Assets

The project may later include

Character skins

Pets

Power-ups

Seasonal themes

Animated backgrounds

Particle packs

Achievements

Sticker collections

Avatar customization

Claude Code should keep the asset structure extensible.

---

# Non-Negotiable Rules

All assets must be

Child-friendly

Readable

Consistent

Optimized

Replaceable

Gameplay code must never depend on temporary placeholder assets.
