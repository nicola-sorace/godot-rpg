extends "Spell.gd"

func _init():
	image = load("res://spells/img/flames.png")
	mana = 2

func cast(caster, source, target):
	.cast(caster, source, target)
	if pay(caster):
		shoot("res://elements/fire.tscn", caster, source, target, 5)