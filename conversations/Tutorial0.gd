extends "../scripts/Conversation.gd"

func _init():
	setup()
	
	story = [
"Why hello there, lifeform!\nWelcome to our vast and magical land!",
"I sense within you a strong and growing energy...\n\nLet me teach you some spells before you explode.",
"We'll start with fire. That always goes well.\n\nGet ready!\\0",
"Right on!\n\nSee if you can burn down that old tree over there.\n...And please, aim carefully. I don't remember any healing spells."
]

func event(id):
	if id==0:
		player.get_node("../Hud/Spells/Spell1").set_spell("Flames")
		player.spell_r = player.get_node("../Hud/Spells/Spell1").spell
		speaker.conversation = load("res://conversations/Tutorial1.gd")