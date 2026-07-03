# UI_GUIDE.md

# Word Runner UI Design Guide

Version: 1.0

---

# Purpose

This document defines all user interface rules for Word Runner.

Claude Code must follow this guide whenever creating, modifying, or refactoring UI.

The UI is designed for children aged 5+.

Primary goals:

• Fast recognition

• Minimal reading

• Bright visuals

• Immediate feedback

• No unnecessary complexity

---

# Design Philosophy

Children should understand every screen within 3 seconds.

Gameplay should never be interrupted by excessive menus.

UI should remain playful instead of educational.

---

# UI Principles

1.

Large touch targets

Minimum size

64 x 64 px

Preferred

96 x 96 px

---

2.

Minimal Text

Only display text that helps gameplay.

Avoid paragraphs.

Avoid instructions longer than one sentence.

---

3.

High Contrast

Dark text

Bright backgrounds

Avoid grey-on-grey combinations.

---

4.

Rounded Style

Rounded corners

Rounded buttons

Rounded panels

Rounded fonts

No sharp edges.

---

5.

Consistency

Every button should behave the same.

Every popup should have the same animation.

Every icon should use the same visual language.

---

# Screen Flow

Launch

↓

Splash

↓

Main Menu

↓

Category Select

↓

Gameplay

↓

Pause (optional)

↓

Game Over

↓

Results

↓

Play Again

---

# Splash Screen

Duration

2–3 seconds

Display

Logo

Game title

Animated background

No buttons.

---

# Main Menu

Components

Play

Settings

High Score

Exit

Background animation should remain subtle.

---

# Gameplay HUD

Top Left

❤️ Hearts

Top Center

⭐ Score

Top Right

⚙ Pause

Bottom

No UI unless necessary.

The center of the screen should remain clear.

---

# Word Display

Word gates must display

Large

Bold

Centered

One word only

Do not use decorative fonts.

---

# Audio Prompt Display

Optional

Small subtitle

Displayed briefly

Never block gameplay.

---

# Hearts

Represent remaining lives.

Maximum

5

Minimum

0

Animation

Heart shake

Heart fade

Heart pop

---

# Score

Display only the current score.

Do not display unnecessary statistics during gameplay.

---

# Pause Menu

Buttons

Resume

Restart

Settings

Home

Pause background

Blurred gameplay

---

# Settings Screen

Volume

Music

Sound Effects

Voice

Language (future)

Accessibility (future)

---

# Game Over Screen

Display

Final Score

Best Score

Play Again

Home

Celebration animation if new high score.

---

# Buttons

States

Normal

Hover

Pressed

Disabled

All buttons should animate smoothly.

---

# Animations

Buttons

Scale up slightly on hover.

Scale down briefly on click.

Panels

Fade + Slide

Score

Pop animation

Hearts

Bounce

---

# Colors

Primary

Green

Secondary

Blue

Danger

Red

Reward

Gold

Background

Light

Avoid dark themes.

---

# Typography

Recommended

Fredoka

Baloo

Nunito

Minimum gameplay font size

36 px

Buttons

40–48 px

Titles

64–96 px

---

# Icons

Simple

Filled

Rounded

Easy to recognize

Avoid outline-only icons.

---

# Accessibility

Support

Large text

Color-blind friendly contrast

Simple language

Audio reinforcement

---

# Mobile Layout

Safe Area

Respect notches

Respect rounded corners

UI must adapt to

16:9

18:9

19.5:9

Tablet

---

# Feedback Rules

Correct

Green flash

Sparkles

Happy sound

Score pop

Wrong

Red flash

Heart loss

Sad sound

Small screen shake

---

# Performance

UI animations

<300 ms

Popup animation

<500 ms

Menu transitions

<600 ms

---

# Future UI

Daily Rewards

Achievements

Vocabulary Collection

Parent Dashboard

Pet Collection

Shop

Skins

Claude Code should keep UI modular so future screens can be added without redesigning existing layouts.
