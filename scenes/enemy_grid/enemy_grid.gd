extends Node2D

@export var columns: int = 5;
@export var rows: int = 3;

var grid_spacing: Vector2 = Vector2(20, 20);

const ENEMY_SCENE = preload("res://scenes/enemy/enemy.tscn");


func _ready() -> void:
  spawn_enemies();


func spawn_enemies() -> void:
  for row in rows:
    for column in columns:
      var enemy = ENEMY_SCENE.instantiate();

      var enemy_size = enemy.get_size();

      enemy.position = position + Vector2(
        column * grid_spacing.x + column * enemy_size.x,
        row * grid_spacing.y + row * enemy_size.y
      );

      add_child(enemy);
