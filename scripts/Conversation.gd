extends Panel

var story = ["Ah, glorious traveller!\nWelcome to our magical land!",
"Would you like to see some magic?"]
var n = 0
var cmd

var title
var text
var hud
var speaker
var player

func _ready():
	pass

func setup():
	title = get_node("Name")
	text = get_node("Story")
	hud = get_tree().get_root().get_node("Root/Hud")
	player = get_tree().get_root().get_node("Root/Player")
	
	get_node("Continue").connect("pressed", self, "next_page")
	get_node("Close").connect("pressed", self, "close_story")

#func _process(delta):
#	pass

func start_story(obj):
	n = 0
	speaker = obj 
	title.set_text(speaker.name)
	draw_page()
	set_visible(true)

func close_story():
	set_visible(false)
	hud.leave_mouse()
	
func next_page():
	
	if cmd.size() > 1:
		event(int(cmd[1]))
	
	if n<story.size()-1:
		n += 1
		draw_page()
	else:
		close_story()

func draw_page():
	cmd = story[n].split("\\")
	text.set_text(cmd[0])
		
func event(id):
	pass