extends "Object.gd"

var app  #Appearance
var anim  #Animation Player
var cam  #Camera
var cursor
var skel  #Skeleton
var head  #Head bone id
var arm_r
var arm_l
var hand_r
var hand_l

var spell_r
var spell_l

var speed = 10
var jump = 7

var hover

func _ready():
	app = get_node("Appearance")
	anim = get_node("Appearance/Model/AnimationPlayer")
	cam = get_node("Camera")
	cursor = get_parent_spatial().get_node("Cursor")
	skel = app.get_node("Model/Armature/Skeleton")
	head = skel.find_bone("Head")
	arm_r = skel.find_bone("Arm1.R")
	arm_l = skel.find_bone("Arm1.L")
	hand_r = skel.find_bone("Arm2.R")
	hand_l = skel.find_bone("Arm2.L")
	
	#"""
	get_node("../Hud/Spells/Spell1").set_spell("Flames")
	get_node("../Hud/Spells/Spell2").set_spell("Boulder")
	#"""
	
	spell_r = get_node("../Hud/Spells/Spell1").spell
	spell_l = get_node("../Hud/Spells/Spell2").spell
	

func _process(delta):
	
	###  Point towards cursor:
	var pos
	if not hover.empty():
		pos = hover.position
		cursor.translation = pos
	else:
		var mouse = get_viewport().get_mouse_position()
		var from = cam.project_ray_origin(mouse)
		var dir = cam.project_ray_normal(mouse)
		pos = from + dir*((translation.y-from.y)/(dir.y+0.01))
		cursor.translation = Vector3(pos.x, app.global_transform.origin.y, pos.z)
	
	app.look_at(Vector3(pos.x, app.global_transform.origin.y, pos.z), Vector3(0,1,0))
	
	face(head, pos)
	
	###  Movement and animations:
	var v = Vector3(0,0,0)
	var on_floor = get_colliding_bodies().size()>0
	if on_floor:
		if not hud.has_mouse:

			v = Vector3(int(Input.is_action_pressed("walk_right")) - int(Input.is_action_pressed("walk_left")),
				v.y,
				-int(Input.is_action_pressed("walk_up")) + int(Input.is_action_pressed("walk_down")))
			v = v.normalized() * speed
			
			if Input.is_action_pressed("jump"):
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
		else:
			set_anim("Idle-loop")
			set_linear_velocity(v)
	elif not anim.is_playing():
		set_anim("Fall-loop")
		
	if not hud.has_mouse:
		###  Spells:
		var source = (app.global_transform.translated(Vector3(0,1,-0.5))).origin
		if Input.is_action_pressed("spell_right"):  #Right spell
			point_to(arm_r, pos, Vector3(-2,2,20))
			if Input.is_action_just_pressed("spell_right"):
				spell_r.start_cast(self, source, pos)
			spell_r.cast(self, source, pos)
		if Input.is_action_just_released("spell_right"):
			spell_r.end_cast(self, source, pos)
			
		if Input.is_action_pressed("spell_left"):  #Left spell
			point_to(arm_l, pos, Vector3(2,2,20))
			if Input.is_action_just_pressed("spell_left"):
				spell_l.start_cast(self, source, pos)
			spell_l.cast(self, source, pos)
		if Input.is_action_just_released("spell_left"):
			spell_l.end_cast(self, source, pos)

func _physics_process(delta):
	get_hover()

func get_hover():  #Returns result of an intersect ray from mouse position.
	if not hud.has_mouse:
		var mouse = get_viewport().get_mouse_position()
		var from = cam.project_ray_origin(mouse)
		var to = from + cam.project_ray_normal(mouse) * 70
		var result = get_world().get_direct_space_state().intersect_ray(from, to, [self], 1)
		
		hover = result
	
func face(bone_id, target):
	skel.set_bone_pose(bone_id, skel.get_bone_pose(bone_id).looking_at((target-Vector3(0,2.5,0)-transform.origin).rotated(Vector3(0,1,0), -deg2rad(app.rotation_degrees.y)).rotated(Vector3(0,1,0),PI).rotated(Vector3(1,0,0),PI/2), Vector3(0,0,-1)).rotated(Vector3(1,0,0),PI/2))

func point_to(bone_id, target, offset):
	#skel.set_bone_pose(bone_id, skel.get_bone_pose(bone_id).looking_at((target-Vector3(0,1,0)-transform.origin).rotated(Vector3(0,1,0), -deg2rad(app.rotation_degrees.y)).rotated(Vector3(0,1,0),PI).rotated(Vector3(1,0,0),PI/2), Vector3(0,0,-1)).rotated(Vector3(1,0,0),PI/2))
	skel.set_bone_global_pose(bone_id, skel.get_bone_global_pose(bone_id).looking_at((target-transform.origin).rotated(Vector3(0,1,0), PI-deg2rad(app.rotation_degrees.y))+offset, Vector3(0,0,1)))
	
func set_anim(name):
	if anim.assigned_animation != name:
		anim.play(name)