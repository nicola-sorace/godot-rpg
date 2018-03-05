extends PhysicsBody

var hud
var damage_label
var camera

var max_hp = 100 #Set to -1 for invincible object.
var hp = max_hp

signal killed

var conversation = null

func _ready():
	var root = get_tree().get_root()
	hud = root.get_node("Root/Hud")
	damage_label = load("res://hud/DamageLabel.tscn")
	camera = root.get_node("Root/Player/Camera")

func _process(delta):
	if max_hp >= 0 and hp <= 0:
		emit_signal("killed")
		queue_free()

func hurt(hp):
	self.hp -= hp
	var label = damage_label.instance()
	hud.add_child(label)
	label.set_hp(-hp, camera.unproject_position(global_transform.origin))