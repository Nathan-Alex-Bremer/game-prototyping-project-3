extends Node2D

# Controls debug testing things!
var debug_on: bool = true

# Player interact options!
var in_interact_range: bool = true

# Creatures
var num_existing_creatures = 6
@export var max_creatures: int = 6
@export var creature_scene: PackedScene
@export var predator_scene: PackedScene
@export var plantcreature_scene: PackedScene
@export var frog_scene: PackedScene
@export var bird_scene: PackedScene


var existing_creatures: Array[Creature]
var selected_creature: Creature

# Environment
var raining: bool = false


# Food
var num_food: int = 0
@export var max_food: int = 10
@export var food_scene: PackedScene

# Hiding places
@export var bush_scene: PackedScene
@export var tree_scene: PackedScene

# Player
@export var player_scene: PackedScene
var player_in_journal: bool = false
var player_in_quest_menu: bool = false
@export var camera_area_scene: PackedScene

var screen_size: Vector2



#enum STATES {
	#IDLE,
	#WANDER,
	#MOVE_TO_FOOD,
	#EAT,
	#REST
#}

enum INTERACT_MODES {
	CHECK,
	PLACE_FOOD,
	PET,
	POKE,
	DRAG
}
var mode = INTERACT_MODES.CHECK

# MonsterStates
var found_states = {
	"Creature" = {},
	"Predator" = {},
	"PlantCreature" = {},
	"Bird" = {},
	"Frog" = {}
}

var num_found_states: int = 0

# Creature Names
# TODO: Make this less ugly! Move to a JSON file or something!			
var names_creature = [
					"Todd", 
					"Michael", 
					"Ratrick",
					"The Rat",
					"Ratricia",
					"Ratginald",
					"The Creature",
					"Friend",
					"Little Man",
					"Minerva",
					"George",
					"Georgina",
					"Nyquil",
					"Piko",
					"Nondescript",
					"Ratsune Miku",
					"Jerry",
					"Retthew",
					"Jaws",
					"Chewnior",
					"Big Boy",
					"Kevin",
					"Pikantu",
					"Reginald",
					"Johnny Cheese",
					"Squeekums",
					"Snuggles",
					"Biggie Ears",
					"Big Cheese",
					"Pom-Pom",
					"Slim",
					"Rat Bastard",
					"Roderrick",
					"Squorl",
					"Chip Punk",
					"Squeakley",
					"Chu Chu Rocket",
					"Socks",
					"Stylin' Steve",
					"Pookie",
					"Goofy Greg",
					"Furball",
					"White Boy",
					"Mouseketeer",
					"Joey",
					"Linguini",
					"The Chosen One",
					"Mr. Cheeks",
					"Cotton-Ball Joe",
					"Ribbon",
					"Dot",
					"Gnawman",
					"Triangle Head",
					"Doofus",
					"Jerma",
					"Inchmus"]

var names_predator = [
	"Jonathan",
	"Mozilla",
	"McCloud",
	"Ashley",
	"Foximillian",
	"Renard",
	"Caine",
	"Hot Dog",
	"The Bastard",
	"Jebediah",
	"Fangley",
	"Burnie",
	"Torchy",
	"Jeffrey",
	"Critter",
	"Her",
	"Foxane Teto",
	"Trixie",
	"Miles",
	"Scorching Scott",
	"Vixen",
	"Foxandra",
	"Fluff Puppy",
	"Space Heater",
	"Smithy",
	"Inferdinand",
	"Hot Pocket",
	"Smooth Criminal",
	"Reed Biteman",
	"Pokey",
	"Ember",
	"Burnathan",
	"Fir E. Coyote",
	"Spice Boy",
	"Sparks",
	"Katie",
	"Warm Hug Machine",
	"Bushfire",
	"Barkiplier",
	"Hot Stuff",
	"Toast",
	"Bunsen",
	"Blazkit",
	"La Flamme",
	"Ember",
	"Charchy",
	"Charchibald",
	"Torchy",
	"The Listener",
	"Slim Jim",
	"Little Dude"
]

var names_plantcreature = [
	"Steve",
	"Seedrick",
	"George",
	"Fruitricia",
	"Sonic",
	"Hedge Fund",
	"George",
	"Granny Smith",
	"Industry Plans",
	"Astroturf",
	"Leif",
	"Bramblina",
	"Betty Bush",
	"Flourisha",
	"Dandel",
	"Pia",
	"Crisp",
	"Lettuce",
	"Fiona",
	"The Unaware One",
	"Attila",
	"Mossy",
	"Fern",
	"Subsonic",
	"Toast",
	"Bitter Bonnie",
	"Sneed",
	"Thornton",
	"Hedgerick",
	"Rose",
	"Toxic Love",
	"Fruitricia",
	"Pomme",
	"Root Brute",
	"Itchy",
	"Branchine",
	"Doodle",
	"Dirt Man",
	"Emerald",
	"Sunbather",
	"Snoopy",
	"Droopy",
	"Cabbage",
	"Sticks"
]

var names_bird = [
	"Avery",
	"Wing Thing",
	"Merrifeather",
	"Beakquerel",
	"Superfly",
	"Jet",
	"Berdly",
	"Eric",
	"Andre",
	"Roger",
	"Big Eye",
	"Donald",
	"Birdbrain",
	"Scrooge",
	"Squawkabilly",
	"Pitoo",
	"The Fog",
	"The Watcher",
	"Yosuke",
	"Zip Zoom",
	"Feather Frank",
	"Nestasia",
	"Bitty Bird",
	"Big Pecks",
	"Chirpinsky",
	"Sound Barrier",
	"Turbine",
	"Azure",
	"Marble",
	"Peter Pecks",
	"Quill",
	"Fastball",
	"Storm",
	"Jet",
	"Tweety",
	"Megaphone",
	"Peepers",
	"Beep",
	"The Awoken One",
	"Golf Ball",
	"Peckenzie",
	"Noisy Boy",
	"The Oddball",
	"Wendy",
	"Gumball"
]

var names_frog = [
	"Earl",
	"Croaker",
	"Croakenzie",
	"Spraythan",
	"Spigot",
	"Wart",
	"Gerry",
	"Slippy",
	"The Storm",
	"Springy",
	"Poseidon",
	"Hoptimizer",
	"Humidifier",
	"Water Balloon",
	"Todd Howard",
	"The Scrungler",
	"Sophia",
	"Fig Newton",
	"Salamander Steph",
	"Toad Licker",
	"Slippery Jim",
	"Froggita",
	"Rainette",
	"Funkle",
	"Tad",
	"Frubble",
	"Pam Phibian",
	"Geyser Gary",
	"Pond Boy",
	"Lily",
	"Isaac",
	"Newtron",
	"The Tongue",
	"Splash Zone",
	"Droplet",
	"Pondrian",
	"Bubbles",
	"Bonk",
	"Gormless Fellow",
	"The Ancient One",
	"River",
	"Hip Hop",
	"Groovy Grover",
	"Kermit",
	"Slime Man",
	"Flubber"
]

var creature_names = {"Creature" = names_creature,
			"Predator" = names_predator,
			"PlantCreature" = names_plantcreature,
			"Bird" = names_bird,
			"Frog" = names_frog
			}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	screen_size = get_viewport_rect().size
	
	# TODO: Make this cleaner
	found_states["Creature"]["Eat"] = 0
	found_states["Creature"]["Idle"] = 0
	found_states["Creature"]["Wander"] = 0
	found_states["Creature"]["Rest"] = 0
	found_states["Creature"]["Pet"] = 0
	found_states["Creature"]["Annoyed"] = 0
	found_states["Creature"]["Play"] = 0
	found_states["Creature"]["Chase"] = 0
	found_states["Creature"]["Attack"] = 0
	found_states["Creature"]["Flee"] = 0
	
	found_states["Predator"]["Attack Eat"] = 0
	found_states["Predator"]["Idle"] = 0
	found_states["Predator"]["Wander"] = 0
	found_states["Predator"]["Rest"] = 0
	found_states["Predator"]["Pet"] = 0
	found_states["Predator"]["Annoyed"] = 0
	found_states["Predator"]["Play"] = 0
	found_states["Predator"]["Eat"] = 0
	found_states["Predator"]["Attack"] = 0
	found_states["Predator"]["Intimidate"] = 0
	
	found_states["PlantCreature"]["Photosynthesize"] = 0
	found_states["PlantCreature"]["Idle"] = 0
	found_states["PlantCreature"]["Wander"] = 0
	found_states["PlantCreature"]["Rest"] = 0
	found_states["PlantCreature"]["Pet"] = 0
	found_states["PlantCreature"]["Annoyed"] = 0
	found_states["PlantCreature"]["Play"] = 0
	found_states["PlantCreature"]["Drop Food"] = 0
	found_states["PlantCreature"]["Poison Dust"] = 0
	found_states["PlantCreature"]["Flee"] = 0
	
	found_states["Bird"]["Eat"] = 0
	found_states["Bird"]["Idle"] = 0
	found_states["Bird"]["Wander"] = 0
	found_states["Bird"]["Rest"] = 0
	found_states["Bird"]["Pet"] = 0
	found_states["Bird"]["Annoyed"] = 0
	found_states["Bird"]["Play"] = 0
	found_states["Bird"]["Chase"] = 0
	found_states["Bird"]["Attack"] = 0
	found_states["Bird"]["Flee"] = 0
	
	found_states["Frog"]["Eat"] = 0
	found_states["Frog"]["Idle"] = 0
	found_states["Frog"]["Wander"] = 0
	found_states["Frog"]["Rest"] = 0
	found_states["Frog"]["Pet"] = 0
	found_states["Frog"]["Annoyed"] = 0
	found_states["Frog"]["Play"] = 0
	found_states["Frog"]["Chase"] = 0
	found_states["Frog"]["Attack"] = 0
	found_states["Frog"]["Flee"] = 0

func get_state_in_journal(creature_name: StringName, state_name: StringName) -> bool:
	return (found_states[creature_name].has(state_name))
	
func get_state_found(creature_name: StringName, state_name: StringName) -> bool:
	return (found_states[creature_name][state_name] > 0)
	
func get_state_complete(creature_name: StringName, state_name: StringName) -> bool:
	return (found_states[creature_name][state_name] >= 10)
