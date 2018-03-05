extends "Spell.gd"

func _init():
	image = load("res://spells/img/flameBall.png")

func start_cast(caster, source, target):
	shoot("res://elements/fire.tscn", caster, source, target, 40)