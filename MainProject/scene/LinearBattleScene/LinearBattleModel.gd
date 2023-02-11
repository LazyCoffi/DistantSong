extends Node
class_name LinearBattleModel

var ScriptTree = TypeUnit.type("ScriptTree")
var LinearCharacterCard = TypeUnit.type("LinearCharacterCard")
var LinearSkillCard = TypeUnit.type("LinearSkillCard")
var Function = TypeUnit.type("Function")
var SettingTable = TypeUnit.type("SettingTable")
var PollingBucket = TypeUnit.type("PollingBucket")

var MAX_GROUP_SIZE = 4

var param_table					# Dict

var setting						# SettingTable
var own_character_team			# Array
var enemy_character_team		# Array
var order_bucket				# Character_PollingBucket
var own_team_function			# Function
var enemy_team_function			# Function
var draw_num_function			# Function
var is_dead_condition			# Function
var is_battle_over_condition	# Function
var action_character			# CharacterCard
var chosen_hand_card			# SkillCard

func _init():
	setting = null
	own_character_team = []
	enemy_character_team = []
	order_bucket = null
	own_team_function = null
	enemy_team_function = null
	draw_num_function = null
	is_dead_condition = null
	is_battle_over_condition = null
	action_character = null
	chosen_hand_card = null
	__setParamTable()

# param_table
func getParam(param_name):
	Exception.assert(param_table.has(param_name))
	return param_table[param_name]

# setting
func getSettingAttr(attr_name):
	return setting.getAttr(attr_name)

func setSetting(setting_):
	setting = setting_

# own_character_team
func getOwnCharacterTeam():
	return own_character_team

func getOwnCharacterNum():
	return own_character_team.size()

func getOwnCharacterByName(card_name):
	for character_card in own_character_team:
		if character_card.getCardName() == card_name:
			return character_card

	return null

func setOwnCharacterTeam(own_character_team_):
	Exception.assert(own_character_team.size() <= MAX_GROUP_SIZE, "own_character_team's chard num exceed limit!")

	own_character_team = own_character_team_

# enemy_character_team
func getEnemyCharacterTeam():
	return enemy_character_team

func getEnemyCharacterNum():
	return enemy_character_team.size()

func getEnemyCharacterByName(card_name):
	for character_card in enemy_character_team:
		if character_card.getCardName() == card_name:
			return character_card
	
	return null

func setEnemyCharacterTeam(enemy_character_team_):
	Exception.assert(own_character_team.size() <= MAX_GROUP_SIZE, "own_character_team's chard num exceed limit!")

	enemy_character_team = enemy_character_team_

func getCharacterByName(card_name):
	var ret = getOwnCharacterByName(card_name)
	if ret != null:
		return ret

	ret = getEnemyCharacterByName(card_name)

	if ret != null:
		return ret
	else:
		Exception.assert(false, "character_card\"" + card_name + "\" doesn't exist!")

# order_bucket
func getOrderBucket():
	return order_bucket

func orderBucketWalk():
	order_bucket.walk()

func setOrderBucket(order_bucket_):
	order_bucket = order_bucket_

# own_team_function
func deployOwnTeam():
	own_character_team = own_team_function.exec([])

func setOwnTeamFunction(own_team_function_):
	own_team_function = own_team_function_

# enemy_team_function
func deployEnemyTeam():
	enemy_character_team = enemy_team_function.exec([])

func setEnemyTeamFunction(enemy_team_function_):
	enemy_team_function = enemy_team_function_

# action_character
func getActionCharacter():
	return action_character

func getActionHandCards():
	return action_character.peekHandCards()

func getActionCharacterName():
	return action_character.getCardName()

func setActionCharacter(action_character_):
	action_character = action_character_

func resetActionCharacter():
	action_character = null

# draw_num_function
func getDrawNum(scene_name):
	return draw_num_function.exec([action_character, scene_name])

func setDrawNumFunction(draw_num_function_):
	draw_num_function = draw_num_function_

# is_dead_condition
func isDeadCondition(card, scene_name):
	return is_dead_condition.exec([card, scene_name])

func setIsDeadCondition(is_dead_condition_):
	is_dead_condition = is_dead_condition_

func isBattleOverCondition(scene_name):
	return is_battle_over_condition.exec([scene_name])

func setIsBattleOverCondition(is_battle_over_condition_):
	is_battle_over_condition = is_battle_over_condition_

# chosen_hand_card
func getChosenHandCard():
	return chosen_hand_card

func getChosenHandCardName():
	return chosen_hand_card.getCardName()

func setChosenHandCardByName(card_name):
	var hand_cards = action_character.peekHandCards()
	for hand_card in hand_cards:
		if hand_card.getCardName() == card_name:
			chosen_hand_card = hand_card
			return
	
	Exception.assert(false, "Action Character doesn't have the \"" + card_name + "\"!")

func resetChosenHandCard():
	chosen_hand_card = null

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObject("setting", setting)
	script_tree.addTypeObject("order_bucket", order_bucket)
	script_tree.addObject("own_team_function", own_team_function)
	script_tree.addObject("enemy_team_function", enemy_team_function)
	script_tree.addObject("draw_num_function", draw_num_function)
	script_tree.addObject("is_dead_condition", is_dead_condition)
	script_tree.addObject("is_battle_over_condition", is_battle_over_condition)

	return script_tree

func loadScript(script_tree):
	setting = script_tree.getObject("setting", SettingTable)
	order_bucket = script_tree.getTypeObject("order_bucket", PollingBucket, LinearCharacterCard)
	own_team_function = script_tree.getObject("own_team_function", Function)
	enemy_team_function = script_tree.getObject("enemy_team_function", Function)
	draw_num_function = script_tree.getObject("draw_num_function", Function)
	is_dead_condition = script_tree.getObject("is_dead_condition", Function)
	is_battle_over_condition = script_tree.getObject("is_battle_over_condition", Function)

func __setParamTable():
	param_table = {}
	__addParam("setting", setting)
	__addParam("own_character_team", own_character_team)
	__addParam("enemy_character_team", enemy_character_team)
	__addParam("order_bucket", order_bucket)
	__addParam("action_character", action_character)
	__addParam("chosen_hand_card", chosen_hand_card)

func __addParam(param_name, param):
	param_table[param_name] = param
