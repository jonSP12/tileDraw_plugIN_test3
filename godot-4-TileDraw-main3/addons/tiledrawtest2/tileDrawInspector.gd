@tool
extends EditorInspectorPlugin

var btn_UpLayer;
var itemLlist1;
var readyFUNC_del : bool = true;

var PlugInDockedScene;
var PlugTileDrawNode;
var layerNameBox;
var layerText;




const inspect0 = preload("res://inspector/inspector.tscn");
var inspect1;
var btn_brush;
var btn_select;
var btn_test1;
var btn_test2;
var btn_test3;
var btn_test4;

var itmListLayer;
var itemListNum: int = 0;
var itemselected: bool = true;

var btn_UP;
var btn_DN;
var btn_Add_ly;
var btn_Rem_ly;
var btn_Mer_ly;
var btn_Nam_ly;

var btn_Debug;
var label_debug;


func btn_tools( btn_name ):
	var array_btn: Array = [ btn_brush, btn_select, btn_test1, btn_test2, btn_test3, btn_test4 ];
	
	for n in array_btn.size():
		if ( array_btn[n] != btn_name ):
			array_btn[n].button_pressed = false;
		pass;



func _can_handle(object):
	if object is tileDrawX1:
		PlugTileDrawNode = object;
		PlugTileDrawNode.tileDrawInspec = self;
		return true
	return false





func _parse_end(object):
	
	inspect1 = inspect0.instantiate();
	
	btn_brush = inspect1.get_node("Center1/GridContainer/Btn_brush");
	btn_select = inspect1.get_node("Center1/GridContainer/Btn_select");
	btn_test1 = inspect1.get_node("Center1/GridContainer/Btn_test1");
	btn_test2 = inspect1.get_node("Center1/GridContainer/Btn_test2");
	btn_test3 = inspect1.get_node("Center1/GridContainer/Btn_test3");
	btn_test4 = inspect1.get_node("Center1/GridContainer/Btn_test4");
	
	itmListLayer = inspect1.get_node("Center2/Control/ItemList");
	itmListLayer.select(0, true);
	
	btn_UP = inspect1.get_node("Center2/Control/btn_UP");
	btn_DN = inspect1.get_node("Center2/Control/btn_DN");
	btn_Add_ly = inspect1.get_node("Center2/Control/Btn_add_Layer");
	btn_Rem_ly = inspect1.get_node("Center2/Control/Btn_del_Layer");
	btn_Mer_ly = inspect1.get_node("Center2/Control/GridContainer/Btn_mer_layer");
	btn_Nam_ly = inspect1.get_node("Center2/Control/GridContainer/Btn_nam_layer");
	btn_Debug = inspect1.get_node("debug");
	label_debug = inspect1.get_node("debug_txt");
	
	
	itmListLayer.multi_selected.connect(self.itmListLayer_selected);
	btn_brush.pressed.connect(self.btn_brush_pressed);
	btn_select.pressed.connect(self.btn_select_pressed);
	btn_test1.pressed.connect(self.btn_test1_pressed);
	btn_test2.pressed.connect(self.btn_test2_pressed);
	btn_test3.pressed.connect(self.btn_test3_pressed);
	btn_test4.pressed.connect(self.btn_test4_pressed);
	
	btn_UP.pressed.connect(self.btn_UP_pressed);
	btn_DN.pressed.connect(self.btn_DN_pressed);
	btn_Add_ly.pressed.connect(self.btn_Add_ly_pressed);
	btn_Rem_ly.pressed.connect(self.btn_Rem_ly_pressed);
	btn_Mer_ly.pressed.connect(self.btn_Mer_ly_pressed);
	btn_Nam_ly.pressed.connect(self.btn_Nam_ly_pressed);
	
	btn_Debug.pressed.connect(self.btn_Debug_pressed);
	
	
	var listSize = itmListLayer.get_item_count();
	for n in range( listSize-1 ):
		if ( PlugTileDrawNode.layers.Lnum.size() <  listSize  ):
			PlugTileDrawNode.layers.Lnum.append( {} ); 
	
	print("itmListLayer_N: " + str( itmListLayer.get_item_count() )  )
	print("PlugTileDrawNode.layers.Lnum: " + str( PlugTileDrawNode.layers.Lnum.size() )  )
	
	
	add_custom_control(inspect1);
	
	
	
	
	# in here i have to use a boolean or he will throw an error saying
	# the signal is already added and cant be added twice
	if ( readyFUNC_del == true ):
		layerNameBox = PlugInDockedScene.LayerName;
		layerNameBox.confirmed.connect( self.labelNameBox_confirmed );
		layerNameBox.canceled.connect( self.labelNameBox_canceled );
		layerText = PlugInDockedScene.LayerText;
		
		readyFUNC_del = false;
	
	





func btn_brush_pressed():
	btn_tools( btn_brush );
	PlugTileDrawNode.toolCheck = 0;
	PlugTileDrawNode.SelctImg = null;
	PlugTileDrawNode.SelctText = null;
	btn_brush.button_pressed = true;

func btn_select_pressed():
	btn_tools( btn_select );
	PlugTileDrawNode.toolCheck = 1;
	PlugTileDrawNode.SelctImg = null;
	PlugTileDrawNode.combined_texture = null;

func btn_test1_pressed():
	btn_tools( btn_test1 );
	PlugTileDrawNode.toolCheck = 2;

func btn_test2_pressed():
	btn_tools( btn_test2 );
	PlugTileDrawNode.toolCheck = 3;

func btn_test3_pressed():
	btn_tools( btn_test3 );
	PlugTileDrawNode.toolCheck = 4;

func btn_test4_pressed():
	btn_tools( btn_test4 );
	PlugTileDrawNode.toolCheck = 5;

func btn_UP_pressed(): # move layers UP
	var listSize = itmListLayer.get_item_count();
	PlugTileDrawNode.layerMax = listSize;
	#PlugTileDrawNode.add_layers();
	
	var itemListSize = itmListLayer.get_item_count();
	var itemListSelectedItems = itmListLayer.get_selected_items();
	
	for n in itemListSize:
		if ( itemListSelectedItems.has(n) && n >= 1 ):
			if ( itemListSelectedItems[0] != 0 ):
				itmListLayer.move_item(itemListSelectedItems[0], n - 1);
				
				var a1 = PlugTileDrawNode.layers.Lnum[n-1];
				var a2 = PlugTileDrawNode.layers.Lnum[n];
				PlugTileDrawNode.layers.Lnum[n] = a1;
				PlugTileDrawNode.layers.Lnum[n-1] = a2;

func btn_DN_pressed(): # move layers DOWN
	var itemListSize = itmListLayer.get_item_count();
	var itemListSelectedItems = itmListLayer.get_selected_items();
	var itemSelectedArraySize = itmListLayer.get_selected_items().size();
	
	for n in range(itemListSize, -1, -1 ): # Loop needs to be upSideDown, stupid reason he leaves a hole in the middle
		if ( itemListSelectedItems.has(n) && n < itemListSize-1 ):
			if ( itemListSelectedItems[itemSelectedArraySize-1] != itemListSize-1 ):
				#itmListLayer.move_item(n, n+1);
				itmListLayer.move_item(itemListSelectedItems[0], n+1);
				
				var a1 = PlugTileDrawNode.layers.Lnum[n+1];
				var a2 = PlugTileDrawNode.layers.Lnum[n];
				PlugTileDrawNode.layers.Lnum[n] = a1;
				PlugTileDrawNode.layers.Lnum[n+1] = a2;

func btn_Add_ly_pressed():
	var listSize = itmListLayer.get_item_count();
	itmListLayer.add_item("     layer " + str(listSize) );
	for n in range( listSize-1 ):
		if ( PlugTileDrawNode.layers.Lnum.size() <=  listSize  ):
			PlugTileDrawNode.layers.Lnum.append( {} ); 
	
	PlugTileDrawNode.add_layers();

func btn_Rem_ly_pressed():
	var listSize = itmListLayer.get_item_count();
	var itemListSelectedItems = itmListLayer.get_selected_items();
	
	if ( listSize <= 1 ):
		return;
	
	for n in range(listSize, -1, -1 ):
		if ( itemListSelectedItems.has(n) ):
			print(itemListSelectedItems)
			itmListLayer.remove_item(n);
			PlugTileDrawNode.layerMax = listSize-1;
			PlugTileDrawNode.layers.Lnum.remove_at(n);
	
	var listSize2 = itmListLayer.get_item_count();
	if ( itemListNum <= 1  ):
		itmListLayer.select(0, true);
		itmListLayer_selected(0, true);
	else:
		itmListLayer.select(itemListNum - 1, true);
		itmListLayer_selected(itemListNum -1, true);
	PlugTileDrawNode.layerMax = listSize-1;
	PlugTileDrawNode.add_layers();

func btn_Mer_ly_pressed():
	pass;

func btn_Nam_ly_pressed(): #changes layer name

	var itemListSelectedItems = itmListLayer.get_selected_items();
	if ( ! itemListSelectedItems.is_empty() ):
		layerNameBox = PlugInDockedScene.LayerName;
		layerNameBox.visible = true;

func labelNameBox_confirmed(): #confirmation dialog OK button
	
	layerText = PlugInDockedScene.LayerText;
	if ( layerText.text != "" ):
		var itemListSize = itmListLayer.get_item_count();
		var itemListSelectedItems = itmListLayer.get_selected_items();
		for n in itemListSize:
			if ( itemListSelectedItems.has(n) ):
				itmListLayer.set_item_text(n, str("     ") + str(layerText.text)  );
	
	layerText.text = ""

func labelNameBox_canceled(): #confirmation dialog CANCEL button
	layerText.text = ""
	pass;

func itmListLayer_selected(index, selected):
	itemListNum = index;
	itemselected = selected;
	PlugTileDrawNode.layerPOS = index;

func btn_Debug_pressed():
	if ( label_debug.visible == false ):
		label_debug.visible = true;
	else:
		label_debug.visible = false;
	









"""
	var hSperator0 = HSeparator.new();
	var hSperator1 = hSperator0.duplicate();
	var hSperator2 = hSperator0.duplicate();
	var hSperator3 = hSperator0.duplicate();
	var hSperator4 = hSperator0.duplicate();
	hSperator0.custom_minimum_size.y = 30;
	hSperator1.custom_minimum_size.y = 10;
	hSperator1.set( "theme_override_styles/separator" , StyleBoxEmpty.new() );
	hSperator2.custom_minimum_size.y = 10;
	hSperator2.set( "theme_override_styles/separator" , StyleBoxEmpty.new() );
	hSperator3.custom_minimum_size.y = 10;
	hSperator3.set( "theme_override_styles/separator" , StyleBoxEmpty.new() );
	
	
	var label1 = Label.new();
	label1.set_text("LAYER SELECT");
	
	var box1 = StyleBoxFlat.new();
	box1.bg_color = Color.from_hsv(0, 0, 1, 0.2);
	var box2 = StyleBoxFlat.new();
	box2.bg_color = Color.from_hsv(0, 0, 1, 0.2);
	
	box2.corner_radius_top_left = 5;
	box2.corner_radius_top_right = 5;
	box2.corner_radius_bottom_right = 5;
	box2.corner_radius_bottom_left = 5;
	
	box2.border_width_left = 5;
	box2.border_width_top = 5;
	box2.border_width_right = 5;
	box2.border_width_bottom = 5;
	
	box2.border_color = Color.from_hsv(0, 0, 1, 0.2);
	box2.border_blend = true;
	
	
	label1.set( "theme_override_styles/normal" , box1 );
	label1.set( "theme_override_font_sizes/font_size" , 15 );
	label1.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;
	
	var btn_Brush = Button.new();
	btn_Brush.text = "Brush";
	btn_Brush.set( "theme_override_styles/normal" , box2 );
	btn_Brush.set( "theme_override_styles/focus",StyleBoxEmpty.new() );
	btn_Brush.tooltip_text = "Merges selected layers\nSelect multiple layers ( crtl+mouseClick )\n then press the button to merge them togheter";
	btn_Brush.set( "theme_override_font_sizes/font_size" , 10 );
	
	var btn_Select = Button.new();
	btn_Select.text = "Brush";
	btn_Select.set( "theme_override_styles/normal" , box2 );
	btn_Select.set( "theme_override_styles/focus",StyleBoxEmpty.new() );
	btn_Select.tooltip_text = "Merges selected layers\nSelect multiple layers ( crtl+mouseClick )\n then press the button to merge them togheter";
	btn_Select.set( "theme_override_font_sizes/font_size" , 10 );
	
	var gridCont2 = GridContainer.new();
	gridCont2.set_custom_minimum_size(Vector2(100, 40));
	gridCont2.columns = 3;
	
	
	
	
	
	
	add_custom_control(hSperator0);
	add_custom_control(label1);
	add_custom_control(hSperator1);
	
	
	var scrollCont1 = ScrollContainer.new();
	var HsplitCont1 = HSplitContainer.new();
	itemLlist1 = ItemList.new();
	
	
	var VboxCont1 = VBoxContainer.new();
	
	var btn_addLayer = Button.new();
	var btn_delLayer = Button.new();
	btn_UpLayer = Button.new();
	var btn_DownLayer = Button.new();
	
	scrollCont1.set_custom_minimum_size(Vector2(150, 90));
	HsplitCont1.set_custom_minimum_size(Vector2(150, 90));
	HsplitCont1.set_dragger_visibility(1);
	
	itemLlist1.set_custom_minimum_size(Vector2(100, 90));
	itemLlist1.set( "theme_override_styles/focus",StyleBoxEmpty.new() );
	itemLlist1.select_mode = 1;
	
	
	btn_addLayer.text = "+";
	btn_addLayer.set( "theme_override_styles/normal" , box1 );
	btn_addLayer.set( "theme_override_styles/focus",StyleBoxEmpty.new() );
	btn_addLayer.tooltip_text = "ADD layer\nadds a layer to the bottom list";
	btn_addLayer.set( "theme_override_font_sizes/font_size" , 12 );
	
	btn_delLayer.text = "-";
	btn_delLayer.set( "theme_override_styles/normal" , box1 );
	btn_delLayer.set( "theme_override_styles/focus",StyleBoxEmpty.new() );
	btn_delLayer.tooltip_text = "DELETE layer\nselect a layer(s) then press\nthe button to delete it";
	btn_delLayer.set( "theme_override_font_sizes/font_size" , 12 );
	
	
	
	btn_UpLayer.icon = ResourceLoader.load("res://menu/sprites/arrUP.png");
	btn_UpLayer.set( "theme_override_styles/focus",StyleBoxEmpty.new() );
	btn_UpLayer.icon_alignment = 1;
	btn_UpLayer.custom_minimum_size.y = 20;
	btn_UpLayer.expand_icon = true;
	btn_UpLayer.tooltip_text = "move Layer(s) UP";
	
	btn_DownLayer.icon = ResourceLoader.load("res://menu/sprites/arrDOWN.png");
	btn_DownLayer.set( "theme_override_styles/focus",StyleBoxEmpty.new() );
	btn_DownLayer.icon_alignment = 1;
	btn_DownLayer.custom_minimum_size.y = 20;
	btn_DownLayer.expand_icon = true;
	btn_DownLayer.tooltip_text = "move Layer(s) DOWN";
	
	
	itemLlist1.multi_selected.connect(self.itemLlist1_selected);
	btn_UpLayer.pressed.connect(self.btn_UpLayer_pressed);
	btn_DownLayer.pressed.connect(self.btn_DownLayer_pressed);
	btn_addLayer.pressed.connect(self.btn_addLayer_pressed);
	btn_delLayer.pressed.connect(self.btn_deleteLayer_pressed);
	
	scrollCont1.add_child( HsplitCont1 );
	HsplitCont1.add_child( itemLlist1 );
	HsplitCont1.add_child( VboxCont1 );

	VboxCont1.add_child( btn_UpLayer );
	VboxCont1.add_child( btn_DownLayer );
	VboxCont1.add_child( btn_addLayer );
	VboxCont1.add_child( btn_delLayer );
	
	
	
	
	for n in 3:
		itemLlist1.add_item("     layer " + str(n) );
	
	itemLlist1.select(0, true);
	
	var listSize = itemLlist1.get_item_count();
	for n in range( listSize-1 ):
		if ( PlugTileDrawNode.layers.Lnum.size() <  listSize  ):
			PlugTileDrawNode.layers.Lnum.append( {} ); 
	
	
	
	
	var gridCont1 = GridContainer.new();
	gridCont1.set_custom_minimum_size(Vector2(100, 40));
	gridCont1.columns = 3;
	
	
	
	
	
	var btn_MergeLayer = Button.new();
	btn_MergeLayer.text = "Merge";
	btn_MergeLayer.set( "theme_override_styles/normal" , box2 );
	btn_MergeLayer.set( "theme_override_styles/focus",StyleBoxEmpty.new() );
	btn_MergeLayer.tooltip_text = "Merges selected layers\nSelect multiple layers ( crtl+mouseClick )\n then press the button to merge them togheter";
	btn_MergeLayer.set( "theme_override_font_sizes/font_size" , 10 );
	
	var btn_RenameLayer = Button.new();
	btn_RenameLayer.text = "Rename";
	btn_RenameLayer.set( "theme_override_styles/normal" , box2 );
	btn_RenameLayer.set( "theme_override_styles/focus",StyleBoxEmpty.new() );
	btn_RenameLayer.tooltip_text = "Change layer Name\nSelect layer press button to\nchange the name";
	btn_RenameLayer.set( "theme_override_font_sizes/font_size" , 10 );
	#btn_RenameLayer.pressed.connect(self.btn_RenameLayer_pressed);
	
	
	gridCont1.add_child( btn_MergeLayer );
	gridCont1.add_child( btn_RenameLayer );
	
	
	
	
	add_custom_control(scrollCont1);
	add_custom_control(hSperator2);
	add_custom_control(gridCont1);
	add_custom_control(hSperator3);
	


func btn_addLayer_pressed():
	var listSize = itemLlist1.get_item_count();
	itemLlist1.add_item("     layer " + str(listSize) );
	for n in range( listSize-1 ):
		if ( PlugTileDrawNode.layers.Lnum.size() <=  listSize  ):
			PlugTileDrawNode.layers.Lnum.append( {} ); 
	
	PlugTileDrawNode.add_layers();
	

func btn_deleteLayer_pressed():
	var listSize = itemLlist1.get_item_count();
	var itemListSelectedItems = itemLlist1.get_selected_items();
	
	if ( listSize <= 1 ):
		return;
	
	for n in range(listSize, -1, -1 ):
		if ( itemListSelectedItems.has(n) ):
			print(itemListSelectedItems)
			itemLlist1.remove_item(n);
			PlugTileDrawNode.layerMax = listSize-1;
			PlugTileDrawNode.layers.Lnum.remove_at(n);
	
	var listSize2 = itemLlist1.get_item_count();
	if ( itemListNum <= 1  ):
		itemLlist1.select(0, true);
		itemLlist1_selected(0, true);
	else:
		itemLlist1.select(itemListNum - 1, true);
		itemLlist1_selected(itemListNum -1, true);
	PlugTileDrawNode.layerMax = listSize-1;
	PlugTileDrawNode.add_layers();
	



func itemLlist1_selected(index, selected):
	#print(  str(index) + str("  ") + str(selected)   );
	itemListNum = index;
	itemselected = selected;
	PlugTileDrawNode.layerPOS = index;
	

func btn_UpLayer_pressed(): # move layers UP
	var listSize = itemLlist1.get_item_count();
	PlugTileDrawNode.layerMax = listSize;
	#PlugTileDrawNode.add_layers();
	
	var itemListSize = itemLlist1.get_item_count();
	var itemListSelectedItems = itemLlist1.get_selected_items();
	
	for n in itemListSize:
		if ( itemListSelectedItems.has(n) && n >= 1 ):
			if ( itemListSelectedItems[0] != 0 ):
				itemLlist1.move_item(itemListSelectedItems[0], n - 1);
				
				var a1 = PlugTileDrawNode.layers.Lnum[n-1];
				var a2 = PlugTileDrawNode.layers.Lnum[n];
				PlugTileDrawNode.layers.Lnum[n] = a1;
				PlugTileDrawNode.layers.Lnum[n-1] = a2;
	

func btn_DownLayer_pressed(): # move layers DOWN
	var itemListSize = itemLlist1.get_item_count();
	var itemListSelectedItems = itemLlist1.get_selected_items();
	var itemSelectedArraySize = itemLlist1.get_selected_items().size();
	
	for n in range(itemListSize, -1, -1 ): # Loop needs to be upSideDown, stupid reason he leaves a hole in the middle
		if ( itemListSelectedItems.has(n) && n < itemListSize-1 ):
			if ( itemListSelectedItems[itemSelectedArraySize-1] != itemListSize-1 ):
				#itemLlist1.move_item(n, n+1);
				itemLlist1.move_item(itemListSelectedItems[0], n+1);
				
				var a1 = PlugTileDrawNode.layers.Lnum[n+1];
				var a2 = PlugTileDrawNode.layers.Lnum[n];
				PlugTileDrawNode.layers.Lnum[n] = a1;
				PlugTileDrawNode.layers.Lnum[n+1] = a2;
	




"""
#endregion







