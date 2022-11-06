;;;;; EVERY HOTKEY ADDED
;;;; note that this is all Ctrl+Alt+Win
;; b: Add blur effect to selected clip.
;;;; 

;;; Script compatibility stuff
#NoEnv
; #Warn
SendMode Input
SetWorkingDir %A_ScriptDir%/sm-dep

;;; This sets the script to only accept the hotkeys when Resolve is active.
#If WinActive("ahk_exe Resolve.exe") 

;;; Add blur effect to selected clip
^!#b::
Sleep 100
MouseGetPos, MouseOriginalPosX, MouseOriginalPosY
MouseMove, 15, 15
Send ^6
; vv search for sidepanel icon
ImageSearch, FoundEffectsTabX, FoundEffectsTabY, 8, 87, 46, 110, effects tab disabled.png
if ErrorLevel = 0 
	{
	FoundEffectsTabX += 5
	FoundEffectsTabY += 5
	;ToolTip, found with ErrorLevel %ErrorLevel% tab disabled at %FoundEffectsTabX% %FoundEffectsTabY%
	Click, %FoundEffectsTabX%, %FoundEffectsTabY%
	}
; vv search for search icon
ImageSearch, FoundEffectSearchX, FoundEffectSearchY, 344, 87, 643, 108, effects search disabled.png ; Errorlevel 0 if found, 1 if wasnt found
FoundEffectSearchX += 5
FoundEffectSearchY += 5
if ErrorLevel = 0
	{
	;ToolTip, found with ErrorLevel %ErrorLevel%: disabled search at %FoundEffectSearchX% %FoundEffectSearchY%
	Click, %FoundEffectSearchX%, %FoundEffectSearchY%
	FoundEffectSearch := 1
	}
else
	{
	ImageSearch, FoundEffectSearchX, FoundEffectSearchY, 344, 87, 643, 108, effects search enabled.png ; Errorlevel 0 if found, 1 if wasnt found
	if ErrorLevel = 1
		{
		ToolTip, found with ErrorLevel %ErrorLevel%: NOTHING at %FoundEffectSearchX% %FoundEffectSearchY%
		FoundEffectSearch := 0
		sleep 1000
		ToolTip
		}
	else
		{
		;ToolTip, found with ErrorLevel %ErrorLevel%: enabled search at %FoundEffectSearchX% %FoundEffectSearchY%
		FoundEffectSearchX += 5
		FoundEffectSearchY += 5
		Click, %FoundEffectSearchX%, %FoundEffectSearchY%
		Click, %FoundEffectSearchX%, %FoundEffectSearchY%
		FoundEffectSearch := 1
		}
	}
sleep 4
if FoundEffectSearch = 1
	{
	Send {Tab}
	Send {Up 10}
	Send {Down 6}
	Send {Shift}+{Tab}
	Send {text}Gaussian Blur
	Sleep 8
	Click, 264, 212,,2
	MouseMove, %MouseOriginalPosX%, %MouseOriginalPosY%
	}
return

^!#t::
Sleep 100
Send {Shift}+3
Sleep 500
Send {Ctrl}+8
sleep 10
Click, 380, 237
Send F12
sleep 10
Send {Shift}+4
