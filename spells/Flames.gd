extends "Spell.gd"

func _init():
	image = load("res://spells/img/flames.png")

func cast(caster, source, target):
	shoot("res://elements/fire.tscn", caster, source, target, 5)