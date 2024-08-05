@tool
extends TextureButton



var fontSize : int = 25;
var font = ThemeDB.fallback_font;
var mouseONme : bool = false;

#var plugINget;
@onready var plugINget = get_node_or_null("..");

func _ready():
	pass # Replace with function body.



func _process(_delta):
	
	if ( mouseONme == true ):
		#position = get_global_mouse_position();
		#position = TileDrawAutoLoad.dockedScene.get_local_mouse_position();
		
		if ( plugINget != null ):
			position = plugINget.get_local_mouse_position();
			
		pass;
	




func _on_mouse_entered():
	if  Rect2(Vector2(), size).has_point(get_local_mouse_position()):
		self_modulate = Color(0.5, 0.5, 0.5, 1);

func _on_mouse_exited():
	if ! Rect2(Vector2(), size).has_point(get_local_mouse_position()):
		self_modulate = Color(1, 1, 1, 1);




func _on_button_down():
	if  Rect2(Vector2(), size).has_point(get_local_mouse_position()):
		mouseONme = true;


func _on_button_up():
	mouseONme = false;
