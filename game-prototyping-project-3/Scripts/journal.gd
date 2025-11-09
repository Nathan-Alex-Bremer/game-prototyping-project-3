extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# GameState.connect("StateFound", on_state_found)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_state_found(found_state: StringName, times_found: int) -> void:
	# This is such a gross way to do it
	$StatesFound.text = "Found States: " + str(GameState.num_found_states)
	
	match found_state:
		"Wander":
			if times_found == 1:
				$StateWander.text = "- Tends to wander aimlessly."
			if times_found == 15:
				$StateWander.text = "- Tends to wander aimlessly. Rarely, if ever, runs."
			if times_found == 30:
				$StateWander.text = "- When not looking for food, will leisurely patrol their home area."
		"Idle":
			if times_found == 1:
				$StateIdle.text = "- Off-white in color."
			if times_found == 15:
				$StateIdle.text = "- Off-white in color. Around 1’6” in length."
			if times_found == 30:
				$StateIdle.text = "- Off-white in color. Around 1’6” in length. Large, emotive ears."
		"Eat":
			if times_found == 1:
				$StateEat.text = "- Enjoys eating fruit."
			if times_found == 5:
				$StateEat.text = "- Eats primarily fruit. Their favorite is large, red, juicy fruits."
			if times_found == 10:
				$StateEat.text = "- Can eat their entire body weight in fruit a single day."
		"Rest":
			if times_found == 1:
				$StateRest.text = "- Takes short naps every so often to restore energy."
			if times_found == 5:
				$StateRest.text = "- To avoid danger, sleeps only in short bursts."
			if times_found == 10:
				$StateRest.text = "- Their highly efficient bodies can restore plenty of energy from just a short nap."
		"Pet":
			if times_found == 1:
				$StatePet.text = "- Their fur is soft and velvety."
			if times_found == 5:
				$StatePet.text = "- Being pet seems to calm them down. They enjoy it a lot."
			if times_found == 10:
				$StatePet.text = "- Enjoys being pet, particularly being scratched behind the ears."
		"Annoyed":
			if times_found == 1:
				$StatePoke.text = "- Becomes agitated when poked."
			if times_found == 5:
				$StatePoke.text = "- Struggles to sit still when agitated."
			if times_found == 10:
				$StatePoke.text = "- Shockingly short-tempered, even a couple of pokes will whip it into a frenzy."
		"Play":
			if times_found == 1:
				$StatePlay.text = "- Will sometimes jump around and make squeaking noises with others of their species."
			if times_found == 5:
				$StatePlay.text = "- Jumping around with others seems to lower their stress."
			if times_found == 10:
				$StatePlay.text = "- Will play with others of their species by jumping around and making squeaking noises."
		"Chase":
			if times_found == 1:
				$StateChase.text = "- Runs around when agitated."
			if times_found == 5:
				$StateChase.text = "- When agitated, will often seek out and attack others of their kind."
			if times_found == 10:
				$StateChase.text = "- When agitated, will seek out and attack others of their kind until calming down."
		"Attack":
			if times_found == 1:
				$StateAttack.text = "- Fights primarily by biting."
			if times_found == 5:
				$StateAttack.text = "- Fights using their sharp front teeth, strong enough to chew through wood!"
			if times_found == 10:
				$StateAttack.text = "- With their sharp front teeth that can chew through wood, they nip at anything nearby."
		"Flee":
			if times_found == 1:
				$StateFlee.text = "- Flees when attacked."
			if times_found == 5:
				$StateFlee.text = "- When attacked, tends to panic and run aimlessly."
			if times_found == 10:
				$StateFlee.text = "- Will panic and run aimlessly when attacked, curling their tail and ears inward to protect them."
	pass

func toggle_opened() -> void:
	print("Toggle opened")
	self.visible = (not self.visible)
