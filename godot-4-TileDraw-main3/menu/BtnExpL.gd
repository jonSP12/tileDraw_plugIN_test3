@tool
extends TextureButton



func _on_mouse_entered():
	if  Rect2(Vector2(), size).has_point(get_local_mouse_position()):
		self_modulate = Color(0.5, 0.5, 0.5, 1);


func _on_mouse_exited():
	if ! Rect2(Vector2(), size).has_point(get_local_mouse_position()):
		self_modulate = Color(1, 1, 1, 1);
