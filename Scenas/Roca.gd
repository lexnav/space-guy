extends RigidBody2D

export (int) var Velocidad_min
export (int) var Velocidad_max

var Tipo_roca = ["grande", "pequeno"]

func _ready():
	$AnimatedSprite.animation = Tipo_roca[randi() % Tipo_roca.size()]
	
	if $AnimatedSprite.animation == "grande":
		$CollisionShape2D.scale.x = 2
		$CollisionShape2D.scale.y = 2


func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # eliminar el objeto de memoria
