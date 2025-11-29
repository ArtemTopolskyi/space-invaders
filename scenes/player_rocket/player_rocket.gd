extends Area2D

@export var speed: float = 1000.0;

func _ready() -> void:
  $VisibleOnScreenNotifier2D.screen_exited.connect(_on_screen_exited);


func _physics_process(delta: float) -> void:
  position.y -= speed * delta;


func _on_screen_exited() -> void:
  queue_free();
