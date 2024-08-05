@tool
extends Label

@onready var BtnMove1 = get_node_or_null("../BtnMove1");
@onready var portContainer = get_node_or_null("../BtnMove1/portContainer");
@onready var _image = get_node_or_null("../BtnMove1/portContainer/SbViewport/image");
@onready var drawNode = get_node_or_null("../draw");


#get_area()


var fontSize : int = 15;
var font = ThemeDB.fallback_font;


func _ready():
	pass # Replace with function body.



func _process(_delta):
	queue_redraw();
	


func _draw():
	draw_string(font,  Vector2(10, 20), "BtnMove1: " , HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color.WHITE );
	draw_string(font,  Vector2(30, 40), "mouseONme: " + str(BtnMove1.mouseONme) , HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color.WHITE );
	
	
	draw_string(font,  Vector2(180, 20), "portContainer: " , HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color.WHITE );
	draw_string(font,  Vector2(200, 40), "mouseLOCAL: " + str( portContainer.get_local_mouse_position() ) , HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color.WHITE );
	draw_string(font,  Vector2(200, 60), "mouseONme: " + str(portContainer.mouseONme) , HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color.WHITE );
	
	
	draw_string(font,  Vector2(400, 20), "image Select Rect2: " , HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color.WHITE );
	draw_string(font,  Vector2(420, 40), "absRect: " + str(_image.absRect) , HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color.WHITE );
	draw_string(font,  Vector2(420, 60), "absRect get_area: " + str(_image.absRect.get_area() ) , HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color.WHITE );
	draw_string(font,  Vector2(420, 80), "imageRect: " + str(_image.get_rect() ) , HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color.WHITE );
	draw_string(font,  Vector2(420, 100), "tempabsRect: " + str(_image.tempabsRect ) , HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color.WHITE );
	
	
	draw_string(font,  Vector2(700, 20), "Draw Node: " , HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color.WHITE );
	draw_string(font,  Vector2(700, 40), "canvasTex Size: "  + str( drawNode.canvasTex.size() )  , HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color.WHITE );
	draw_string(font,  Vector2(700, 60), "mouseGroupFnum cursorText: "  + str( drawNode.mouseGroup.Fnum.size() )  , HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color.WHITE );
	
	
	
	draw_string(font,  Vector2(1100, 130), "mouseGLOBAL: " + str( get_global_mouse_position() ) , HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color.WHITE );









