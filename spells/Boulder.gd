extends "Spell.gd"

func _init():
	image = load("res://spells/img/boulder.png")
	mana = 25

func start_cast(caster, source, target):
	.start_cast(caster, source, target)
	if pay(caster):
		shoot("res://elements/boulder.tscn", caster, source, target, 40)