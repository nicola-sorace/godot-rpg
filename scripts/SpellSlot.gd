extends Button

var spell

func _ready():
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
	pass

func mouse_exited():
	print("exitedddd")
	if Input.is_mouse_button_pressed(1):
		print("HEADSAD")
	get_tree().get_root().get_node("Root/Hud").drag(self)