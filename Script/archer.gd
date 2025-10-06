extends CharacterBody3D

@onready var archer:AnimatedSprite3D = $AnimatedSprite3D
@export var arrow_scene: PackedScene

func _ready():
	archer.play("idle")
	
	# debug
	var dummy = Node3D.new()
	dummy.global_transform.origin = global_transform.origin + Vector3(0,0,5)  # 5 unités devant
	get_tree().current_scene.add_child(dummy)
	
	target = dummy
	
	
var target: Node3D = null # Stocker l'ennmie visé
var can_shoot: bool = true # Gérer le cooldown entre chaque tirs
var shoot_cooldown: float = 1.0 # Nombre de secondes entre chaque flèches tiré

func _on_area_3d_body_entered(body: Node3D) -> void:
	if target == null:
		target = body # L'archer comence à viser ce body
		print("Nouvelle cible :", target.name) # debug


func _on_area_3d_body_exited(body: Node3D) -> void:
	if target == body:
		target = null # La cible est sortie de la portée
		print("Cible perdue") # debug
		
func shoot_at_target():
	if not arrow_scene or not target:
		return
	
	# Instancier la flèche	
	var arrow = arrow_scene.instantiate()
	
	# Positionner la flèche au niveau de l'archer
	arrow.global_transform.origin = global_transform.origin + Vector3(0, 1.5, 0)
	
	# Calculer la direction vers la cible 
	var direction = (target.global_transform.origin - arrow.global_transform.origin).normalized()
	
	# Ajouter la flèche à la scène
	get_tree().current_scene.add_child(arrow)
	
	# Jouer l'animation "shooting" de l'archer
	archer.play("shooting")
	
	can_shoot = false
	await get_tree().create_timer(shoot_cooldown).timeout
	can_shoot = true
	
func _process(delta):
	if target and can_shoot:
		look_at(target.global_transform.origin, Vector3.UP)
		shoot_at_target()
		# debug
		target = $Dummy
