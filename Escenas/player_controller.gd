extends CharacterBody2D

@export var speed: float = 200.0  # Velocidad de movimiento

# Direcciones de movimiento (4 direcciones)
enum Direction { NONE, UP, DOWN, LEFT, RIGHT }
var current_direction: Direction = Direction.NONE
var input_direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	# Obtener entrada del jugador (teclado)
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Si hay entrada, actualizar dirección actual
	if input_direction != Vector2.ZERO:
		current_direction = _vector_to_direction(input_direction)
	else:
		# Si no hay entrada, el personaje se detiene
		current_direction = Direction.NONE
	
	# Movimiento en 4 direcciones fijas
	var target_velocity = _get_fixed_direction() * speed
	velocity = target_velocity
	move_and_slide()

# Convierte un Vector2 a una dirección enum
func _vector_to_direction(vec: Vector2) -> Direction:
	if vec.x > 0: return Direction.RIGHT
	elif vec.x < 0: return Direction.LEFT
	elif vec.y > 0: return Direction.DOWN
	elif vec.y < 0: return Direction.UP
	return Direction.NONE

# Para movimiento estilo Pacman (solo 4 direcciones, sin diagonales)
func _get_fixed_direction() -> Vector2:
	match current_direction:
		Direction.RIGHT: return Vector2.RIGHT
		Direction.LEFT: return Vector2.LEFT
		Direction.DOWN: return Vector2.DOWN
		Direction.UP: return Vector2.UP
		_: return Vector2.ZERO
