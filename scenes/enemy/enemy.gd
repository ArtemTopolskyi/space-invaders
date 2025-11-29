extends Area2D

const BULLET_SCENE = preload("res://scenes/projectiles/enemy_bullet/enemy_bullet.tscn");


func _ready() -> void:
  $Hurtbox.hit.connect(_on_hit);
  $ShootingInterval.timeout.connect(_on_shooting_interval_timeout);


func _on_hit() -> void:
  queue_free();


func _on_shooting_interval_timeout() -> void:
  shoot_bullet();


func shoot_bullet() -> void:
  var bullet = BULLET_SCENE.instantiate();

  bullet.position = position;

  get_tree().root.add_child(bullet);


func get_size() -> Vector2:
  return $CollisionShape2D.shape.size;
