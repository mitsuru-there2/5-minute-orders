extends SceneTree

const TurnPhase = preload("res://src/domain/turn_phase.gd")


func _initialize() -> void:
	var phase := TurnPhase.Phase.ORDERS
	var expected := [
		TurnPhase.Phase.LOCKED,
		TurnPhase.Phase.MOVEMENT,
		TurnPhase.Phase.COMBAT,
		TurnPhase.Phase.EVENTS,
		TurnPhase.Phase.RESULTS,
		TurnPhase.Phase.ORDERS
	]
	for target in expected:
		phase = TurnPhase.next(phase)
		if phase != target:
			push_error("Turn phase sequence differs from foundation SPEC")
			quit(1)
			return
	print("PASS: turn phase contract")
	quit(0)
