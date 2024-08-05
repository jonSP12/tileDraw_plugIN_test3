@tool
extends Control

@onready var drawND = get_node_or_null("draw");
@onready var LayerName = get_node_or_null("LayerName");
@onready var LayerText = get_node_or_null("LayerName/TextEdit");



#@onready var _image = get_node_or_null("BtnMove1/portContainer/SbViewport/image");
#@onready var _menuArea = get_node_or_null("menuArea");
#
#var mg: Vector2 = Vector2(0, 0);
#var imgText;
#
#
#func _ready():
	#pass # Replace with function body.
#
#
#
#func _process(_delta):
	#var mgX = snapped( get_global_mouse_position().x, 32 );
	#var mgY = snapped( get_global_mouse_position().y, 32 );
	#mg = Vector2(mgX, mgY);
	#
	#if ( _image.mouse_tex != null ):
		#imgText = _image.mouse_tex;
	#
	#


