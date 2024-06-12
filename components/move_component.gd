class_name MoveComponent
extends Node

#This wouldn't work with a platformer, it uses a Character2D instead of Node2D
@export var actor: Node2D
@export var velocity: Vector2

# Move an Actor

#Called every frame. delta is the elapsed time since the previous frame. 
func _process(delta: float) -> void:
	actor.translate(velocity * delta)
