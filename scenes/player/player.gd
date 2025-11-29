extends CharacterBody2D

@export var speed: float = 500.0;

const ROCKET_SCENE = preload("res://scenes/projectiles/player_rocket/player_rocket.tscn");

func _ready() -> void:
  $Hurtbox.hit.connect(_on_hit);


func _process(_delta: float) -> void:
  if Input.is_action_just_pressed("space"):
    _shoot_rocket();


func _physics_process(_delta: float) -> void:
  var direction = Input.get_axis("left", "right");

  velocity.x = direction * speed;

  move_and_slide();


func _shoot_rocket() -> void:
  var rocket = ROCKET_SCENE.instantiate();

  rocket.position = position;

  get_tree().root.add_child(rocket);


func _on_hit() -> void:
  print("player got hurt");
