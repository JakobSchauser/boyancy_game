extends Node


var num_pickups = 0
var total_pickups = 10



# press r to restart
func _input(event):
    if event.is_action_pressed("ui_cancel"):
        get_tree().reload_current_scene()

