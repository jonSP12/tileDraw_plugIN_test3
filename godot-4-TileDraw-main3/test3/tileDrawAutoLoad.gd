#@tool
#extends EditorPlugin
#
#
#const editorAddon = preload("res://menu/menu.tscn");
#const tileDrawNode = preload("res://test3/tileDrawNode.gd");
#const tileDrawIcon = preload("res://test3/icon.png");
#
#
#var dockedScene;
#var whatIsvisible;
#
#
#func _enter_tree():
	#add_custom_type("TileDraw", "Node2D", tileDrawNode, tileDrawIcon );
	#dockedScene = editorAddon.instantiate();
	#add_control_to_container(CONTAINER_CANVAS_EDITOR_SIDE_RIGHT, dockedScene );
	#dockedScene.custom_minimum_size = Vector2(10,0);
	#
#
#
#
#
#
#
#
#func _handles(object: Object) -> bool:
	#return object is tileDrawNode
#
#func _make_visible(visible: bool) -> void:
	#dockedScene.visible = visible
	#whatIsvisible = visible;
#
#
#func _forward_canvas_gui_input(event):
	#update_overlays();
	#if (event is InputEventMouseButton ):
		#dockedScene.visible = true;
		#return true
	###print(event);
	###update_overlays();
#
#func _process(_delta):
	##set_force_draw_over_forwarding_enabled();
	#pass;
#
#
#func _forward_canvas_draw_over_viewport(overlay):
	## Draw a circle at cursor position.
	#overlay.draw_circle(overlay.get_local_mouse_position(), 264, Color.WHITE)
	##overlay.draw_texture( img.mouse_tex, overlay.get_local_mouse_position() );
	#
	#pass;
#
#
#func _exit_tree():
	#remove_custom_type("TileDraw");
	#remove_control_from_docks(dockedScene);
	#dockedScene.free();
