
XIncludeFile "../BOARD/BOARD.pbi"

Structure _simple_box
  box.BOARD::Box
  leftIcon.BOARD::Icon
  rightIcon.BOARD::Icon
  childOf.BOARD::InputIcon
  motherOf.BOARD::OutputIcon
EndStructure
Global NewList mySimpleBoxes._simple_box()
Global myBoard.BOARD::Boars
Global  gICO_CLASS = CatchImage(#PB_Any,?ICO_CLASS)
Global  gICO_STANDARD = CatchImage(#PB_Any,?ICO_STANDARD)

Procedure eventSelect(item.BOARD::Box)
  If ChangeCurrentElement(mySimpleBoxes(),item\getData())
    Define t.BOARD::Title =  item\getTitle()
    Debug t\getTitle()
  EndIf
EndProcedure

Procedure addSimpleBox(title.s,leftIcon,rightIcon,x,y)
  
  AddElement(mySimpleBoxes())
  With mySimpleBoxes()
    ; we define a gradient color
    Define c.BOARD::GradientColor = BOARD::newGradientColor($FF4F4F4F,0.0)
    c\addColor($FF212121,0.1)
    c\addColor($FF4A4A4A,0.6)
    c\addColor($FF4A4A4A,0.8)
    c\addColor($FF080808,1)
    ; we create the box
    \box = myBoard\addForm(BOARD::newBox(title,c,x,y))
    ; we set a left icon
    \box\setLeftIcon(BOARD::newIcon(gICO_CLASS,36,36))
    ; we set a right icon
    \box\setRightIcon(BOARD::newIcon(gICO_STANDARD,36,36))
    ; we change the title color in white
    Define t.BOARD::Title = \box\getTitle()
    t\setColor($FFFFFFFF)
    ; we add a input icon
    \childOf = \box\addLeftContent(BOARD::newInputIcon("child of"))
    ; change title color
    t = \childOf\getTitle()
    t\setColor($FFFFFFFF)
    ; we add a output icon
    \motherOf = \box\addRightContent(BOARD::newOutputIcon("mother of"))
    ; change title color
    t = \motherOf\getTitle()
    t\setColor($FFFFFFFF)
    ; memorise list address
    \box\setData(@mySimpleBoxes())
    ; set callback when it selected
    \box\setSelecteCallback(@eventSelect())
  EndWith
EndProcedure

#MAIN_FORM = 0
#BOARD_CONTAINER = 0

OpenWindow(#MAIN_FORM,0,0,800,600,"Test",#PB_Window_SystemMenu|#PB_Window_ScreenCentered)
ContainerGadget(#BOARD_CONTAINER,0,0,800,600)
CloseGadgetList()

myBoard  = BOARD::newBoard(#BOARD_CONTAINER)
addSimpleBox("Person",0,0,50,50)
addSimpleBox("Contact",0,0,250,250)
myBoard\build()
Repeat
  WaitWindowEvent()
Until Event() = #PB_Event_CloseWindow

DataSection
  ICO_CLASS:
  IncludeBinary "IMG\class.png"
  ICO_STANDARD:
  IncludeBinary "IMG\standard.png"
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 2
; Folding = -
; EnableXP