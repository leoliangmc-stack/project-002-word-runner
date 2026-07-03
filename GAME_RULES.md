# GAME_RULES.md

# Word Runner - Game Rules

Version: 1.0

---

# 1. Game Overview

Word Runner is an educational endless runner designed for children aged 5+.

The primary objective is to improve English word recognition through quick decision making.

The player is never required to spell words.

The player only needs to recognize and choose the correct word.

The game should always feel like an action game first and a learning game second.

---

# 2. Core Gameplay Loop

Every round follows exactly the same sequence.

1. Generate Target Word
2. Speak Target Word
3. Spawn Three Gates
4. Player Changes Lane
5. Collision Detection
6. Reward or Penalty
7. Repeat

This loop should never be interrupted except by Pause or Game Over.

---

# 3. Lanes

The player can occupy exactly ONE lane.

There are always THREE lanes.

Lane Index:

0 = Left

1 = Center

2 = Right

Movement is discrete.

No free movement.

No diagonal movement.

No partial lane positions.

---

# 4. Gates

Each obstacle is a Word Gate.

Every gate displays ONE English word.

Exactly ONE gate is correct.

The remaining gates are distractor words.

Example:

LEFT
Apple

CENTER
Dog

RIGHT
Cat

Target:

"Go to Dog!"

Correct gate:

Dog

---

# 5. Target Word

Every round selects ONE target word.

The target word MUST exist in the current vocabulary database.

The target word is spoken before the player reaches the gates.

The spoken word should always be clear.

Example:

Go to Dog!

Find Apple!

Touch Banana!

Only one instruction is allowed per round.

---

# 6. Distractor Rules

Wrong answers should be believable.

Example:

Target

Dog

Good distractors

Cat

Bird

Horse

Poor distractors

Pizza

Blue

Table

Distractors should preferably come from the same category.

---

# 7. Timing

Recommended values

Speak Target

0 sec

Gate Appears

0.5 sec

Reach Time

2.5 sec

Next Round

0.5 sec

These values may change as difficulty increases.

---

# 8. Difficulty

Difficulty increases automatically.

Increase speed gradually.

Increase spawn frequency gradually.

Never increase difficulty suddenly.

The player should feel improvement instead of frustration.

---

# 9. Lives

Player starts with

3 Hearts

Wrong Gate

Lose 1 Heart

Correct Gate

No life change

Maximum Hearts

5

Minimum Hearts

0

At 0 Hearts

Game Over

---

# 10. Score

Correct

+1

Wrong

0

Combo

Optional

Bonus

Optional

High Score

Saved locally

---

# 11. Combo System

Future Feature

Consecutive correct answers may increase:

Score

Visual Effects

Sound Effects

Coins

Combo resets after one mistake.

---

# 12. Categories

Vocabulary is divided into categories.

Examples

Animals

Food

Colors

Vehicles

Body Parts

School

Home

Nature

Only one category should be active in Beginner Mode.

Mixed Mode is unlocked later.

---

# 13. Vocabulary Rules

Each word should contain:

English

Image

Audio

Difficulty Level

Category

Example

{
    "word": "Dog",
    "image": "dog.png",
    "audio": "dog.mp3",
    "category": "Animals",
    "difficulty": 1
}

---

# 14. Audio Rules

Every target word must have audio.

Audio plays BEFORE player decision.

Audio should never overlap.

Do not interrupt current audio.

Queue next audio if necessary.

---

# 15. Visual Rules

Large readable words.

High contrast.

Rounded fonts.

Minimal UI.

No unnecessary text.

Children should recognize information within one second.

---

# 16. Success Feedback

Correct answer should trigger

✔ Happy sound

✔ Green particles

✔ Small camera shake

✔ Score animation

✔ Character smile

Feedback duration

0.5~1.0 sec

---

# 17. Failure Feedback

Wrong answer should trigger

Red flash

Lose one heart

Sad sound

Small shake

Never punish the player excessively.

Failure should feel encouraging.

---

# 18. Endless Mode

Game continues until

Lives == 0

No level ending.

No loading screen.

No interruption.

---

# 19. Pause

Pause should freeze

Player

Spawner

Animation

Physics

Timers

Audio may finish naturally.

---

# 20. Game Over

Conditions

Lives == 0

Display

Final Score

Best Score

Play Again

Home

---

# 21. Accessibility

Designed for children.

Requirements

Large buttons

Simple language

Bright colors

Minimal reading

Fast feedback

No advertisements

No complicated menus

---

# 22. Learning Rules

Learning should always be invisible.

Never display quizzes.

Never display exams.

Never require typing.

The player learns by repeated exposure.

---

# 23. Future Features

Possible additions

Coins

Pets

Daily Rewards

Word Collections

Achievements

Boss Gates

Power-ups

Season Events

Multiplayer Racing

Parents Dashboard

---

# 24. Non-Negotiable Rules

Claude Code must NEVER violate these rules.

Always keep:

Three lanes

One correct gate

Audio before decision

Child-friendly design

Fast gameplay

Simple interaction

Learning through play

Any new feature must remain compatible with these rules.
