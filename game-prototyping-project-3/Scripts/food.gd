extends Area2D
class_name Food

var hunger_restored: float = 25
var health_restored: float = 15
var active: bool = true
var lure: bool = false
var lure_timer: float = 5.0
var first_pressed: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.num_food += 1 # TODO: Set this up in base_scene or our game manager instead
	
	if lure:
		$AudioStreamPlayer2D.pitch_scale = randf_range(0.9, 1.1) # Randomize pitch slightly
		$AudioStreamPlayer2D.play()
	
	$AnimationPlayer.play("bounce_small")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if lure_timer > 0:
		lure_timer -= delta
		if lure_timer <= 0:
			lure = false

func consume(eating_creature: Creature):
	if active:
		active = false
		GameState.num_food -= 1 # TODO: Set this up in base_scene or our game manager instead
		eating_creature.change_food(hunger_restored, false)
		eating_creature.change_hit_points(health_restored)
		queue_free()
	pass

func get_lure() -> bool:
	return lure

# Food placed down by players acts as a lure
func lure_creatures() -> void:
	var found_bodies = $LureArea2D.get_overlapping_bodies()
	for body in found_bodies:
		print("Found body")
		if body is Creature:
			# if body.get_food() < 90:
			var fruit = self
			body.send_signal("foodlure", self)
			lure = false
			
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		
		# Clicking on food makes it a lure
		print("Pressed")
		lure = true
		lure_timer = 5.0
		if first_pressed: # Hacky way to avoid bounce on first placement
			first_pressed = false
		else:
			$AudioStreamPlayer2D.pitch_scale = randf_range(0.9, 1.1) # Randomize pitch slightly
			$AudioStreamPlayer2D.play()
			$AnimationPlayer.play("bounce")
