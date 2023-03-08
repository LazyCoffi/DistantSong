extends "res://design/factory/Factory.gd"
class_name LinearBattleSceneFactory

func _init():
	entity_type = "LinearBattleScene"
	entity = TypeUnit.type(entity_type).instance()

func initMemberList():
	addFuncMember("setSceneName", [
		{"name" : "scene_name", "type" : "String", "param_type" : "val"}
	])
	addFuncMember("addSwitchTarget", [
		{"name" : "target_name", "type" : "String", "param_type" : "val"},
		{"name" : "scene_type", "type" : "String", "param_type" : "val"},
		{"name" : "scene_name", "type" : "String", "param_type" : "val"},
		{"name" : "switch_type", "type" : "String", "param_type" : "val"}
	])
	addObjectMember("scene_model", "LinearBattleModel", "setModel")
