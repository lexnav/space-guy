extends CanvasLayer

signal iniciar_juego

func mostrarMsj(texto):
	$lblMsj.text = texto
	$lblMsj.show()
	$TimerMsj.start()

func game_over():
	mostrarMsj("GAME OVER")
	yield($TimerMsj, "timeout")
	$BtnPlay.show()
	$lblMsj.text = "SPACE GUY\nTUTO"
	$lblMsj.show()

func update_score(puntos):
	$lblScore.text = str(puntos)
	

func _on_TimerMsj_timeout():
	$lblMsj.hide()
	

func _on_BtnPlay_pressed():
	$BtnPlay.hide()
	emit_signal("iniciar_juego")
