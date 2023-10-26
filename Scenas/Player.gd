extends Area2D

export (int) var Velocidad

var Movimiento
var Limites
signal Golpe

func _ready():
	hide() #ocultar personaje
	Limites = get_viewport_rect().size

func _process(delta):
	# Reiniciar movimiento
	Movimiento = Vector2()
	
	# Moverse
	if Input.is_action_pressed("ui_right"): 
		Movimiento.x += 1
		$Pedo.position.y = 60
	if Input.is_action_pressed("ui_left"): 
		Movimiento.x -= 1
		$Pedo.position.y = 60
	if Input.is_action_pressed("ui_down"): 
		Movimiento.y += 1
		$Pedo.position.y = -120
	if Input.is_action_pressed("ui_up"): 
		Movimiento.y -= 1
		$Pedo.position.y = 60
	
	# Si esta en movimiento, normalizarlo a la velocidad seleccionada
	if Movimiento.length() > 0:
		Movimiento = Movimiento.normalized() * Velocidad

	# Posicionar jugador
	position += Movimiento * delta
	position.x = clamp(position.x, 0, Limites.x)
	position.y = clamp(position.y, 0, Limites.y)
	
	# Establecer animacion del movimiento
	if Movimiento.x != 0:
		$SpritePlayer.animation = "lado"
		$SpritePlayer.flip_h = Movimiento.x > 0
	elif Movimiento.y != 0:
		$SpritePlayer.animation = "espalda"
		$SpritePlayer.flip_v = Movimiento.y > 0
	else:
		$SpritePlayer.animation = "frente"
		$SpritePlayer.flip_v = false

# evento de colision
func _on_player_body_entered(body):
	hide()
	emit_signal("Golpe")
	$CollisioPlayer.disabled = true
	
func _inicio(pos):
	position = pos
	show()
	$CollisioPlayer.disabled = false
