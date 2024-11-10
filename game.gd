extends Node2D

@onready var progress_bar = $ProgressBar
@onready var zombie_arm = $ZombieArm2
@onready var replay_button = $ReplayButton
@onready var start_button = $StartButton  
@onready var start_label = $StartLabel    
@onready var replay_label = $ReplayLabel    
@onready var loss_label = $LossLabel    

var progress = 50  
var increment = 5
var max_progress = 100
var decrease_rate = 30
var game_won = false
var game_started = false  

func _ready():
	progress_bar.value = progress
	progress_bar.visible = false  
	zombie_arm.global_rotation_degrees = -90
	zombie_arm.visible = false     
	replay_button.visible = false  
	replay_label.visible = false
	loss_label.visible = false
	start_button.connect("pressed", Callable(self, "_on_start_button_pressed"))
	replay_button.connect("pressed", Callable(self, "_on_replay_button_pressed"))
	start_label.visible = true     # Show the start label

func _input(event):
	if game_started and event is InputEventMouseButton and event.pressed:
		increase_progress()

func _process(delta):
	if game_started and not game_won:
		decrease_progress(delta)
	
	# Update the zombie arm tilt based on progress
	if game_started:
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
	# Adjust the tilt range from -180 (west, losing) to 0 (upright) as progress changes
	var tilt_angle = lerp(-90, 90, float(progress) / max_progress)
	#var tilt_angle = lerp(-180, 0, float(progress) / max_progress)
	zombie_arm.global_rotation_degrees = tilt_angle

func on_victory():
	game_won = true
	print("You win!")
	replay_button.visible = true  
	replay_label.visible = true  
	
func on_loss():
	if not game_won:
		print("You lose!")
		replay_button.visible = true  
		loss_label.visible = true  
		

func _on_start_button_pressed():
	# Start the game and hide the start button and label
	start_button.visible = false
	start_label.visible = false
	progress_bar.visible = true  # Show progress bar
	zombie_arm.visible = true    # Show zombie arm
	game_started = true

func _on_replay_button_pressed():
	reset_game()

func reset_game():
	# Reset game state
	progress = 50  # Reset to halfway so the arm starts upright
	progress_bar.value = progress
	game_won = false
	game_started = false  # Stop the game from running
	replay_button.visible = false  
	start_button.visible = true    
	start_label.visible = true     
	progress_bar.visible = false   
	replay_label.visible = false     
	zombie_arm.visible = false     
	print("Game reset.")
