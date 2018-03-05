extends Control

var hud

var has_mouse
var dragging = null
var drag_source  #Original location of dragged object, before it was dragged.

func _ready():
	get_node("Hotbar").connect("mouse_entered", self, "grab_mouse")
	get_node("Hotbar").connect("mouse_exited", self, "leave_mouse")
	
	get_node("Conversation").connect("mouse_entered", self, "grab_mouse")
	get_node("Conversation").connect("mouse_exited", self, "leave_mouse")
	get_node("Conversation/Continue").connect("mouse_entered", self, "grab_mouse")
	get_node("Conversation/Close").connect("mouse_entered", self, "grab_mouse")
	get_node("Conversation/Story").connect("mouse_entered", self, "grab_mouse")

func _process(delta):
	if dragging != null:
		if Input.is_mouse_button_pressed(1):
			dragging.set_global_position(get_viewport().get_mouse_position())
		else:
			drop()

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