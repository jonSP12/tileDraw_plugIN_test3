@tool
extends EditorPlugin

const menuScene = preload("res://menu/menu.tscn");
const tileDrawNode = preload("res://test3/tileDrawNode.gd");
const tileDrawIcon = preload("res://test3/icon.png");

#---------//---inspector---//---------
var tlDrawInspector = preload("res://addons/tiledrawtest2/tileDrawInspector.gd");


var dockedScene;
var whatIsvisible;
var TileDrawNode;





func _enter_tree():
	add_custom_type("TileDraw", "Node2D", tileDrawNode, tileDrawIcon );
	dockedScene = menuScene.instantiate();
	add_control_to_container(CONTAINER_CANVAS_EDITOR_SIDE_RIGHT, dockedScene );
	dockedScene.custom_minimum_size = Vector2(10,0);
	
	
	tlDrawInspector  = tlDrawInspector.new();
	tlDrawInspector.PlugInDockedScene = dockedScene;
	add_inspector_plugin(tlDrawInspector);
	#TileDrawNode.tileDrawInspec = tlDrawInspector;
	
	



func _handles(object: Object) -> bool:
	#return object is tileDrawNode
	if ( object is tileDrawNode ):
		TileDrawNode = object;
		TileDrawNode.menuDock = dockedScene
		#TileDrawNode.tileDrawInspec = tlDrawInspector;
		return true
	return false
	


func _make_visible(visible: bool) -> void:
	dockedScene.visible = visible
	whatIsvisible = visible;




func _input(event):
	
	#if ( event is InputEventMouseMotion ):
		#print( get_tree().get_edited_scene_root().get_parent().get_visible_rect()   )
	
	pass;


func _forward_canvas_gui_input(event):
	if (event is InputEventMouseButton ):
		dockedScene.visible = true;
		return true
	pass;


var mouseDEL = 0;


var inspectorListSelected;
var arrayList = [];
var fuckCheck = true;

func _debugInspector():
	if ( tlDrawInspector.label_debug != null && TileDrawNode != null ):
		
		var IL = tlDrawInspector.itmListLayer;
		var IL_selectedItems = IL.get_selected_items();
		var IL_name = IL.get_item_text ( IL_selectedItems[0] );
		
		if ( fuckCheck == true ):
			for n in IL.get_item_count():
				arrayList.append( "layer: " + str(n) );
			print(arrayList);
			fuckCheck = false;
		
		
		
		tlDrawInspector.label_debug.text = "---- Inspector ----
		" + str("IL_selectedItems: ") + str(IL_selectedItems) + str("
		")+ str("IL_name: ") + str( IL_name ) + str("
		")+ str("Inspector_itemListNum: ") + str(tlDrawInspector.itemListNum) + str("
		")+ str("\n---- TileDraw ----") + str("
		")+ str("layerPOS: ") + str(TileDrawNode.layerPOS) + str("
		")+ str("toolCheck: ") + str(TileDrawNode.toolCheck) + str("\n\n")   ;
	
	#itemListNum
	





func _process(delta):
	_debugInspector();
	
	
	
	#if ( Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && mouseDEL == 0 ):
	if ( Input.is_key_pressed(KEY_A) && mouseDEL == 0 ):
		mouseDEL = 1;
		
		#var rect = get_editor_interface().get_editor_main_screen().get_global_rect();
		#var rect = get_tree().get_edited_scene_root().get_parent().get_viewport().get_mouse_position();
		var top_2D = get_editor_interface().get_base_control().get_child(0).get_child(0).get_child(2).get_child(0)
		#print( top_2D )
		
		#var top_2D = get_editor_interface().get_base_control().get_child(0).get_child(0).get_child(2).get_child(0)
		var mosPOSI = get_editor_interface().get_editor_main_screen().get_child(0).get_child(1).get_local_mouse_position();
		var viewWindowRect = get_editor_interface().get_editor_main_screen().get_child(0).get_child(1).get_child(0).get_child(0).get_child(0).get_rect();
		
		
		
		#var top_2D = get_editor_interface().get_base_control().get_child(0).get_child(0).get_child(2).get_child(0)  # <- DONT DELETE this gives that shit 2D button is pressed == true
		#var mosPOSI = get_editor_interface().get_editor_main_screen().get_child(0).get_child(1).get_local_mouse_position(); # <- DONT DELETE this gives that shit func _forward_canvas_gui_input(event):
		
		#if ( top_2D.button_pressed == true ):
			#print( "\n2D button_on_TOP_of_that_Thing: " + str (  top_2D ) )
			#print( "Edit View Rect: ------------------>>>>   " + str (  viewWindowRect ) )
			#print( "get_editor_interface_mouse pos: " + str (  mosPOSI ) )
			#
			#if  Rect2(Vector2(), viewWindowRect.size).has_point( mosPOSI ):
				#print("Mouse TRUE");
			#else:
				#print("Mouse FALSE");
		
		
		#if rect.has_point(mosPOSI):
			#print("mouse is inside control")
		#else:
			#print("mouse is NOT inside control")
		
		
		
		
	if ( ! Input.is_key_pressed(KEY_A) && mouseDEL != 0 ):
		mouseDEL = 0;
		
	
	#
	
	
	pass;





func _forward_canvas_draw_over_viewport(overlay):
	#if (overlay.get_class() == "CanvasItemEditorViewport"):
		##Global.globalMainScreenEditor = overlay.get_class();
		#print(overlay.get_class() )
	
	#print( overlay.get_class() )
	#overlay.draw_circle(overlay.get_local_mouse_position(), 164, Color.WHITE)
	##overlay.draw_texture( img.mouse_tex, overlay.get_local_mouse_position() );
	
	
	
	pass;





func _exit_tree():
	remove_custom_type("TileDraw");
	remove_control_from_docks(dockedScene);
	remove_inspector_plugin(tlDrawInspector);
	dockedScene.free();
	
