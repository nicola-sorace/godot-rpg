extends Control

var image = load("res://spells/img/none.png")
var mana = 1

func _ready():
	pass

#Events can happen at the beggining, middle and end of casting:
func start_cast(caster, source, target):
	pass
func cast(caster, source, target):
	pass
func end_cast(caster, source, target):
	pass

func shoot(res, caster, source, target, velocity):
	var ball = load(res).instance()
	ball.set_caster(caster)
	ball.translation = source
	ball.set_axis_velocity((target-source).normalized()*velocity+caster.get_linear_velocity())
	get_node("../../../../").add_child(ball)

func pay(caster):
	if caster.mana >= mana:
		caster.mana -= mana
		return true
	else:
		return false