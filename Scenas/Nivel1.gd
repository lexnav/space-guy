extends Node

export (PackedScene) var Roca
var score
var muerte = false

func _ready():
	randomize()
	
func _nuevoJuego():
	score = 0
	$player._inicio($PosicionInicial.position) #establece posicion inicial del player
	$TimerInicio.start()
	$Interfaz.mostrarMsj("LISTO...")
	$Interfaz.update_score(score)
	$Musica.play()
	muerte = false
	
# game over
func _on_player_Golpe():
	$TimerScore.stop()
	$TimerRoca.stop()
	$Interfaz.game_over()
	$AudioMuerte.play()
	muerte = true
	$Musica.stop()

# activar los otros timers al cargar el juego 
func _on_TimerInicio_timeout():
	$TimerRoca.start()
	$TimerScore.start()

# al terminar cada tick (los segundos configurados en el timer), aumentar el score
func _on_TimerScore_timeout():
	score += 1
	$Interfaz.update_score(score)

# al terminar cada tick (los segundos configurados en el timer) 
func _on_TimerRoca_timeout():
	# seleccionar una posicion aleatoria dentro del Object Path
	$Camino/RocaPosicion.set_offset(randi())
	
	# seleccionar la direccion
	var d = $Camino/RocaPosicion.rotation + PI/2
	d = rand_range(-120 * PI/180, 120 * PI/180)
	
	# crear la instancia de la roca
	var R = Roca.instance()
	
	#asiganr posicion, rotacion y velocidad
	R.position = $Camino/RocaPosicion.position
	R.rotation = d
	R.set_linear_velocity(Vector2(rand_range(R.Velocidad_min, R.Velocidad_max), 0).rotated(d))
	
	#Agregar roca al nivel
	add_child(R)
	
func _on_Musica_finished():
	if muerte :
		$Musica.stop()
	else:
		$Musica.play()
