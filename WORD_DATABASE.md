# WORD_DATABASE.md

# Word Database Specification

Version: 1.0

---

# Purpose

This document defines the structure of the vocabulary database.

Claude Code must always follow this format.

Every gameplay system should retrieve vocabulary through this specification.

---

# Storage

Location

res://data/words.json

Encoding

UTF-8

Format

JSON

---

# Word Object

Every word must contain:

{
    "id": 1,
    "word": "Dog",
    "category": "Animals",
    "difficulty": 1,
    "image": "assets/words/dog.png",
    "audio": "assets/audio/voice/dog.mp3",
    "enabled": true
}

---

# Required Fields

id

Unique integer

Never reused.

word

English word.

First letter capitalized.

category

Vocabulary category.

difficulty

Integer

1

Easy

2

Medium

3

Hard

image

PNG path

audio

Voice path

enabled

Boolean

---

# Categories

Animals

Food

Colors

Shapes

Numbers

Body Parts

Clothes

School

Home

Nature

Vehicles

Weather

Jobs

Sports

Transportation

Space

Ocean

Fruit

Vegetables

Toys

Actions

Feelings

Family

Time

---

# Beginner Words

Target

100 words

Average length

3–6 letters

Examples

Dog

Cat

Pig

Cow

Apple

Fish

Milk

Red

Blue

Car

Bus

Sun

Moon

Tree

Book

Ball

Cup

Hat

Chair

Duck

---

# Intermediate

Target

500 words

Word length

4–8 letters

Example

Rabbit

Banana

Orange

Kitchen

Teacher

Hospital

Elephant

---

# Advanced

Target

1000+

Example

Helicopter

Backpack

Restaurant

Adventure

Mountain

Umbrella

---

# Difficulty Rules

Level 1

Short words

Common vocabulary

Single object

Level 2

Longer words

Multiple syllables

Level 3

Abstract words

Long words

Less common

---

# Random Selection

The selected word

Must be enabled.

Must belong to the current category.

Should avoid repeating within the previous

10 rounds.

---

# Distractor Selection

Distractors should

Share category

Share difficulty

Avoid identical prefixes when possible.

Example

Target

Dog

Good

Cat

Pig

Cow

Bad

Purple

Computer

Mountain

---

# Audio Rules

Every word must have audio.

Missing audio

Do not use the word.

Log a warning.

---

# Image Rules

Transparent PNG

Square preferred

512 × 512 recommended

---

# Naming Convention

dog.png

dog.mp3

cat.png

cat.mp3

Always lowercase.

---

# Validation Rules

Every word must pass

Unique ID

Unique word

Existing image

Existing audio

Valid category

Valid difficulty

Enabled field exists

---

# Future Fields

Future versions may include

{
    "phonics": "d-o-g",
    "ipa": "/dɔg/",
    "sentence": "The dog runs.",
    "translation": {
        "zh": "狗",
        "ja": "...",
        "es": "..."
    },
    "tags": [
        "animal",
        "pet"
    ]
}

Gameplay should ignore unknown fields.

---

# Database Expansion

Future vocabulary packs

Animals Pack

Food Pack

School Pack

Travel Pack

Science Pack

Space Pack

Dinosaurs Pack

Christmas Pack

Halloween Pack

The core game should support unlimited expansion without changing code.

---

# Quality Rules

No offensive words.

No slang.

No abbreviations.

No proper names.

No copyrighted brand names.

Only age-appropriate vocabulary.

---

# Performance

Load the database once.

Cache in memory.

Never reload every round.

Use IDs internally.

Display words by string only when rendering.

---

# Claude Code Responsibilities

Whenever new vocabulary is added:

Validate JSON.

Validate asset paths.

Validate categories.

Validate duplicate words.

Update statistics if required.

Never break compatibility with existing save data.
