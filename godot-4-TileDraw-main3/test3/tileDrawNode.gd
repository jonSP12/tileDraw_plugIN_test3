@tool
extends Node2D
class_name tileDrawX1;


#const plugScript = preload("res://addons/tiledrawtest2/tiledrawtest2.gd")


var menuScene = preload("res://menu/menu.tscn").instantiate();
var menuScene2 = menuScene.get_node_or_null("draw");



var loadReady: bool = true;
var mouseJustPress: bool = false;

var mXG;
var mYG;
var mGpos: Vector2 = Vector2(0, 0);
var eraseCheck: bool = true;
var toolCheck: int = 0;
var SelctRect = Rect2(0, 0, 0, 0 );
var SelctImg;
var SelctText;
var SelctPress: bool = true;
var viewMouse_position;
var font;
var combined_texture;
var menuDock;
var tileDrawInspec;

var mouseGroup = {
	'Fnum': []
}

#@export var layers = 
var layers = {
	'Lnum': [ {} ]
}

var layersCopy = {};
#var layersCopy = {
	#'Lnum': [ {} ]
#}

var layersCopyMousePoint;

#@export var layerPOS = 0;
var layerPOS = 0;
var layerMax = layers.Lnum.size();

func add_layers():
	print( "tileDrawNode layers.Lnum.size " + str( layers.Lnum.size() ) );
	print( "tileDrawNode layerMax " + str( layerMax ) );
	print( "\n" );
	







var drawText;
var mouseInEditor: bool = false;





#var layer_OP = 3;
#
#func _get( property ):
	#if ( property == 'Layer Options/layer Select' ):
		#return layer_OP;
#
#
#func  _set( property, value ):
	#if ( property == 'Layer Options/layer Select' ):
		#value = clamp(value, 0 , 5);
		#layer_OP = value;
	#return true;
#
#
#func _get_property_list() -> Array:
	#var props = []
#
	#props.append(
		#{
			#'name': 'LAYERS',
			#'type': TYPE_NIL,
			#'usage': PROPERTY_USAGE_CATEGORY 
		#}
	#)
	#props.append(
		#{
			#'name': 'Layer Options/layer Select',
			#'type': TYPE_INT,
			#"hint": PROPERTY_HINT_ENUM,
			#"hint_string": "layer 0,layer 1,layer 2,layer 3"
		#}
	#)
	#return props


var mousePress1 = true;
var mouseGLget1;
var anotherMouseDelPress = 0;


func _another_Input():
	if ( Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && mousePress1 == true ):
		mouseGLget1 = mGpos;
		mousePress1 = false;
	elif ( Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && mousePress1 == false ):
		
		var mouseX = mXG - mouseGLget1.x;
		var mouseY = mYG - mouseGLget1.y;
		#if ( mouseX == 0 || mouseY == 0 ):
			#mouseX = 32;
			#mouseY = 32;
		
		SelctRect = Rect2(mouseGLget1.x, mouseGLget1.y, mouseX, mouseY );
		
	else:
		mouseGLget1 = mGpos;
		if ( SelctRect.size.x == 0 ):
			SelctRect.size.x = 32;
		if ( SelctRect.size.y == 0  ):
			SelctRect.size.y = 32;
		
	
	
	


func _input(event):
	pass;



var texture1;
var texture2;
var imgTestTheFuck

func _ready():
	font = ThemeDB.fallback_font;
	




func _process(delta):
	layerMax = layers.Lnum.size();
	
	mXG = snapped(  get_global_mouse_position().x, 32 );
	mYG = snapped(  get_global_mouse_position().y, 32 );
	mGpos = Vector2 (mXG, mYG);
	
	if ( menuDock.get_node_or_null("BtnMove1/portContainer").mouseONme == true ):
		
		if ( Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && anotherMouseDelPress <= 0 ):
			anotherMouseDelPress = 5;
		if ( ! Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && anotherMouseDelPress > 0 ):
			anotherMouseDelPress -= 1;
			#drawText = menuDock.get_node_or_null("BtnMove1/portContainer/SbViewport/image").mouse_tex;
			drawText = Global.tileDrawNodeDrawText;
			#print(anotherMouseDelPress)
	
	
	if ( Engine.is_editor_hint() ):
		
		
		
		
		#var viewRect = get_tree().get_edited_scene_root().get_parent().get_visible_rect();
		#var viewMouse_position = get_tree().get_edited_scene_root().get_parent().get_parent().get_local_mouse_position()
		
		var top_2D = EditorInterface.get_base_control().get_child(0).get_child(0).get_child(2).get_child(0)
		var viewRect = EditorInterface.get_editor_main_screen().get_child(0).get_child(1).get_child(0).get_child(0).get_child(0).get_rect();
		viewMouse_position = EditorInterface.get_editor_main_screen().get_child(0).get_child(1).get_local_mouse_position();
		viewMouse_position = EditorInterface.get_editor_main_screen().get_child(0).get_child(1).get_local_mouse_position();
		var mouseArr0w = Input.get_current_cursor_shape()
		
		
		#---//---selection-tool----//------
		if ( toolCheck == 1 && mouseInEditor == true && top_2D.button_pressed == true  ):
			
			#SelctRect = Rect2(mXG, mYG, 32*11, 32*11 );
			_another_Input();
			
			if ( Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)):
				SelctImg = null;
				SelctText = null;
				#layersCopyMousePoint = mGpos;
				layersCopyMousePoint = Vector2( SelctRect.abs().position.x, SelctRect.abs().position.y );
			if ( Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && SelctPress == true ):
				SelctImg = null;
				SelctText = null;
				SelctPress = false;
				
				
				
			elif ( ! Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && SelctPress == false ):
				SelctPress = true;
				
				
				#SelctRect = Rect2(0, 0, 0, 0 );
				SelctImg = get_viewport().get_texture().get_image().get_region( SelctRect.abs() );
				SelctText = ImageTexture.create_from_image(SelctImg);
				#print( get_viewport() )
				layersCopy.clear();
				
				for i in layers.Lnum[ layerPOS ].keys().size():
					if SelctRect.abs().has_point( layers.Lnum[ layerPOS ].keys()[i] ):
						#print("has point")
						
						var coords1 = layers.Lnum[ layerPOS ].keys()[i];
						var imgText1  = layers.Lnum[ layerPOS ].values()[i];
						
						layersCopy[ coords1 ] = imgText1; 
						
						
						
						pass;
				
				#layersCopyMousePoint = mGpos;
				layersCopyMousePoint = Vector2( SelctRect.abs().position.x, SelctRect.abs().position.y );
				if ( layersCopy.values().size() > 1 ):
					var img1 = layersCopy.values()[0];
					
					var format = img1.get_image().get_format();
					var imgSelect1 = Image.create(SelctRect.size.x, SelctRect.size.y, false, format);
					
					for i in layersCopy.size():
						var imgPos = layersCopy.keys()[i];
						var img11 = layersCopy.values()[i];
						imgSelect1.blend_rect(img11.get_image(), Rect2(Vector2(0, 0), Vector2(32, 32) ), imgPos-layersCopyMousePoint );
						
						
						pass;
					
					combined_texture = ImageTexture.create_from_image(imgSelect1);
					drawText = combined_texture;
					
					#print(tileDrawInspec);
					if ( tileDrawInspec != null ):
						tileDrawInspec.btn_brush_pressed();
						
					
				else:
					if ( layers.Lnum[ layerPOS ].keys().size() == 0 ):
						print("tileDraw: its empty no tiles on screen");
						return;
					else:
						if ( layersCopy.values().size() <= 0 ):
							print("tileDraw: nothing selected");
							combined_texture = null;
							return
						
						var img1 = layersCopy.values()[0];
						combined_texture = img1;
						drawText = combined_texture;
						print(tileDrawInspec);
						if ( tileDrawInspec != null ):
							tileDrawInspec.btn_brush_pressed();
							
					
				
				
				
				
				
			
			
		
		
		
		
		
		if  Rect2(Vector2(), viewRect.size).has_point( viewMouse_position ):
			mouseInEditor = true;
			
		else:
			mouseInEditor = false;
		
		
		
		
		
		if ( mouseInEditor == false || top_2D.button_pressed == false || toolCheck != 0 ):
			queue_redraw();
			return;
		
		if ( mouseArr0w != 0 ):
			return;
		
		if ( Global.MenuMouseONme == true ):
			return;
		
		
	
	
	if ( Input.is_action_just_pressed("ui_page_down") ):
		layerPOS -= 1;
	elif ( Input.is_action_just_pressed("ui_page_up") ):
		layerPOS += 1;
	layerPOS = clamp(layerPOS, 0, layerMax-1 );
	
	
	
	
	#drawText = Global.tileDrawNodeDrawText;
	
	
	
	
	#if ( Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && mouseInEditor == false && anotherMouseDelPress == true ):
		#anotherMouseDelPress = false;
		#if ( menuDock.get_node_or_null("BtnMove1/portContainer").mouseONme == true ):
			#drawText = Global.tileDrawNodeDrawText;
	#elif ( ! Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && mouseInEditor == false && anotherMouseDelPress == false ):
		#anotherMouseDelPress = true;
	
	
	
	
	
	if ( Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && mouseJustPress == false ):
		mouseJustPress = true;
		
		#print(Global.tileDrawNodeDrawText.get_size() );#
		
		if ( drawText == null ):
			return;
		
		mouseGroup.Fnum.clear();
		#layers.Lnum.clear();
		
		for i in range(0, drawText.get_image().get_size().x,32 ):
			for j in range(0,  drawText.get_image().get_size().y, 32):
				
				mouseGroup.Fnum.append(  { "cords": Vector2(i, j), "img": ImageTexture.create_from_image(drawText.get_image().get_region( Rect2( i, j, 32, 32) ) ) } );
		
	if ( ! Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && mouseJustPress == true ):
		mouseJustPress = false;
		eraseCheck = true;
	
	
	if ( Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && mouseJustPress == true ):
		
		for i in range (0, mouseGroup.Fnum.size() ):
			#canvasTex[ mGpos + mouseGroup.Fnum[i].cords ] = mouseGroup.Fnum[i].img;
			var coords = mGpos + mouseGroup.Fnum[i].cords;
			var imgText  = mouseGroup.Fnum[i].img;
			layers.Lnum[ layerPOS ][ coords ] = imgText; 
			
		
		
		
	if ( Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) ):
		
		
		if ( eraseCheck == true ):
			eraseCheck = false;
			
			mouseGroup.Fnum.clear();
			for i in range(0, drawText.get_image().get_size().x,32 ):
				for j in range(0,  drawText.get_image().get_size().y, 32):
					mouseGroup.Fnum.append(  { "cords": Vector2(i, j), "img": ImageTexture.create_from_image(drawText.get_image().get_region( Rect2( i, j, 32, 32) ) ) } );
			
			
			for i in range (0, mouseGroup.Fnum.size() ):
				#canvasTex[ mGpos + mouseGroup.Fnum[i].cords ] = mouseGroup.Fnum[i].img;
				var coords = mGpos + mouseGroup.Fnum[i].cords;
				var imgText  = mouseGroup.Fnum[i].img;
				layers.Lnum[ layerPOS ][ coords ] = imgText;
			
		
		
		
		for i in range (0, mouseGroup.Fnum.size() ):
			#canvasTex.erase( mGpos + mouseGroup.Fnum[i].cords );
			var coords = mGpos + mouseGroup.Fnum[i].cords;
			layers.Lnum[ layerPOS ].erase( coords );
			
		
	
	
	
	if ( Engine.is_editor_hint() ):
		queue_redraw();
	
	
	




func _draw():
	
	if ( Engine.is_editor_hint() ):
	
		if (drawText == null ):
			return;
			
		if ( drawText.get_size() < Vector2(32, 32)  ):
			return;
	
	
	#for i in canvasTex: 
		#draw_texture( canvasTex[i], i );
	
	for p in range(0, layerMax ):
		for i in layers.Lnum[p]:
			if ( layers.Lnum[p].has(i) ):
				draw_texture( layers.Lnum[p][i], i );
	
	
	
	
	if ( drawText != null && mouseInEditor == true && toolCheck == 0 ):
		draw_texture(drawText, mGpos );
		
		
		
	
	if ( toolCheck == 1 && mouseInEditor == true ):
		if ( Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) ):
			draw_rect( SelctRect, Color.YELLOW, false, 2 );
			draw_string (font, Vector2(mXG, mYG-30), "mGpos2: " + str(mGpos))
			draw_string (font, Vector2(mXG, mYG-50), "SelctRect W H : " + str(Vector2( SelctRect.size.x, SelctRect.size.y )  ))
			draw_string (font, Vector2(mXG, mYG-80), "SelctRect Area : " + str( SelctRect.get_area()/32  ))
		
		if ( combined_texture != null ):
			draw_texture(combined_texture, mGpos );
			pass;
		
		
		if ( SelctText != null ):
			#OLD draws tiles in layersCopy instead of image
			#for i in layersCopy:
				#draw_texture( layersCopy[i], mGpos + i - layersCopyMousePoint  );
				#
			pass;
			
		
		
		
	
	






