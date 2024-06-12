extends Node2D

@onready var left_muzzle: Marker2D= $LeftMuzzle
@onready var right_muzzle: Marker2D = $RightMuzzle
@onready var spawner_component: SpawnerComponent = $SpawnerComponent as SpawnerComponent
@onready var fire_rate_timer: Timer = $FireRateTimer
@onready var scale_component: ScaleComponent = $ScaleComponent as ScaleComponent
@onready var move_component: MoveComponent = $MoveComponent as MoveComponent
@onready var animated_sprite_2d = $Anchor/AnimatedSprite2D
@onready var flame_animated_sprite = %FlameAnimatedSprite
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent as HurtboxComponent
@onready var stats_component: StatsComponent = $StatsComponent as StatsComponent
@onready var destroyed_component: DestroyedComponent = $DestroyedComponent as DestroyedComponent
@onready var flash_component: FlashComponent = $FlashComponent as FlashComponent
@onready var variable_pitch_audio_stream_player = $VariablePitchAudioStreamPlayer as VariablePitchAudioStreamPlayer



func _ready() -> void:
	hurtbox_component.hurt.connect(func():
		scale_component.tween_scale()
		flash_component.flash()
	)
		

func fire_lasers() -> void:
	variable_pitch_audio_stream_player.play_with_variance()
	spawner_component.spawn(left_muzzle.global_position)
	spawner_component.spawn(right_muzzle.global_position)
	scale_component.tween_scale()

func _process(delta: float) -> void:
	animate_the_ship()

#not a component because we won't be using it in many different places	
func animate_the_ship() -> void:
	if move_component.velocity.x < 0:
		animated_sprite_2d.play("bank_left")
		flame_animated_sprite.play("bank_left")
	elif move_component.velocity.x > 0:
		animated_sprite_2d.play("bank_right")
		flame_animated_sprite.play("bank_right")
	else:
		animated_sprite_2d.play("center")
		flame_animated_sprite.play("center")
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		fire_lasers()
