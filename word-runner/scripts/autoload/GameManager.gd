extends Node
## Tracks score and lives for the current run. See GAME_RULES.md sections 9, 10.

signal score_changed(new_score: int)
signal lives_changed(new_lives: int)
signal game_over

const MAX_LIVES := 5
const START_LIVES := 3

var score: int = 0
var lives: int = START_LIVES
var is_game_over := false

func reset() -> void:
	score = 0
	lives = START_LIVES
	is_game_over = false
	score_changed.emit(score)
	lives_changed.emit(lives)

func add_score(amount: int = 1) -> void:
	if is_game_over:
		return
	score += amount
	score_changed.emit(score)

func lose_life(amount: int = 1) -> void:
	if is_game_over:
		return
	lives = clampi(lives - amount, 0, MAX_LIVES)
	lives_changed.emit(lives)
	if lives == 0:
		is_game_over = true
		game_over.emit()

func gain_life(amount: int = 1) -> void:
	if is_game_over:
		return
	lives = clampi(lives + amount, 0, MAX_LIVES)
	lives_changed.emit(lives)
