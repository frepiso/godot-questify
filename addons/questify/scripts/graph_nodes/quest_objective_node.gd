@tool
class_name QuestObjectiveNode extends QuestGraphNode


var quest_description: String
var optional: bool


@export var optional_checkbox: CheckBox
@export var description_text_edit: TextEdit


func _get_model() -> QuestNode:
	return QuestObjective.new()
	
	
func _set_model_properties(node: QuestNode) -> void:
	node.description = quest_description
	node.optional = optional
	
	
func _get_model_properties(node: QuestNode) -> void:
	quest_description = node.description
	description_text_edit.text = node.description
	optional = node.optional
	optional_checkbox.button_pressed = node.optional


func _on_description_text_changed() -> void:
	quest_description = description_text_edit.text


func _on_optional_checkbox_toggled(toggled_on: bool) -> void:
	optional = toggled_on
