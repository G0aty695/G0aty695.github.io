extends RichTextLabel



# Called when the node enters the scene tree for the first time.
func _ready():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().get_node("Player").level == 1:
		rect_position = Vector2(-300, -234)
		if get_parent().get_node("Player").deaths == 0:
			text = "What are you doing here?"
		elif get_parent().get_node("Player").deaths == 3:
			text = "Wait. You want my help!?"
		elif get_parent().get_node("Player").deaths == 4:
			text = "Ugg. Fine. You may have noticed the giant wall in front of you. Do you think you have enought braincells to get past that?"
		elif get_parent().get_node("Player").deaths == 6:
			text = "Seriously? Ok listen carfully so you and your last singular neuron have a chance. You've probably noticed you can jump with A. You may have even noticed you can climb part of the wall. Continue jumping up the wall to launch yourself."
	
	if get_parent().get_node("Player").level == 3:
		rect_position = Vector2(2000, -234)
		if get_parent().get_node("Player").deaths == 0:
			text = "Use Right Trigger to dash."
		if get_parent().get_node("Player").deaths == 5:
			text = "Don't keep me waiting"
		if get_parent().get_node("Player").deaths == 10:
			text = "How did I get stuck with an imbecile like you!?"
			
	if get_parent().get_node("Player").level == 5:
		rect_position = Vector2(5200, -500)
		if get_parent().get_node("Player").deaths == 0:
			text = "Here's a tip. DON'T TOUCH THE GIANT SAWBLADES!"
			
	if get_parent().get_node("Player").level == 7:
		rect_position = Vector2(8500, -500)
		if get_parent().get_node("Player").deaths == 0:
			text = "I don't even know why we have saw blades."
		if get_parent().get_node("Player").deaths == 1:
			text = "I guess no one noticed them."
		if get_parent().get_node("Player").deaths == 2:
			text = "Probably because you're the only one stupid enough to ever die to them."
		print(get_parent().get_node("Player").deaths)
		
	if get_parent().get_node("Player").level == 9:
		rect_position = Vector2(11200, -500)
		if get_parent().get_node("Player").deaths == 0:
			text = ""
		if get_parent().get_node("Player").deaths == 1:
			text = "You absolute moron! How on earth did you just die to that!?" 
	
		
			
