extends Area2D

func _ready() -> void:
  $Hurtbox.hit.connect(_on_hit);


func _on_hit() -> void:
  queue_free();
