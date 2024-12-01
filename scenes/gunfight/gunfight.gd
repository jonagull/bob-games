extends Node2D

var is_ready = false
var cube_timer = 0.0
@onready var ready_button = $ReadyButton
@onready var cube = $Cube  # Still used for visual feedback

func _ready():
	ready_button.connect("pressed", Callable(self, "_on_ready_button_pressed"))
	cube.modulate = Color(1, 0, 0)  # Start with red

func _process(delta):
	if is_ready:
		cube_timer -= delta
		if cube_timer <= 0:
			cube.modulate = Color(0, 1, 0)  # Change cube to green when ready
			#is_ready = false

func _input(event):
	if is_ready and event is InputEventMouseButton and event.pressed:
		print("øklasjdfløkajsd")
		# Check if the cube is green
		if cube.modulate == Color(0, 1, 0):
			print("You pressed in time!")
		else:
			print("You pressed too early!")

func _on_ready_button_pressed():
	is_ready = true
	cube_timer = randf_range(1.0, 3.0)  # Randomize when the cube will turn green
