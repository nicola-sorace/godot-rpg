extends "Spell.gd"

func _init():
	image = load("res://spells/img/none.png")
	mana = 100

func start_cast(caster, source, target):
	.start_cast(caster, source, target)
	var v = (target-source).normalized()
	v = Vector3(v.x, 1, v.z)*10
	if pay(caster):
		#caster.apply_impulse(source, v)
		caster.set_linear_velocity(v)
		caster.anim.play("Jump")