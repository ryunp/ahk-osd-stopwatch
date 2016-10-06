class Stopwatch {

	events := {"start": [], "stop": [], "reset": [], "tick": []}
	seconds := 0
	active := 0

	__New() {
		this.tickFn := objBindMethod(this, "tick")
	}

	toggle() {
		if (this.active)
			this.stop()
		else
			this.start()
	}

	start() {
		if (this.active)
			return

		this.active := 1
		fn := this.tickFn
		SetTimer, % fn, 1000

		for i, fn in this.events.start
			fn.Call(new StopwatchStart(this.seconds))
	}

	stop() {
		this.active := 0
		fn := this.tickFn
		SetTimer, % fn, Off

		for i, fn in this.events.stop
			fn.Call(new StopwatchStop(this.seconds))
	}

	reset() {
		this.seconds := 0

		for i, fn in this.events.reset
			fn.Call(new StopwatchReset(this.seconds))
	}

	tick() {
		this.seconds += 1

		for i, fn in this.events.tick
			fn.Call(new StopwatchTick(this.seconds))
	}

	on(event, fn) {
		if this.events.HasKey(event)
			this.events[event].push(fn)
	}
}


class StopwatchEvent {
	__New(type, time) {
		this.type := type
		this.time := time
	}
}
class StopwatchStart extends StopwatchEvent {
	__New(time) {
		base.__New("start", time)
	}
}
class StopwatchStop extends StopwatchEvent {
	__New(time) {
		base.__New("stop", time)
	}
}
class StopwatchReset extends StopwatchEvent {
	__New(time) {
		base.__New("reset", time)
	}
}
class StopwatchTick extends StopwatchEvent {
	__New(time) {
		base.__New("tick", time)
	}
}