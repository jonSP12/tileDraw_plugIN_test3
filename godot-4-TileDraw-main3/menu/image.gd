@tool
extends Sprite2D

@onready var portContainer = get_node_or_null("../..");

var Mimg: int = 0;
var mGx : int = 0;
var mGy : int = 0;
var mG : Vector2 = Vector2(0, 0);

var tempabsRect = Rect2(0, 0, 0, 0 );
var absRect = Rect2(0, 0, 0, 0 );
var mouse_tex;


var temp_mX: int = 0;
var temp_mY: int = 0;
var mmW: int = 0;
var mmH: int = 0;

var eventPressed: bool = false;




func _ready():
	pass # Replace with function body.




func MouseOnMe():
	if (  ( mGx >= position.x && mGx <= texture.get_width() - 16) &&  ( mGy >= position.y && mGy <= texture.get_height() - 16)  ):
		Mimg = 1;
	else:
		Mimg = 0;



func _process(_delta):
	
	mGx = snapped( get_local_mouse_position().x, 32 );
	mGy = snapped( get_local_mouse_position().y, 32 );
	mG = Vector2(mGx, mGy);
	
	MouseOnMe();
	
	
	
	if ( portContainer.mouseONme == false ):
		return;
	
	
	queue_redraw();
	
	
	
	if( Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && Mimg == 1 && eventPressed == false ):
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
		
		temp_mX = snapped(  get_global_mouse_position().x, 32 );
		temp_mY = snapped(  get_global_mouse_position().y, 32 );
		
		absRect = Rect2(mG.x, mG.y, 32, 32 );
		eventPressed = true;
	
	
	if ( ! Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) ):
		#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN);
		eventPressed = false;
		
		if ( absRect.get_area() == 0 ):
			absRect = Rect2(temp_mX, temp_mY, 32, 32 );
		
		var absRect2 = absRect.abs();
		absRect = absRect2;
		
		if (absRect.position.x < 0):
			absRect.size.x = absRect.size.x + absRect.position.x;
			absRect.position.x = 0;
		if (absRect.position.y < 0):
			absRect.size.y = absRect.size.y + absRect.position.y;
			absRect.position.y = 0;
		
		
		
		if ( tempabsRect.size.x > get_rect().size.x ):
			var tempXX = tempabsRect.size.x - get_rect().size.x;
			absRect.size.x = absRect.size.x - tempXX;
			tempabsRect.size.x = 0;
		if ( tempabsRect.size.y > get_rect().size.y ):
			var tempYY = tempabsRect.size.y - get_rect().size.y;
			absRect.size.y = absRect.size.y - tempYY;
			tempabsRect.size.y = 0;
		
		
		
		mouse_tex = ImageTexture.create_from_image(texture.get_image().get_region( absRect ) );
	
	
	if Input.get_last_mouse_velocity() && eventPressed == true:
		
		#print(Input.get_last_mouse_velocity()  )
		
		
		mmW = snapped(  get_global_mouse_position().x, 32 ) - temp_mX;
		mmH = snapped(  get_global_mouse_position().y, 32 ) - temp_mY;
		
		
		tempabsRect = Rect2(0, 0, snapped(  get_global_mouse_position().x, 32 ), snapped(  get_global_mouse_position().y, 32 ) );
		
		#if ( tempabsRect.size.x > get_rect().size.x ):
			#tempXXminus = tempabsRect.size.x - get_rect().size.x;
		
		absRect = Rect2(temp_mX, temp_mY, mmW, mmH );
		
		
		
		
		
		
	
	
	



func _draw():
	var icX = position.x;
	var icY = position.y;
	
	var grid1W = texture.get_width();
	var grid1H = texture.get_height();
	
	var rX = grid1W/32.0+1.0;
	var rY = grid1H/32.0+1.0;
	
	#-grid---
	for i in range( rY ): # Rows
		var ia = i*32;
		draw_line(Vector2( icX , icY+ia ), Vector2( grid1W, icY+ia ), Color(1, 1, 1, 0.5 ) , 1, false  ); #horizontal
	for i in range( rX ): # Columns
		var ia = i*32;
		draw_line(Vector2( icX+ia , icY ), Vector2( icX+ia, grid1H ), Color(1, 1, 1, 0.5 ) , 1, false  ); #horizontal
	
	
	
	
	
	if ( eventPressed == false ):
		draw_rect(Rect2(mGx, mGy, 32, 32), Color.YELLOW, false, 1 );
	draw_rect(absRect, Color.BLUE, false, 2 );
	





func _unhandled_input(_event):
	pass;
	
	#if( Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && Mimg == 1 && eventPressed == false ):
		##Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
		#
		#temp_mX = snapped(  get_global_mouse_position().x, 32 );
		#temp_mY = snapped(  get_global_mouse_position().y, 32 );
		#
		#absRect = Rect2(mG.x, mG.y, 32, 32 );
		#eventPressed = true;
	#
	#
	#if ( ! Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) ):
		##Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN);
		#eventPressed = false;
		#
		#if ( absRect.get_area() == 0 ):
			#absRect = Rect2(temp_mX, temp_mY, 32, 32 );
		#
		#var absRect2 = absRect.abs();
		#absRect = absRect2;
		#
		#if (absRect.position.x < 0):
			#absRect.size.x = absRect.size.x + absRect.position.x;
			#absRect.position.x = 0;
		#if (absRect.position.y < 0):
			#absRect.size.y = absRect.size.y + absRect.position.y;
			#absRect.position.y = 0;
		#
		#
		#
		#if ( tempabsRect.size.x > get_rect().size.x ):
			#var tempXX = tempabsRect.size.x - get_rect().size.x;
			#absRect.size.x = absRect.size.x - tempXX;
			#tempabsRect.size.x = 0;
		#if ( tempabsRect.size.y > get_rect().size.y ):
			#var tempYY = tempabsRect.size.y - get_rect().size.y;
			#absRect.size.y = absRect.size.y - tempYY;
			#tempabsRect.size.y = 0;
		#
		#
		#
		#mouse_tex = ImageTexture.create_from_image(texture.get_image().get_region( absRect ) );
		#
		#
	#
	#
	#
	#if event is InputEventMouseMotion && eventPressed == true:
		#mmW = snapped(  get_global_mouse_position().x, 32 ) - temp_mX;
		#mmH = snapped(  get_global_mouse_position().y, 32 ) - temp_mY;
		#
		#
		#tempabsRect = Rect2(0, 0, snapped(  get_global_mouse_position().x, 32 ), snapped(  get_global_mouse_position().y, 32 ) );
		#
		##if ( tempabsRect.size.x > get_rect().size.x ):
			##tempXXminus = tempabsRect.size.x - get_rect().size.x;
		#
		#absRect = Rect2(temp_mX, temp_mY, mmW, mmH );
		#
		#
	#
	
	

#var tempXXminus = 0;


