class_name Hitbox extends Area2D

@export var team: Constants.Team;

signal hit;

func _ready() -> void:
  area_entered.connect(_on_area_entered);


func _on_area_entered(area: Area2D) -> void:
  if area is not Hurtbox and area is not Hitbox:
    return;

  if area.team == team:
    return;

  hit.emit();
