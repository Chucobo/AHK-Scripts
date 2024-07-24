#NoEnv 
#Warn

; Author: Bao
; Created: 2024-07-24
; Description: This script simulates pressing Win + Number based on a combination of hotkey and mouse actions.
; Requirements: AutoHotkey v1.1+

CoordMode, Mouse 
;---------------------------------------------------
;User Settings
global WindowUp:= "8" ;Change based on location of program on taskbar
global WindowRight:= "8"
global WindowDown:= "2"
global WindowLeft:= "2"

HotkeyTrigger:= "^Ralt" ;Change the hotkey to swap window
;----------------------------------------------------
global buttonClicked := false
HotKey, %HotkeyTrigger%, OpenGuiKey

; Create the GUI
Gui,1: +LastFound +AlwaysOnTop -Caption 
Gui,1:Color, 000000
Gui,1:Add,Button, gButtonClick w100 h100 xCenter yCenter,
WinSet, Transparent, 1

Gui,2: +LastFound +AlwaysOnTop -Caption 
Gui,2:Color, 000000
WinSet, Transparent, 222
Gui,2: Font, cWhite s20, JetBrains Mono
Gui,2: Add, Text,, Test GUI

; Hotkey to open the GUI
OpenGuiKey: ; Ctrl + Alt + R
{   
    ShowGui()
    userChoice := MouseDirection()
    ChangeWindow(userChoice)
    Gui,1: Hide
    Gui,2: Hide
    return
}

ShowGui(){
    MouseGetPos, origX, origY
    gui1PositionX:=origX - 25
    gui1PositionY:=origY - 25

    gui2PositionX:=origX + 50
    gui2PositionY:=origY - 35
    ; Show the GUI
    Gui,1: Show, w50 h50 x%gui1PositionX% y%gui1PositionY%
    Gui,2: Show,Autosize x%gui2PositionX% y%gui2PositionY%
}

;Find the direction of mouse movement from origin point
MouseDirection(){
    MouseGetPos, origX, origY
    mouseMoveDirection := "None"
    While (mouseMoveDirection = "None") 
    {
        MouseGetPos, newX, newY
        if(newX > (origX + 100))
        {
            return "right"
        }
        else if (newX < (origX - 100))
        {
            return "left"
        }
        else if (newY < (origY - 100))
        {
            return "up"
        }
        else if (newY > (origY + 100))
        {
            return "down"
        }
        else if (buttonClicked = true)
        {
            buttonClicked = false
            return "None"
        }
        Sleep, 25
    }
    
}
ChangeWindow(mouseMoveDirection){
    Switch (mouseMoveDirection) {
        Case "up":
            Send,#%WindowUp%
        Case "right":
            Send,#%WindowRight%
        Case "down":
            Send,#%WindowDown%
        Case "left":
            Send,#%WindowLeft%
        Case "None":
            return
        Default:
            MsgBox, Invalid selection. Please enter 1, 2, or 3.
    }
}
ButtonClick:
    buttonClicked := true
    return