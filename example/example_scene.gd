extends Control


@export var quest: QuestResource


@onready var data_manager: DataManager = $DataManager as DataManager
@onready var current_quest_label: Label = %CurrentQuestLabel as Label
@onready var objectives: ItemList = %Objectives as ItemList


func _ready() -> void:
	await get_tree().process_frame
	var quest_instance := quest.instantiate()
	
	Questify.quest_started.connect(
		func(new_quest: QuestResource):
			current_quest_label.text = "%s - %s" % [new_quest.name, new_quest.description]
	)
	
	Questify.quest_objective_completed.connect(func(_quest: QuestResource, _objective: QuestObjective):
		objectives.clear()	
	)
	
	Questify.quest_objective_added.connect(
		func(_quest: QuestResource, objective: QuestObjective):
			objectives.add_item("%s%s" % ["OR: " if objective.is_exclusive else "", objective.description])
	)
	
	Questify.quest_completed.connect(
		func(new_quest: QuestResource):
			current_quest_label.text = "%s - COMPLETED!" % new_quest.name
			objectives.clear()
	)
	
	Questify.start_quest(quest_instance)
	
