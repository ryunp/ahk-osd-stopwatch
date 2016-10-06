#Include, ../src/stopwatch.ahk

watch := new StopWatch()

watch.on("tick", func("onTick"))
watch.on("start", func("onStart"))
watch.on("stop", func("onStop"))
watch.on("reset", func("onReset"))

onTick(e) {
	msgbox % "onTick: " e.time
}
onStart(e) {
	msgbox % "onStart: " e.time
}
onStop(e) {
	msgbox % "onStop: " e.time
}
onReset(e) {
	msgbox % "onReset: " e.time
}

F1::
	watch.toggle()
return

F2::
	watch.reset()
return