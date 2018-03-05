extends RigidBody

var caster  #Object that is immune to element.

var time = 0

var life = 100
var attack = 0.05
var min_impact = 0  #Minimum speed of collision required for damage. If non-zero, the object will also be destroyed after causing damage.

func _init():
	pass

func _ready():
	connect("body_entered", self, "body_entered")

func _process(delta):
	time += 1
	if time>life:
		pre_death()
		queue_free()
		
	"""
		var cs = get_colliding_bodies()
		if not cs.empty():
			var c = cs[0]
			
			if c.is_in_group("healthy") and linear_velocity.length() >= max_impact:
				c.hp -= attack
			
			if max_impact>=0 and linear_velocity.length() >= max_impact:
				queue_free()
	"""

func body_entered(body):
	if linear_velocity.length() >= min_impact:
		if body.is_in_group("object") and body.max_hp>=0:
			body.hurt(attack)
		if min_impact > 0:
				pre_death()
				queue_free()

func set_caster(obj):
	caster = obj
	add_collision_exception_with(caster)
	
func pre_death():
	pass