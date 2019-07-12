; *************************************************************************
; AUTHOR         : MicrodevWeb
; DESIGNED WITH  : Pb 5.71
; PROJECT        : Board
; PACKAGE        : BOARD.pbi
; CLASS          : 
; FILE           : Board.pbi
; DATE           : 2019/07/10
; *************************************************************************
DeclareModule BOARD
  Interface Margins
    ; GETTERS
    getAbove()
    getBelow()
    getLeft()
    getRight()
    ; SETTERS
    setAbove()
    setBelow()
    setLeft()
    setRight()
  EndInterface
  Interface GradientColor
    ; PUBLIC
    addColor(color,position.f)
  EndInterface
  Interface __Content
    
  EndInterface
  Interface InputIcon Extends __Content
    ; GETTERS
    getTitle()
    getIcon()
    ; PUBLIC
    free()
  EndInterface
  Interface OutputIcon Extends __Content
    ; GETTERS
    getTitle()
    getIcon()
    ; PUBLIC
    free()
  EndInterface
  Interface Icon
    ; GETTERS
    getImage()
    getWidth()
    getHeight()
    ; SETTERS
    setImage(image)
    setWidth(width)
    setHeight(height)
    ; PUBLIC
    free()
  EndInterface
  Interface Title
    ; GETTERS
    getTitle.s()
    getFont()
    getColor()
    getWidth()
    getHeight()
    ; SETTERS
    setTitle(title.s)
    setFont(font)
    setColor(color)
    ; PUBLIC
    free()
  EndInterface
  Interface Colors
    ; GETTERS
    getBack()
    getFront()
    ; SETTER
    setBack(back)
    setFront(front)
    ; PUBLIC METHODS
    free()
  EndInterface
  Interface Grid
    ; GETTERS
    getSize()
    getColors()
    getZoomFactor.f()
    ; SETTER
    setSize(size)
    setZoomFactor(zoomFactor.f)
    ; PUBLIC METHODS
    free()
  EndInterface
  Interface Boars
    ; GETTERS
    getGrid()
    ; PUBLIC METHODS
    free()
    build()
    addForm(form)
  EndInterface
  Interface __Form
    ; GETTERS
    getColors()
    getPosX()
    getPosY()
    getWidht()
    getHeight()
    getSelectedColor()
    getData()
    ; SETTERS
    setPosX(x)
    setPosY(y)
    setSelectedColor(color)
    setData(myData)
    ; PUBLIC
    setSelecteCallback(callBack)
  EndInterface
  Interface Box Extends __Form
    ; GETTERS
    getTitle()
    getLeftIcon()
    getRightIcon()
    getMargins()
    ; SETTERS
    setLeftIcon(icon)
    setRightIcon(icon)
    ; PUBLIC
    free()
    addLeftContent(content)
    addRightContent(content)
  EndInterface
  Interface Link
    ; GETTERS
    getOutput()
    getInput()
    ; SETTER
    setOutput(output)
    setInput(input)
    ; PUBLIC
    free()
  EndInterface
  Declare newIcon(image,width,height)
  Declare newColors(back,front)
  Declare newBoard(containerId)
  Declare newTitle(title.s,font,color)
  Declare newBox(title.s,*color,x,y)
  Declare newInputIcon(title.s)
  Declare newOutputIcon(title.s)
  Declare newGradientColor(Firstcolor,position.f,horizontal.b = #False)
EndDeclareModule

Module BOARD
  EnableExplicit
  UsePNGImageDecoder()
  XIncludeFile "CLASSES/Structures.pbi"
  
  
  
;   Declare coordianteTo(x,y,*x,*y)
;   Declare coordianteToBis(x,y,*x,*y,canvasID)
  Declare newGrid(size)
  Declare ABCOLORS_super(*this._ABCOLORS,*s_daughter,*E_daughter)
  Declare FORM_super(*this._FORM,*s_daughter,*E_daughter,*colors,selectedColor,x,y)
  Declare CONTENT_super(*this._CONTENT,*s_daughter,*E_daughter)
  Declare newMargins(above,below,left,right)
  Declare newLink(*output,*input)
  
  XIncludeFile "CLASSES/Link.pbi"
  XIncludeFile "CLASSES/Margins.pbi"
  XIncludeFile "CLASSES/Content.pbi"
  XIncludeFile "CLASSES/OutputIcon.pbi"
  XIncludeFile "CLASSES/InputIcon.pbi"
  XIncludeFile "CLASSES/Icon.pbi"
  XIncludeFile "CLASSES/Title.pbi"
  XIncludeFile "CLASSES/abColors.pbi"
  XIncludeFile "CLASSES/Colors.pbi"
  XIncludeFile "CLASSES/GradientColor.pbi"
  XIncludeFile "CLASSES/Form.pbi"
  XIncludeFile "CLASSES/Box.pbi"
  XIncludeFile "CLASSES/Grid.pbi"
  
  XIncludeFile "CLASSES/Board.pbi"
  
EndModule

; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 165
; FirstLine = 38
; Folding = BA+
; EnableXP