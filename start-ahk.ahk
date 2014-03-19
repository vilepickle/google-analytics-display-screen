; AutoHotkey (http://www.autohotkey.com/) script to automate Realtime Google Analytics.
; Some parts of this are fragile and need some setup/configuration.  Occasionally the script needs to be updated, as Google likes to stealthily change their interface.
; 1. Make sure Google Chrome is installed.
; 2. Navigate to your Google Analytics realtime "Overview" page and copy the URL.  Put the URL below where specified.  This URL needs to be edited.  See the example already in place.
;    It needs to be edited by putting ` (tildes) before the % (percentage) characters.  This escapes the percentages, as they are normally used in AutoHotkey.
; 3. Enter your Google username and password in this script below.  If your password has an exclamation point, the format is {!}, as ! is used in AutoHotkey.
; 4. Make sure the "Main" and "Second" bookmarklets are in Chrome.  Use the Window Spy utility to get their exact coordinates when the Chrome window comes up.
;    This script physically clicks the bookmarklets.
; 5. Put this script in C:\Users\<USER>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
;    The script will loop every 2 hours to prevent Chrome browser crashes.
;    Problems?  Email David Lohmeyer at webmaster@acton.org or vilepickle@gmail.com

Loop
{
	; Close Chrome before execution
	SetTitleMatchMode,2
	loop
	{
		IfWinNotExist, Chrome
		break
		else
		WinClose, Chrome
	}
	Sleep 3000
	; Google Analytics realtime "Overview" URL
	Run, https://accounts.google.com/ServiceLogin?sacu=1&continue=https`%3A`%2F`%2Fwww.google.com`%2Fanalytics`%2Fweb`%2F`%3Fhl`%3Den`%26pli`%3D1`%23realtime`%2Frt-overview`%2Fa1853121w3269388p3345518`%2F&service=analytics&hl=en
	WinWait, Chrome
	WinMove, Chrome,, 0, 0, 1024, 768 ; Move the window found by WinWait to the upper-left corner of the screen.
	Sleep 15000
	; Click 505, 600 ; Click sign out and back in if needed
	Sleep 6000
	
	Send ^a
	Send {Del}
	Sleep 100
	Send YOUR_GOOGLE_USERNAME ; Google Username textfield
	Sleep 100
	Send {Tab}
	Sleep 100
	Send ^a
	Send {Del}
	Sleep 100
	Send YOUR_GOOGLE_PASSWORD ; Google Password textfield
	Sleep 100
	Send {Enter}
	Sleep 10000    ; Wait 10 seconds to cover network latency

	Click 117, 89  ; Main Button
	Sleep 400
	Click 236, 89  ; Second Button
	Sleep 400
	Send {F11}     ; Fullscreen
	Sleep 100
	MouseMove 0, 0
	Sleep 7200000  ; Wait for 2 hours before running again
}