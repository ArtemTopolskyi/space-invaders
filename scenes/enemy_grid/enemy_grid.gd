extends Node2D

const ENEMY_SCENE = preload("res://scenes/enemy/enemy.tscn");

@export var speed: float = 100.0;

@export var columns: int = 5;
@export var rows: int = 3;

var grid_spacing: Vector2 = Vector2(20, 20);

var current_movement_direction: int = -1;

func _ready() -> void:
  spawn_enemies();


func _physics_process(delta: float) -> void:
  move_grid(delta);


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


func move_grid(delta: float) -> void:
  position.x += speed * delta * current_movement_direction;

  if (should_change_movement_direction()):
    current_movement_direction = -current_movement_direction;


func should_change_movement_direction() -> bool:
  return get_children().any(
    func(enemy: Node2D):
      var enemy_size = enemy.get_size();

      return (
        (enemy.global_position.x - (enemy_size.x / 2) - grid_spacing.x) < 0
          or (enemy.global_position.x + (enemy_size.x / 2) + grid_spacing.x) > get_viewport_rect().size.x
      );
  );
