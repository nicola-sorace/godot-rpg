extends Control

var player
var name_label
var health
var action

var conversation

func _ready():
	player = get_node("../../Player")
	name_label = get_node("Name")
	health = get_node("Health")
	action = get_node("Action")
	
	conversation = get_node("../Conversation")

func _process(delta):
	if not player.hover.empty() and player.hover.collider.is_in_group("object"):
		var obj = player.hover.collider
		name_label.text = obj.get_name()
		
		if obj.max_hp >= 0:
			health.max_value = obj.max_hp
			health.value = obj.hp
			health.visible = true
		else:
			health.visible = false
		
		if obj.conversation != null and (obj.global_transform.origin - player.global_transform.origin).length() < 10:
			action.text = "[E]: Talk"
			action.visible = true
			if Input.is_key_pressed(KEY_E):
				conversation.set_script(obj.conversation)
				conversation.start_story(obj)
		else:
			action.visible = false
		
		rect_position = get_viewport().get_mouse_position() + Vector2(-rect_size.x/2,40)
		visible = true
	else:
		visible = false
