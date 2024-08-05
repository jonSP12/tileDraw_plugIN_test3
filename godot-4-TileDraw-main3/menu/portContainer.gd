@tool
extends SubViewportContainer


@onready var cam2D = get_node_or_null("SbViewport/cam2D");

var fontSize : int = 25;
var font = ThemeDB.fallback_font;

var selectRect = Rect2(16, 16, 32, 32 );



var mXG : int = 0;
var mYG : int = 0;
var mGpos : Vector2 = Vector2(0, 0);
var mouseONme : bool = false;

func _ready():
	pass;
	



func _process(_delta):
	
	
	
	pass;
	#queue_redraw();


func _input(event):
	
	if ( mouseONme == true ):
		if( Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE)  ):
			if event is InputEventMouseMotion:
				cam2D.position -= event.relative;
		elif( Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_DOWN) ):
			cam2D.zoom -= Vector2(0.03, 0.03);
			
		elif( Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_UP) ):
			cam2D.zoom += Vector2(0.03, 0.03);
			





func _draw():
	draw_rect( Rect2(-5 , -5 , size.x+10 , size.y+10 ), Color.BLACK, false, 8 );
	draw_rect( Rect2(-5 , -5 , size.x+10 , size.y+10 ), Color.DARK_GRAY, false, 3 );
	
	#Rect2(temp_mX, temp_mY, mmW, mmH );
	




func _on_mouse_entered():
	mouseONme = true;
	grab_focus();
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN);


func _on_mouse_exited():
	mouseONme = false;
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
