# Test Plan

## Functional

- Player changes among exactly three lanes.
- Target word is spoken before gate arrives.
- One gate matches spoken word.
- Correct gate increases score.
- Wrong gate removes one heart.
- Hearts render as heart shapes, not raw codepoint text.
- Game ends at zero hearts.
- Endless mode never soft-locks.
- Tapping a screen half moves one lane; pressing and sliding drags between lanes.

## Performance

- 60 FPS on desktop.
- No memory leaks after 20 minutes.

## Regression

After every feature:
- Run scene.
- Verify previous mechanics still work.
- Fix regressions before continuing.
