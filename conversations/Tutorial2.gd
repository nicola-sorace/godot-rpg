extends "../scripts/Conversation.gd"

func _init():
	setup()
	
	story = [
"Quite impressive!\n\nWhy, at my age, when I try casting a flame spell I mostly just burn my feet...",
"Anyway, now that you have mastered the use of a near-uncontrollable and lethal elemental weapon, I can teach you a spell that is completely harmless.\n\nGet ready!\\0"]

func event(id):
	if id==0:
		player.get_node("../Hud/Spells/Spell2").set_spell("Boulder")
		player.spell_l = player.get_node("../Hud/Spells/Spell2").spell