@tool
extends Control

@onready var portContainer = get_node_or_null("../portContainer");
@onready var cam2D = get_node_or_null("../portContainer/SbViewport/cam2D");
@onready var buttonMove = get_node_or_null("..");

var BtnExpUP: bool = false;
var BtnExpDOWN: bool = false;
var BtnExpLEFT: bool = false;
var BtnExpRIGHT: bool = false;
var BtnExpMIDDLE: bool = false;


func _process(_delta):
	
	if ( BtnExpUP == true ):
		portContainer.size.y -= 6;
	elif ( BtnExpDOWN == true ):
		portContainer.size.y += 6;
	elif ( BtnExpLEFT == true ):
		portContainer.size.x -= 6;
	elif ( BtnExpRIGHT == true ):
		portContainer.size.x += 6;
	elif ( BtnExpMIDDLE == true ):
		portContainer.size.x = 350;
		portContainer.size.y = 500;
		cam2D.position = Vector2(0, 0);
		cam2D.zoom = Vector2(1, 1);
		buttonMove.position = Vector2(20, 10);
		
		
	
	portContainer.size.x = clamp(portContainer.size.x, 200, 1000);
	portContainer.size.y = clamp(portContainer.size.y, 200, 1000);
	


func _on_btn_exp_u_button_down():
	BtnExpUP = true;
func _on_btn_exp_u_button_up():
	BtnExpUP = false;


func _on_btn_exp_d_button_down():
	BtnExpDOWN = true;
func _on_btn_exp_d_button_up():
	BtnExpDOWN = false;


func _on_btn_exp_l_button_down():
	BtnExpLEFT = true;
func _on_btn_exp_l_button_up():
	BtnExpLEFT = false;


func _on_btn_exp_r_button_down():
	BtnExpRIGHT = true;
func _on_btn_exp_r_button_up():
	BtnExpRIGHT = false;


func _on_btn_exp_m_button_down():
	BtnExpMIDDLE = true;
func _on_btn_exp_m_button_up():
	BtnExpMIDDLE = false;
