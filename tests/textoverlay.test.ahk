#Include, ../src/textoverlay.ahk

results := ""


; options
options := {"title": "WTFOMG", "text": "sup brah"}
overlay := new TextOverlay(options)

;Sleep, 1000

; init()
overlay.init()
results .= "init(): " ( overlay.hwnd_main?1:0 ) "`r`n"

;Sleep, 1000

; show()
overlay.show()
results .= "show(): " ( WinExist(options.title)?1:0 ) "`r`n"

;Sleep, 1000

; hide()
overlay.hide()
results .= "hide(): " ( WinExist(options.title)?0:1 ) "`r`n"
overlay.show()

;Sleep, 1000

; setText(string)
newText := "new text here!!11!!"
overlay.setText(newText)
ControlGetText, text,, % "ahk_id " overlay.hwnd_text
results .= "setText(string): " ( newText=text?1:0 ) "`r`n"

;Sleep, 1000

; setTextColor(color)
newColor := "red"
overlay.setTextColor(newColor)
results .= "setTextColor(color): " ( newColor=overlay.options.textColor?1:0 ) "`r`n"

;Sleep, 1000

; setFontSize(size)
newFontSize := 16
overlay.setFontSize(newFontSize)
results .= "setFontSize(size): " ( newFontSize=overlay.options.fontSize?1:0 ) "`r`n"

;Sleep, 1000

; setWidth(width)
newWidth := 100
overlay.setWidth(newWidth)
WinGetPos,,, width,, % options.title
results .= "setWidth(width): " ( newWidth=width?1:0 ) "`r`n"

;Sleep, 1000

; setHeight(height)
newHeight := 50
overlay.setHeight(newHeight)
WinGetPos,,,, height, % options.title
results .= "setHeight(height): " ( newHeight=height?1:0 ) "`r`n"

;Sleep, 1000

; setX(x)
newX := 200
overlay.setX(newX)
WinGetPos, x,,,, % options.title
results .= "setX(x): " ( newX=x?1:0 ) "`r`n"

;Sleep, 1000

; setY(y)
newY := 200
overlay.setY(newY)
WinGetPos,, y,,, % options.title
results .= "setY(y): " ( newY=y?1:0 ) "`r`n"

;Sleep, 1000

; destroy()
overlay.destroy()
results .= "destroy(): " ( WinExist(options.title)?0:1 )



; Show test results
Gui, New
Gui, Add, Edit,, % results
Gui, Show

/* OUTPUT 10/02/16
init(): 1
show(): 1
hide(): 1
setText(string): 1
setTextColor(color): 1
setFontSize(size): 1
setWidth(width): 1
setHeight(height): 1
setX(x): 1
setY(y): 1
destroy(): 1
*/