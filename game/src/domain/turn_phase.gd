extends RefCounted
## Phase vocabulary; timeouts and game resolution are not implemented yet.

enum Phase { ORDERS, LOCKED, MOVEMENT, COMBAT, EVENTS, RESULTS }

static func next(phase: Phase) -> Phase:
	match phase:
		Phase.ORDERS: return Phase.LOCKED
		Phase.LOCKED: return Phase.MOVEMENT
		Phase.MOVEMENT: return Phase.COMBAT
		Phase.COMBAT: return Phase.EVENTS
		Phase.EVENTS: return Phase.RESULTS
		_: return Phase.ORDERS
