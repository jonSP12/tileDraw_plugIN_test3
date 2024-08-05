@tool
extends ColorRect

@onready var BtnMove1 = get_node_or_null("../BtnMove1");
@onready var portContainer = get_node_or_null("../BtnMove1/portContainer");

var mouseONme: bool = false;
var mGx : int = 0;
var mGy : int = 0;
var mG : Vector2 = Vector2(0, 0);


func _mouseONme():
	#if (  ( mGx >= position.x && mGx <= position.x + size.x ) &&  ( mGy >= position.y && mGy <= position.y + size.y )  ):
	if  Rect2(Vector2(), size).has_point(mG):
		mouseONme = true;
		Global.MenuMouseONme = true;
	else:
		mouseONme = false;
		Global.MenuMouseONme = false;




func _process(_delta):
	position = BtnMove1.position - Vector2(-20, 10);
	size = portContainer.size + Vector2(25, 20);
	
	
	mGx = snapped( get_local_mouse_position().x, 32 );
	mGy = snapped( get_local_mouse_position().y, 32 );
	mG = Vector2(mGx, mGy);
	
	_mouseONme();
	
	
	





