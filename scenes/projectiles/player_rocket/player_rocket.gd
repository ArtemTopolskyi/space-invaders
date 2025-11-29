extends Area2D

@export var speed: float = 1000.0;

func _ready() -> void:
  $VisibleOnScreenNotifier2D.screen_exited.connect(_on_screen_exited);
  $Hitbox.hit.connect(_on_hit);


func _physics_process(delta: float) -> void:
  position.y -= speed * delta;


func _on_screen_exited() -> void:
  queue_free();


func _on_hit() -> void:
  queue_free();
