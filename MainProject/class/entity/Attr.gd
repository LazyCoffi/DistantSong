extends Node
class_name Attr

var ScriptTree = TypeUnit.type("ScriptTree")
var Function = TypeUnit.type("Function")
var AttrNode = TypeUnit.type("AttrNode")

var table

func _init():
	table = {}

func copy():
	var ret = TypeUnit.type("Attr").new()
	ret.table = {}
	for key in table.keys():
		ret.table[key] = table[key].copy()
	
	return ret

func setTable(table_):
	table = table_

func getAttr(attr_name):
	return table[attr_name].getAttr()

func getAttrType(attr_name):
	return table[attr_name].getAttrType()

func getAttrList():
	var ret = []
	for attr_node in table.values():
		if attr_node != null:
			ret.append(attr_node.getAttr())

	return ret

func setAttr(attr_name, attr):
	table[attr_name].setAttr(attr)

func addAttr(attr_node):
	var attr_name = attr_node.getAttrName()
	table[attr_name] = attr_node

func delAttr(attr_name):
	table[attr_name] = null

func getIndexList():
	var ret = []
	for key in table.keys():
		if table[key] != null:
			ret.append(key)

	return ret

func getFullIndexList():
	return table.keys()

func addIndex(index):
	table[index] = null

func delIndex(index):
	table.erase(index)

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObjectDict("table", table)

	return script_tree

func loadScript(script_tree):
	table = script_tree.getObjectDict("table", AttrNode)
