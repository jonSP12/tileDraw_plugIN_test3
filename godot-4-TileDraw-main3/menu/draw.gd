@tool
extends Sprite2D

@onready var _menuArea = get_node_or_null("../menuArea");
@onready var _image = get_node_or_null("../BtnMove1/portContainer/SbViewport/image");
@onready var portContainer = get_node_or_null("../BtnMove1/portContainer");
@onready var _btnMove1 = get_node_or_null("../BtnMove1");


var mouseJustPress: bool = false;
var mGpos: Vector2 = Vector2(0, 0);
var eraseCheck: bool = true;

var mouseGroup = {
	'Fnum': []
}

var canvasTex = {};

var mouse_tex;






func _input(_event):
	if ( Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && mouseJustPress == false ):
		mouseJustPress = true;
		
		if ( mouse_tex == null  ):
			return;
		
		mouseGroup.Fnum.clear();
		
		for i in range(0, mouse_tex.get_image().get_size().x,32 ):
			for j in range(0,  mouse_tex.get_image().get_size().y, 32):
				
				mouseGroup.Fnum.append(  { "cords": Vector2(i, j), "img": ImageTexture.create_from_image(mouse_tex.get_image().get_region( Rect2( i, j, 32, 32) ) ) } );
		
		
		
		
	if ( ! Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && mouseJustPress == true ):
		mouseJustPress = false;
		eraseCheck = true;
		
	
	





func _process(_delta):
	if ( _image.mouse_tex != null ):
		mouse_tex = _image.mouse_tex;
		Global.tileDrawNodeDrawText = _image.mouse_tex;
	
	
	
	var mXG = snapped(  get_global_mouse_position().x, 32 );
	var mYG = snapped(  get_global_mouse_position().y, 32 );
	mGpos = Vector2 (mXG, mYG);
	
	
	
	
	if ( Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && mouseJustPress == true && _menuArea.mouseONme == false && _btnMove1.mouseONme == false ):
		
		for i in range (0, mouseGroup.Fnum.size() ):
			canvasTex[ mGpos + mouseGroup.Fnum[i].cords ] = mouseGroup.Fnum[i].img;
	
	if ( Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) ):
		
		if ( eraseCheck == true ):
			eraseCheck = false;
			
			mouseGroup.Fnum.clear();
			for i in range(0, mouse_tex.get_image().get_size().x,32 ):
				for j in range(0,  mouse_tex.get_image().get_size().y, 32):
					mouseGroup.Fnum.append(  { "cords": Vector2(i, j), "img": ImageTexture.create_from_image(mouse_tex.get_image().get_region( Rect2( i, j, 32, 32) ) ) } );
			
			for i in range (0, mouseGroup.Fnum.size() ):
				canvasTex[ mGpos + mouseGroup.Fnum[i].cords ] = mouseGroup.Fnum[i].img;
			
		
		
		for i in range (0, mouseGroup.Fnum.size() ):
			canvasTex.erase( mGpos + mouseGroup.Fnum[i].cords );
		
		
	
	
	queue_redraw();





func  _draw():
	pass;
	#
	#if ( mouse_tex == null  ):
		#return;
	#
	#
	#for i in canvasTex: 
		#draw_texture( canvasTex[i], i );
	#
	#
	#
	#if ( mouse_tex != null && _menuArea.mouseONme == false ):
		#draw_texture(mouse_tex, mGpos );
	#
	
	
	



