extends Spatial

onready var monkey = $Monkey

func _process(delta):
    monkey.rotate_y(delta)
