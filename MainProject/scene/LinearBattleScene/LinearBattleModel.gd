extends Node
class_name LinearBattleModel

var ScriptTree = TypeUnit.type("ScriptTree")
var BattleCharacterCard = TypeUnit.type("BattleCharacterCard")
var BattleSkillCard = TypeUnit.type("BattleSkillCard")
var Filter = TypeUnit.type("Filter")
var DictArray = TypeUnit.type("DictArray")
var SettingTable = TypeUnit.type("SettingTable")
var PollingBucket = TypeUnit.type("PollingBucket")

var MAX_GROUP_SIZE = 4

var param_table				# Dict

var setting					# SettingTable
var character_groups		# Character_DictArray_Array
var order_bucket			# Character_PollingBucket
var character_deal_filter	# Filter
var cur_character_card		# CharacterCard
var hand_cards_table		# SkillCard_DictArray_Dict
var total_round				# int

func _init():
	setting = SettingTable.new()
	character_groups = []
	order_bucket = PollingBucket.new()
	order_bucket.setParamType(BattleCharacterCard)
	character_deal_filter = Filter.new()
	cur_character_card = BattleCharacterCard.new()
	hand_cards_table = {}
	__setParamTable()

# param_table
func getParam(param_name):
	Exception.assert(param_table.has(param_name))
	return param_table[param_name]

# setting
func getSettingAttr(attr_name):
	return setting[attr_name]

func setSetting(setting_):
	setting = setting_

# character_groups
func getCharacterGroups():
	return character_groups

func setCharacterGroups(character_groups_):
	# TODO: 添加Warning警告，单组group暂时最多4Card

	Exception.assert(character_groups_[0] <= MAX_GROUP_SIZE)
	Exception.assert(character_groups_[1] <= MAX_GROUP_SIZE)

	character_groups = character_groups_

# order_bucket
func getOrderBucket():
	return order_bucket

func setOrderBucket(order_bucket_):
	order_bucket = order_bucket_

# character_deal_filter
func dealCharacter():
	return character_deal_filter.exec([])

func setCharacterDealFilter(character_deal_filter_):
	character_deal_filter = character_deal_filter_

# cur_character_card
func getCurCharacterCard():
	return cur_character_card

func getCurCharacterName():
	return cur_character_card.getCardName()

func setCurCharacterCard(cur_character_card_):
	cur_character_card = cur_character_card_

# hand_cards_table
func getHandCardsTable():
	return hand_cards_table

func setHandCardsTable(hand_cards_table_):
	hand_cards_table = hand_cards_table_

func getHandCards(character_name):
	return hand_cards_table[character_name]

func getCurHandCards():
	return hand_cards_table[cur_character_card.getCardName()]

func getHandCardsNum(character_name):
	return hand_cards_table[character_name].size()

func getCurHandCardsNum():
	return hand_cards_table[cur_character_card.getCardName()].size()

func setHandCards(character_name, hand_cards):
	hand_cards_table[character_name] = hand_cards

# total
func resetTotalRound():
	total_round = 0

func nextRound():
	total_round += 1

func getTotalRound():
	return total_round

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObject("setting", setting)
	script_tree.addTypeObjectArray("character_groups", character_groups)
	script_tree.addTypeObject("order_bucket", order_bucket)
	script_tree.addObject("character_deal_filter", character_deal_filter)
	script_tree.addObject("cur_character_card", cur_character_card)
	script_tree.addTypeObjectDict("hand_cards_table", hand_cards_table)
	script_tree.addAttr("total_round", total_round)

	return script_tree

func loadScript(script_tree):
	setting = script_tree.getObject("setting", SettingTable)
	character_groups = script_tree.getTypeObjectArray("character_groups", DictArray, BattleCharacterCard)
	order_bucket = script_tree.getTypeObject("order_bucket", PollingBucket, BattleCharacterCard)
	character_deal_filter = script_tree.getObject("character_deal_filter", Filter)
	cur_character_card = script_tree.getObject("cur_character_card", BattleCharacterCard)
	hand_cards_table = script_tree.getTypeObjectDict("hand_cards_table", DictArray, SkillCard)
	total_round = script_tree.getInt("total_round")

func __setParamTable():
	param_table = {}
	__addParam("setting", setting)
	__addParam("character_groups", character_groups)
	__addParam("order_bucket", order_bucket)
	__addParam("character_deal_filter", character_deal_filter)
	__addParam("cur_character_card", cur_character_card)
	__addParam("hand_cards_table", hand_cards_table)
	__addParam("total_round", total_round)

func __addParam(param_name, param):
	param_table[param_name] = param
