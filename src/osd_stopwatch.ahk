#include, textoverlay.ahk
#Include, stopwatch.ahk
#Include, ../lib/zeropad.ahk
#Include, ../lib/join.ahk


global settings := {"reportInterval": 30
	, "displayCounter": 1
	, "inactiveColor": "cc5555"
	, "activeColor": "55cc55"}



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Init
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Create view for stopwatch
overlayOpts := {"fontSize": 25, "x": A_ScreenWidth / 2, "y": 0}
global overlay := new TextOverlay(overlayOpts)
global watch := new StopWatch()

watch.on("tick", func("onTick"))
watch.on("start", func("onStart"))
watch.on("stop", func("onStop"))
watch.on("reset", func("onReset"))

overlay.show()

return



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Hotkeys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
F1::
	watch.toggle()
return

F2::
	watch.reset()
return



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Stopwatch event hanlders
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
onTick(e) {
	overlay.setTextColor(settings.activeColor)
	updateOverlay(e.time)

	if (mod(e.time, settings.reportInterval) = 0)
		d3Chat_Party(secondsToFormatString(e.time) " elapsed")

}
onStart(e) {
	if watch.seconds > 0
		str := "Timer re-started at " secondsToFormatString(e.time)
	else
		str := "Timer started, notification every " settings.reportInterval "s"
	
	d3Chat_Party(str)
}
onStop(e) {
	overlay.setTextColor(settings.inactiveColor)
	d3Chat_Party("Timer stopped at " secondsToFormatString(e.time))
}
onReset(e) {
	overlay.setTextColor("ffffff")
}



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Overlay Event Handler
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
updateOverlay(seconds) {
	overlay.setText(secondsToFormatString(seconds))
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Diablo 3 helpers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
d3Chat(channel, text) {
	SendInput, % "{Enter}" channel " " text "{Enter}"
}

d3Chat_Party(text) {
	d3Chat("/p", text)
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Time Transformations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
secondsToFormatString(seconds) {
	
	data := secondsToFormatArray(seconds)
	str := ""

	for i, place in data
		str .= zeroPad(place, 2) (i < data.Length() ? ":" : "")

	return str
}

secondsToFormatArray(sec) {

	min := Floor(sec/60)
	sec := sec-(min*60)
	hrs := Floor(min/60)
	min := min-(hrs*60)

    return [hrs, min, sec]
}