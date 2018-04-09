extends Button

var hud

var spell

func _ready():
	hud = get_node("../../")
	spell = get_node("Script")
	#icon = spell.image
	connect("pressed", self, "pressed")
	connect("mouse_exited", self, "mouse_exited")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func set_spell(name):
	spell.set_script(load("res://spells/"+name+".gd"))
	icon = spell.image
	disabled = false

func pressed():
	if Input.is_key_pressed(KEY_SHIFT):
		hud.equip_spell(1, self)
	else:
		hud.equip_spell(0, self)
		
	release_focus()

func mouse_exited():
	if Input.is_mouse_button_pressed(1):
		print("HEADSAD")
		hud.drag(self)