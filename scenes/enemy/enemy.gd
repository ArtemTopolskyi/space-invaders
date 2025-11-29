extends Node2D

const BULLET_SCENE = preload("res://scenes/projectiles/enemy_bullet/enemy_bullet.tscn");


func _ready() -> void:
  $Hurtbox.hit.connect(_on_hit);


func _on_hit() -> void:
  queue_free();


func shoot_bullet() -> void:
  var bullet = BULLET_SCENE.instantiate();

  bullet.position = position;

  get_tree().root.add_child(bullet);


func get_size() -> Vector2:
  var sprite = $Sprite2D;

  return sprite.texture.get_size() * sprite.scale;
