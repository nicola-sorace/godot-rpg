extends "Spell.gd"

func _init():
	image = load("res://spells/img/boulder.png")

func start_cast(caster, source, target):
	shoot("res://elements/boulder.tscn", caster, source, target, 40)