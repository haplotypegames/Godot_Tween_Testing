extends Node2D

var current_alpha: float = 1.0
var tween_starting_alpha: float = 1.0
var tween_target_alpha: float = 0.0
var initial_modulate: Color = Color.white
var new_modulate: Color = Color.white
var tween_time: float = 1.0
var resetting: bool =  false

func _unhandled_input(event):
	if event.is_action_pressed("Reset"):
		reset()

func _ready():
	start()

func start():
	print("Starting.")
	alternate()

func alternate():
	if !resetting:
		print("Alternating.")
		$Timer.start()

func reset():
	resetting = true
	print("Resetting.")
	yield(get_tree(),"idle_frame")
	$Timer.stop()
	$Tween.stop_all()
	#$Tween.reset_all() #Added this in when testing
	tween_starting_alpha = 1.0
	tween_target_alpha = 0.0
	new_modulate = initial_modulate
	$Sprite.modulate = initial_modulate
	yield(get_tree().create_timer(0.5),"timeout")
	resetting = false
	start()

func _on_Timer_timeout():
	print("Timer timed out. Starting tween. Current Alpha: ", current_alpha, " , starting alpha: ", tween_starting_alpha, \
	" , target alpha: ", tween_target_alpha)
	$Tween.interpolate_property(self, "current_alpha", tween_starting_alpha, tween_target_alpha, tween_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()


func _on_Tween_tween_all_completed(): #This stops being called at some point after resetting
	print("Tween all complete")
	if current_alpha < 0.1: #Is hidden
		tween_starting_alpha = 0.0
		tween_target_alpha = 1.0
	else:
		tween_starting_alpha = 1.0 #Not hidden
		tween_target_alpha = 0.0
	alternate()

func _on_Tween_tween_step(object, key, elapsed, value):
	print("In step - value: ", value)
	new_modulate.a = value
	$Sprite.modulate = new_modulate


func _on_Tween_tween_completed(object, key): #This gets called correctly
	print("Tween key complete")
#	if key == ":current_alpha":
#		if current_alpha < 0.1: #Is hidden
#			tween_starting_alpha = 0.0
#			tween_target_alpha = 1.0
#		else:
#			tween_starting_alpha = 1.0 #Not hidden
#			tween_target_alpha = 0.0
#		alternate()
