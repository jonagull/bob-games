extends Node2D

@onready var progress_bar = $ProgressBar
@onready var zombie_arm = $ZombieArm
@onready var replay_button = $ReplayButton  # Adjust the path if needed

var progress = 50
var increment = 5
var max_progress = 100
var decrease_rate = 30
var game_won = false

func _ready():
	progress_bar.value = progress
	replay_button.visible = false  # Hide the replay button initially
	replay_button.connect("pressed", Callable(self, "_on_replay_button_pressed"))

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		increase_progress()

func _process(delta):
	if not game_won:
		decrease_progress(delta)
	
	# Update the zombie arm tilt based on progress
	update_arm_tilt()

func increase_progress():
	progress += increment
	progress = clamp(progress, 0, max_progress)
	progress_bar.value = progress

	if progress >= max_progress:
		on_victory()

func decrease_progress(delta):
	progress -= decrease_rate * delta
	progress = clamp(progress, 0, max_progress)
	progress_bar.value = progress

	if progress <= 0:
		on_loss()

func update_arm_tilt():
	var tilt_angle = lerp(-45, 45, float(progress) / max_progress)
	zombie_arm.rotation_degrees = tilt_angle

func on_victory():
	game_won = true
	print("You win!")
	replay_button.visible = true  # Show the replay button


func on_loss():
	if not game_won:
		print("You lose!")

func _on_replay_button_pressed():
	reset_game()

func reset_game():
	# Reset game state
	progress = 0
	progress_bar.value = progress
	game_won = false
	replay_button.visible = false  # Hide the replay button
	print("Game reset.")
