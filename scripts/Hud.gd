extends Control

var high1
var high2

var player
var healthbar
var manabar
var spell_slots

var has_mouse
var dragging = null
var drag_source  #Original location of dragged object, before it was dragged.

func _ready():
	
	high1 = load("res://hud/Highlight1.tres")
	high2 = load("res://hud/Highlight2.tres")
	
	player = get_node("../Player")
	healthbar = get_node("Healthbar")
	manabar = get_node("Manabar")
	"""
	get_node("Hotbar").connect("mouse_entered", self, "grab_mouse")
	get_node("Hotbar").connect("mouse_exited", self, "leave_mouse")
	"""
	
	spell_slots = get_node("Spells").get_children()
	
	get_node("Conversation").connect("mouse_entered", self, "grab_mouse")
	get_node("Conversation").connect("mouse_exited", self, "leave_mouse")
	get_node("Conversation/Continue").connect("mouse_entered", self, "grab_mouse")
	get_node("Conversation/Close").connect("mouse_entered", self, "grab_mouse")
	get_node("Conversation/Story").connect("mouse_entered", self, "grab_mouse")

func _process(delta):
	if get_viewport().size.y-get_viewport().get_mouse_position().y<100:
		grab_mouse()
	else:
		leave_mouse()
		
	if dragging != null:
		if Input.is_mouse_button_pressed(1):
			dragging.set_global_position(get_viewport().get_mouse_position())
		else:
			drop()
	
	healthbar.value = (float(player.hp)/float(player.max_hp))*100
	manabar.value = (float(player.mana)/float(player.max_mana))*100

func grab_mouse():
	has_mouse = true

func leave_mouse():
	if dragging == null:
		has_mouse = false

func drag(obj):
	drag_source = obj.get_position()
	print(drag_source)
	grab_mouse()
	dragging = obj

func drop():
	dragging.set_position(drag_source)
	dragging = null
	leave_mouse()

func equip_spell(n, slot):
	if slot != player.spell_r and slot != player.spell_l:
		if n == 0:
			player.spell_r.add_stylebox_override("normal", StyleBoxEmpty.new())
			player.spell_r = slot
			player.spell_r.add_stylebox_override("normal", high1)
		elif n == 1:
			player.spell_l.add_stylebox_override("normal", StyleBoxEmpty.new())
			player.spell_l = slot
			player.spell_l.add_stylebox_override("normal", high2)