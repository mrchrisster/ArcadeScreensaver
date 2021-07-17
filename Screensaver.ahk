#NoEnv
#Persistent
#SingleInstance Force
#InstallKeybdHook 
;#InstallMouseHook
SetWorkingDir %A_ScriptDir% 
#Include, Gdip_all.ahk
;SetKeyDelay, 0, 50

pToken := Gdip_Startup()

;Screensaver for Arcade Games
;Start when "TimetoStart" var is reached
;Script is disabled when mame64 is running, copy mame64.exe to groovymame64.exe in same dir for screensaver

TimetoStart = 200000 

list =
(
dkong
dkong
dkong
dkonghrd
dkongpe
dkongx
dkong3
dkong3
mario
galaga
nibbler
mspacmnf
suprmrio
dkchrmx
dkspkyrmx
batsugun
batsugunsp
tetrisgaiden
)

FileCopy, C:\groovymame\hi, C:\groovymame\hi_pb, 1

GroupAdd, screensaver, ahk_exe hyperspin.exe ; Frontend Exe
GroupAdd, screensaver, ahk_exe groovymame64.exe ; Screensaver Exe
GroupAdd, screensaver, ahk_exe hbmame64ss.exe ; Screensaver Exe

GroupAdd, exitemu, ahk_exe groovymame64.exe ; Screensaver Exe
GroupAdd, exitemu, ahk_exe hbmame64ss.exe ; Screensaver Exe


SetTimer, MameRelaunch, 1500 	
return

MameRelaunch:


While WinActive("ahk_group screensaver")
{
If (A_TimeIdlePhysical > TimetoStart)
{
	settimer, MameRelaunch, off
	Process, Close, groovymame64.exe
	Process,Close, hbmame64ss64.exe
	StringSplit, ListArray, list, `n`r
	sleep 500
	random, selected, 1, %ListArray0%
	check := ListArray%selected%	
	;FileDelete,%A_ScriptDir%\lastgame.txt
	;FileAppend,%check%,%A_ScriptDir%\lastgame.txt
	array := {} 	
				Loop, C:\Groovymame\inp\%check%_*.inp
				array[A_Index] := A_LoopFileName  			
				Random, no, 1, array.length()  
				inpfile := array[no]
	removeBegining := StrSplit(inpfile, "_")[2]
	newdate := StrSplit(removeBegining, ".")[1]
	FormatTime, TimeString, %newdate%, dddd MMMM d, yyyy hh:mm tt
		;Announcement Screen
		Gui, Destroy
		Gui, 1: +LastFound
		Gui, 1: Color, black
		Gui, 2: +hwndGUI_ID
		hwnd := WinExist()
		Gui, 1: Font, s15	
		Gui, 1: -Caption
		Gui, 1: Add, Text, cFFFFFF x100 y50 w480 h640, Next Up 
		Gui, 1: Add, Text, cFFFFFF x100 y370 w480 h640, This session was played on:
		Gui, 1: Add, Text, cFFFFFF x100 y400 w480 h640, %TimeString%
		Gui, 1: add, picture, x100 y160 w300 h-1 hwndPic, C:\Users\mame\Desktop\HyperV\Media\MAME\Images\Wheel-Regular\%check%.png
		Gui, 1: Show, x0 y0 w480 h640
		WinGetPos,,, w, h, ahk_id %hwnd%
		Gui, 2: -Caption +E0x80000 +LastFound +OwnDialogs +Owner 
		Gui, 2: +hwndGUI_ID2
		Gui, 2: Show, NA
		GroupAdd, screensaver, ahk_id %hwnd%
		GroupAdd, screensaver, ahk_id %GUI_ID%
		GroupAdd, screensaver, ahk_id %GUI_ID2% 
		hwnd2 := WinExist()
		hbm := CreateDIBSection(h, w), hdc := CreateCompatibleDC(), obm := SelectObject(hdc, hbm), G := Gdip_GraphicsFromHDC(hdc)
		UpdateLayeredWindow(hwnd2, hdc, 0, 0, h, w)
		pBitmap := Gdip_BitmapFromScreen("hwnd:" hwnd)
		Gdip_ImageRotateFlip(pBitmap, 1)
		Gdip_DrawImage(G, pBitmap)
		UpdateLayeredWindow(hwnd2, hdc)
		Gdip_DisposeImage(pBitmap)
		sleep 10000
	If ("mario" = check) ; special setting for mario bros. to run in extended vertical res
	{
	Gui, 3:Color, black
	Gui, 3: -Caption
	Gui, 3: +HwndGUI_ID
	Gui, 3: Show, x0 y0 w%A_ScreenWidth% h%A_ScreenHeight%
	GroupAdd, screensaver, ahk_id %GUI_ID%	
	Run, C:\Groovymame\groovymame64.exe -pluginspath c:\groovymame\plugins_pb -screen_aspect 1:1 -sound none %check% -pb %inpfile%, c:\groovymame, hide
	sleep 2000
	Gui, 1: Destroy
	Gui, 2: Destroy
	SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
	Gdip_DeleteGraphics(G)
	WinWaitClose, ahk_exe groovymame64.exe
	}
	Else If ("dkspkyrmx" = check) || ("dkchrmx" = check)
	{
	Gui, 3:Color, black
	Gui, 3: -Caption
	Gui, 3: +HwndGUI_ID
	Gui, 3: Show, x0 y0 w%A_ScreenWidth% h%A_ScreenHeight%
	GroupAdd, screensaver, ahk_id %GUI_ID%	
	Run, C:\Groovymame\hbmame64ss.exe -pluginspath c:\groovymame\plugins_pb -sound none %check% -pb %inpfile%, c:\groovymame, hide
	sleep 2000
	Gui, 1: Destroy
	Gui, 2: Destroy
	SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
	Gdip_DeleteGraphics(G)
	WinWaitClose, ahk_exe hbmame64ss.exe
	}
	Else If ("tetrisgaiden" = check)
	{
	Gui, 3:Color, black
	Gui, 3: -Caption
	Gui, 3: +HwndGUI_ID
	Gui, 3: Show, x0 y0 w%A_ScreenWidth% h%A_ScreenHeight%
	GroupAdd, screensaver, ahk_id %GUI_ID%	
	Run, C:\Groovymame\groovymame64.exe snes -pluginspath c:\groovymame\plugins_pb -screen_aspect 1:1 -resolution 2560x256 -sound none -cart "C:\Games\SNES\tetrisgaiden.sfc" -pb %inpfile%, c:\groovymame, hide
	sleep 2000
	Gui, 1: Destroy
	Gui, 2: Destroy
	SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
	Gdip_DeleteGraphics(G)
	WinWaitClose, ahk_exe groovymame64.exe
	}
	Else
	{
	Gui, 3:Color, black
	Gui, 3: -Caption
	Gui, 3: +HwndGUI_ID
	Gui, 3: Show, x0 y0 w%A_ScreenWidth% h%A_ScreenHeight%
	GroupAdd, screensaver, ahk_id %GUI_ID%	
;Run, C:\Groovymame\groovymame64.exe -pluginspath c:\groovymame\plugins_pb -sound none -noplugin hiscore %check% -pb %inpfile%, c:\groovymame, hide	
	Run, C:\Groovymame\groovymame64.exe -pluginspath c:\groovymame\plugins_pb -sound none %check% -pb %inpfile%, c:\groovymame, hide	

	sleep 2000
	Gui, 1: Destroy
	Gui, 2: Destroy
	SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
	Gdip_DeleteGraphics(G)
	WinWaitClose, ahk_exe groovymame64.exe
	}
	settimer, MameRelaunch, 1500

}

return
}

While WinActive("ahk_exe mame64.exe")
{
	If (A_TimeIdleKeyboard > 1200000)
	{	
	Process, close, mame64.exe
	}
	return
}
While WinActive("ahk_exe hbmame64.exe")
{
	If (A_TimeIdleKeyboard > 180000)
	{	
	Process, close, mame64.exe
	}
	return
}

#IfWinActive, ahk_exe HyperSpin.exe
{
$F5::
KeyWait, F5
If A_TimeSinceThisHotkey > 3000
    shutdown 1
Else
    sendplay {F5}        
Return
}

#IfWinActive, ahk_group exitemu
{
		1::
		2::
		Ctrl::
		Reload
		Gui, 1: Destroy
		Gui, 2: Destroy
		Gui, 3: Destroy
		SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
		Gdip_DeleteGraphics(G)
		Process,Close, groovymame64.exe
		Process,Close, hbmame64ss.exe
		Return
		F5::
		Gui, 1: Destroy
		Gui, 2: Destroy
		SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
		Gdip_DeleteGraphics(G)
		Process,Close,groovymame64.exe	
		Process,Close, hbmame64ss.exe		
		Run, C:\Users\mame\Desktop\HyperV\RocketLauncher\RocketLauncher.exe -f "C:\Users\mame\Desktop\HyperV\Hyperspin.exe" -p "Hyperspin" -s "MAME" -r %check%
		sleep 2000
		Gui, 3: Destroy
		SetTimer, MameRelaunch, 1500
		return
}


return

