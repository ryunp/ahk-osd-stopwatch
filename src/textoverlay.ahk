#include, ../lib/merge.ahk

class TextOverlay {

	options := {"title": "Overlay"
		, "text": "00:00:00"
		, "fontSize": 32
		, "textColor": "ffffff"
		, "timeFormat": "mm:ss"
		, "x": 0
		, "y": 0}

	__New(options) {

		merge(this.options, options)
		this.init()
	}

	init() {
		; New window
		Gui, New, +hwndhwnd +AlwaysOnTop -Caption +LastFound +Owner, % this.options.title
		this.hwnd_main := hwnd

		; Setup controls
		Gui, Font, % "s" this.options.fontSize " c" this.options.textColor " w700" 
		Gui, add, text, +hwndhwnd, % this.options.text
		this.hwnd_text := hwnd

		; Transparent background
		Gui, Color, 000000
		WinSet, TransColor, 000000
	}

	destroy() {
		Gui % this.hwnd_main ":Default"
		Gui, Destroy
	}

	show() {
		Gui, % this.hwnd_main ":Show", % "NoActivate x" this.options.x " y" this.options.y
	}

	hide() {
		Gui, % this.hwnd_main ":Hide"
	}

	setText(string) {
		GuiControl,, % this.hwnd_text, % string
		this.options.text := color
	}

	setTextColor(color) {
		Gui, % this.hwnd_main ":Default"
		Gui, Font, % "c" color
		GuiControl, Font, % this.hwnd_text
		this.options.textColor := color
	}

	setFontSize(size) {
		Gui, % this.hwnd_main ":Default"
		Gui, Font, % "s" size
		GuiControl, Font, % this.hwnd_text
		this.options.fontSize := size
	}

	setWidth(width) {
		Gui, % this.hwnd_main ":Show", % "w" width
	}
	setHeight(height) {
		Gui, % this.hwnd_main ":show", % "h" height
	}

	setX(x) {
		WinMove, % "ahk_id " this.hwnd_main,, % x
		this.options.x := x
	}

	setY(y) {
		WinMove, % "ahk_id " this.hwnd_main,,, % y
		this.options.y := y
	}
}