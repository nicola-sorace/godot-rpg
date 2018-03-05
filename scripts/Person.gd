extends "Object.gd"

var app  #Appearance
var anim  #Animation Player
var skel  #Skeleton
var head  #Head bone id
var arm_r
var arm_l
var hand_r
var hand_l

var spell_r
var spell_l
var casting_r = false
var casting_l = false

var target

var speed = 20
var jump = 20

var hover

func _ready():
	app = get_node("Appearance")
	anim = get_node("Appearance/Model/AnimationPlayer")
	skel = app.get_node("Model/Armature/Skeleton")
	head = skel.find_bone("Head")
	arm_r = skel.find_bone("Arm1.R")
	arm_l = skel.find_bone("Arm1.L")
	hand_r = skel.find_bone("Arm2.R")
	hand_l = skel.find_bone("Arm2.L")
	
	"""
	get_node("../Hud/Spells/Spell1").set_spell("Flames")
	get_node("../Hud/Spells/Spell2").set_spell("Boulder")
	spell_r = get_node("../Hud/Spells/Spell1").spell
	spell_l = get_node("../Hud/Spells/Spell2").spell
	"""
	
	target = get_tree().get_root().get_node("Root/Player")

func _process(delta):
	
	var pos = target.transform.origin
	
	app.look_at(Vector3(pos.x, app.global_transform.origin.y, pos.z), Vector3(0,1,0))
	
	face(head, pos)
	
	###  Movement and animations:
	var v = Vector3(0,0,0)
	var on_floor = get_colliding_bodies().size()>0
	if on_floor:
		v = Vector3(0,0,0)
		v = v.normalized() * speed
		
		if false:
			v.y = jump
			anim.play("Jump")
		
		if anim.assigned_animation != "Jump" or not anim.is_playing():
			if v.length() > 0.1:
				if v.angle_to(pos-global_transform.origin)>deg2rad(90):
					set_anim("RunBack-loop")
				else:
					set_anim("Run-loop")
			else:
				set_anim("Idle-loop")
		set_linear_velocity(v)
	
	###  Spells:
	var source = (app.global_transform.translated(Vector3(0,3,-1.5))).origin
	if false:  #Right spell
		point_to(arm_r, pos, Vector3(-2,2,20))
		if not casting_r:
			casting_r = true
			spell_r.start_cast(self, source, pos)
		spell_r.cast(self, source, pos)
	elif casting_r:
		casting_r = false
		spell_r.end_cast(self, source, pos)
		
	if false:  #Left spell
		point_to(arm_l, pos, Vector3(2,2,20))
		if not casting_l:
			casting_l = true
			spell_l.start_cast(self, source, pos)
		spell_l.cast(self, source, pos)
	elif casting_l:
		casting_l = false
		spell_l.end_cast(self, source, pos)

func _physics_process(delta):
	pass
	
func face(bone_id, target):
	skel.set_bone_pose(bone_id, skel.get_bone_pose(bone_id).looking_at((target-Vector3(0,4,0)-transform.origin).rotated(Vector3(0,1,0), -deg2rad(app.rotation_degrees.y)).rotated(Vector3(0,1,0),PI).rotated(Vector3(1,0,0),PI/2), Vector3(0,0,-1)).rotated(Vector3(1,0,0),PI/2))

func point_to(bone_id, target, offset):
	#skel.set_bone_pose(bone_id, skel.get_bone_pose(bone_id).looking_at((target-Vector3(0,1,0)-transform.origin).rotated(Vector3(0,1,0), -deg2rad(app.rotation_degrees.y)).rotated(Vector3(0,1,0),PI).rotated(Vector3(1,0,0),PI/2), Vector3(0,0,-1)).rotated(Vector3(1,0,0),PI/2))
	skel.set_bone_global_pose(bone_id, skel.get_bone_global_pose(bone_id).looking_at((target-transform.origin).rotated(Vector3(0,1,0), PI-deg2rad(app.rotation_degrees.y))+offset, Vector3(0,0,1)))
	
func set_anim(name):
	if anim.assigned_animation != name:
		anim.play(name)