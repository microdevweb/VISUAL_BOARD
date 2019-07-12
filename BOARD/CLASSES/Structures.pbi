; *************************************************************************
; AUTHOR         : MicrodevWeb
; DESIGNED WITH  : Pb 5.71
; PROJECT        : Board
; PACKAGE        : BOARD.pbi
; CLASS          : 
; FILE           : Structures.pbi
; DATE           : 2019/07/10
; *************************************************************************
Global gModeLink.b
Prototype draw(*this,*board,mx = 0,my = 0)
Prototype drawInPos(*this,x,y,right.b = #False)
Prototype set_color(*this,color = 0 ,x = 0 ,y = 0 ,w = 0 ,h = 0 )
Prototype post_event(*this,*board,mx = 0,my = 0)
Prototype getHeight(*this)
Prototype GetWidth(*this)
Prototype drawMask(*this,x,y,w,h,color)
Prototype manageScroll(*this)
Prototype manageMagnet(*this,*board,*x,*y)
Prototype deselectAll(*this)
Prototype selectCallback(*this)
Prototype linkCallback(*this,validate.b)
Structure _ABCOLORS
  *methods
  _set.set_color
EndStructure
Structure _COLORS Extends _ABCOLORS
  back.i
  front.i
EndStructure
Structure _GRADIENT
  color.i
  position.i
EndStructure
Structure _GRADIENT_COLOR Extends _ABCOLORS
  horizontal.b
  List myColors._GRADIENT()
EndStructure
Structure _GRID
  *methods
  size.i
  sensitive.i
  myColors.BOARD::Colors
  _draw.draw
  zoomFactor.f
  _post_event.post_event
  manageMagnet.manageMagnet
EndStructure
Structure _POS
  x.i
  y.i
  w.i
  h.i
EndStructure
Structure _CONTENT
  *methods
  myPOS._POS
  _draw.drawInPos
  _post_event.post_event
EndStructure
Structure _INPUT Extends _CONTENT
  myTitle.BOARD::Title
  myIcon.BOARD::Icon
EndStructure
Structure _OUTPUT Extends _CONTENT
  myTitle.BOARD::Title
  myIcon.BOARD::Icon
EndStructure
Structure _TITLE
  *methods
  title.s
  color.i
  font.i
  myPos._POS
  _draw.draw
  _post_event.post_event
EndStructure
Structure _FORM
  *methods
  myPos._POS
  *myColor._ABCOLORS
  _draw.draw
  _post_event.post_event
  selected.b
  selectedColor.i
  selectCallback.selectCallback
  *data
EndStructure
Structure _MARGIN
  *methods
  left.i
  right.i
  above.i
  below.i
EndStructure
Structure _ICON
  *methods
  image.i
  width.i
  height.i
  _draw.drawInPos
  _postEvent.post_event
EndStructure
Structure _BOX Extends _FORM
  *myMargin._MARGIN
  *myTitle._TITLE
  *leftIcon._iCON
  *rightIcon._iCON
  displaceringColor.i
  List *myLeftContent._CONTENT()
  List *myRightContent._CONTENT()
EndStructure
Structure _LINK
  *methods
  *output._OUTPUT
  *input._INPUT
  draw.draw
EndStructure
Structure _BOARD
  *methods
  idContainer.i
  idCanvas.i
  idImage.i
  idScrollV.i
  idScrollH.i
  myGrid.BOARD::Grid
  List *myForm._FORM()
  drawMask.drawMask
  manageScroll.manageScroll
  deselectAll.deselectAll
  editedLink.BOARD::Link
  List myLinks.BOARD::Link()
  linkCallback.linkCallback
EndStructure


Procedure coordianteTo(x,y,*x,*y)
  PokeL(*x,ConvertCoordinateX(x,y,#PB_Coordinate_Device,#PB_Coordinate_User))
  PokeL(*Y,ConvertCoordinateY(x,y,#PB_Coordinate_Device,#PB_Coordinate_User))
EndProcedure 


; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 9
; FirstLine = 5
; Folding = AA+
; EnableXP