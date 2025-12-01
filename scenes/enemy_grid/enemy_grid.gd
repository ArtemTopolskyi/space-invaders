extends Node2D

const ENEMY_SCENE = preload("res://scenes/enemy/enemy.tscn");

@export var speed: float = 100.0;
@export var vertical_transition_distance: float = 50.0;

@export var columns: int = 5;
@export var rows: int = 3;

@onready var enemies_container: Node2D = $EnemiesContainer;

var grid_spacing: Vector2 = Vector2(20, 20);

var current_movement_direction: int = -1;

func _ready() -> void:
  spawn_enemies();

  $ShootingInterval.timeout.connect(shoot);


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

      enemies_container.add_child(enemy);


func move_grid(delta: float) -> void:
  position.x += speed * delta * current_movement_direction;

  if (should_change_movement_direction()):
    current_movement_direction = -current_movement_direction;

    position.y += vertical_transition_distance;    


func should_change_movement_direction() -> bool:
  return enemies_container.get_children().any(
    func(enemy: Node2D):
      var enemy_size = enemy.get_size();

      return (
        (enemy.global_position.x - (enemy_size.x / 2) - grid_spacing.x) < 0
          or (enemy.global_position.x + (enemy_size.x / 2) + grid_spacing.x) > get_viewport_rect().size.x
      );
  );

func shoot() -> void:
  var closest_enemies_by_x_position: Dictionary = {};

  for current_enemy in enemies_container.get_children():
    var current_enemy_position = current_enemy.position;

    if (
      not closest_enemies_by_x_position.has(current_enemy_position.x)
        or closest_enemies_by_x_position.get(current_enemy_position.x).position.y < current_enemy_position.y
    ):
      closest_enemies_by_x_position.set(current_enemy_position.x, current_enemy);

  var closest_enemies = closest_enemies_by_x_position.values();

  if (closest_enemies.size() == 0):
    return;

  var random_enemy = closest_enemies[randi_range(0, closest_enemies.size() - 1)];

  random_enemy.shoot_bullet();
