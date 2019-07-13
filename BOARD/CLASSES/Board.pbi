; *************************************************************************
; AUTHOR         : MicrodevWeb
; DESIGNED WITH  : Pb 5.71
; PROJECT        : Board
; PACKAGE        : BOARD.pbi
; CLASS          : Board
; FILE           : Board.pbi
; DATE           : 2019/07/10
; *************************************************************************
Declare BOARD_build(*this._BOARD)
Declare _BOARD_refresh(*this._BOARD)
;-* PRIVATE METHODS
Procedure _BOARD_event()
  Protected *this._BOARD = GetGadgetData(EventGadget())
  Protected mx,my
  Static clickOn.b
  With *this
    StartVectorDrawing(ImageVectorOutput(\idImage))
    ScaleCoordinates(\myGrid\getZoomFactor(),\myGrid\getZoomFactor(),#PB_Coordinate_User)
    mx = GetGadgetAttribute(\idCanvas,#PB_Canvas_MouseX)
    my = GetGadgetAttribute(\idCanvas,#PB_Canvas_MouseY)
    mx + GetGadgetState(\idScrollH)
    my + GetGadgetState(\idScrollV)
    coordianteTo(mx,my,@mx,@my)
    StopVectorDrawing()
    Select EventType()
      Case #PB_EventType_MouseMove
        
      Case #PB_EventType_MouseEnter
        SetActiveGadget(\idCanvas)
      Case #PB_EventType_LeftButtonDown
        clickOn = #True
      Case #PB_EventType_LeftButtonUp
        clickOn = #False
        
        If \editedLink
          If \editedLink\getOutput() And \editedLink\getInput()
            AddElement(\myLinks())
            \myLinks() = newLink(\editedLink\getOutput(),\editedLink\getInput())
            BOARD_build(*this)
          EndIf
          \editedLink\free()
          \editedLink= 0
        EndIf
        gModeLink = #False
    EndSelect
    
    If *this
      Define *g._GRID = \myGrid
      *g\_post_event(*g,*this)
    EndIf
    ; we post event of forms
    ForEach \myForm()
      If \myForm()\_post_event(\myForm(),*this,mx,my) 
        ProcedureReturn 
      EndIf
    Next
    ; Manage link
    If \editedLink And clickOn
      gModeLink = #True
      If \editedLink\getInput() And \editedLink\getOutput()
        SetGadgetAttribute(\idCanvas,#PB_Canvas_Cursor,#PB_Cursor_Cross)
      Else
        SetGadgetAttribute(\idCanvas,#PB_Canvas_Cursor,#PB_Cursor_Denied)
      EndIf
      Define *l._LINK = \editedLink
      _BOARD_refresh(*this)
      StartVectorDrawing(CanvasVectorOutput(\idCanvas))
      *l\draw(*l,*this,mx,my)
      StopVectorDrawing()
      ProcedureReturn 
    EndIf
    SetGadgetAttribute(\idCanvas,#PB_Canvas_Cursor,#PB_Cursor_Default)
    
  EndWith
EndProcedure

Procedure _BOARD_eventScrool()
  Protected *this._BOARD = GetGadgetData(EventGadget())
  With *this
    BOARD_build(*this)
  EndWith
EndProcedure
;}
;-* PROTECTED METHODS
Procedure _BOARD_refresh(*this._BOARD)
  With *this
    SetGadgetAttribute(\idCanvas,#PB_Canvas_Image,ImageID(\idImage))
  EndWith
EndProcedure

Procedure _BOARD_drawMask(*this._BOARD,x,y,w,h,color)
  With *this
    StartVectorDrawing(CanvasVectorOutput(\idCanvas))
    VectorSourceImage(ImageID(\idImage))
    FillVectorOutput()
    ScaleCoordinates(\myGrid\getZoomFactor(),\myGrid\getZoomFactor(),#PB_Coordinate_User)
    AddPathBox(x - GetGadgetState(\idScrollH),y - GetGadgetState(\idScrollV),w,h)
    VectorSourceColor(color)
    FillPath()
    StopVectorDrawing()
  EndWith
EndProcedure

Procedure _BOARD_manageScrool(*this._BOARD)
  With *this
    ; look if scroll bar are requiered
    Protected maxW,maxH
    ForEach \myForm()
      If \myForm()\myPos\x + \myForm()\myPos\w > maxW
        maxW = \myForm()\myPos\x + \myForm()\myPos\w
      EndIf
      If \myForm()\myPos\y + \myForm()\myPos\h > maxH
        maxH = \myForm()\myPos\y + \myForm()\myPos\h
      EndIf
    Next
    If maxW > GadgetWidth(\idCanvas)
      SetGadgetAttribute(\idScrollH,#PB_ScrollBar_Maximum,maxW - GadgetWidth(\idCanvas) + 100 )
      HideGadget(\idScrollH,#False)
    Else
      SetGadgetAttribute(\idScrollH,#PB_ScrollBar_Maximum,0)
      SetGadgetState(\idScrollH,0)
      HideGadget(\idScrollH,#True)
    EndIf
    If maxH > GadgetHeight(\idCanvas)
      SetGadgetAttribute(\idScrollV,#PB_ScrollBar_Maximum,maxH - GadgetHeight(\idCanvas) + 100)
      HideGadget(\idScrollV,#False)
    Else
      SetGadgetAttribute(\idScrollV,#PB_ScrollBar_Maximum,0)
      SetGadgetState(\idScrollV,0)
      HideGadget(\idScrollV,#True)
    EndIf
  EndWith
EndProcedure

Procedure _BOARD_deselectAll(*this._BOARD)
  With *this
    ForEach \myForm()
      \myForm()\selected = #False
    Next
  EndWith
EndProcedure

;}
;-* GETTERS METHODS
Procedure BOARD_getGrid(*this._BOARD)
  With *this
    ProcedureReturn \myGrid
  EndWith
EndProcedure
;}
;-* SETTER METHODS

;}
;-* PUBLIC METHODS
Procedure BOARD_free(*this._BOARD)
  With *this
    \myGrid\free()
    
    FreeStructure(*this)
  EndWith
EndProcedure

Procedure BOARD_build(*this._BOARD)
  With *this
    Protected *tmp = *this
    StartVectorDrawing(ImageVectorOutput(\idImage))
    ScaleCoordinates(\myGrid\getZoomFactor(),\myGrid\getZoomFactor(),#PB_Coordinate_User)
    ; draw the grid
    Define *g._GRID = \myGrid
    *g\_draw(*g,*this)
    ForEach \myForm()
      If \myForm()\_draw
        \myForm()\_draw(\myForm(),*this)
      EndIf
    Next
    ForEach \myLinks()
      Define *l._LINK = \myLinks()
      *l\draw(*l,*this)
    Next
    StopVectorDrawing()
    _BOARD_refresh(*this)
  EndWith
EndProcedure

Procedure BOARD_addForm(*this._BOARD,*form)
  With *this
    AddElement(\myForm())
    \myForm() = *form
    Define *b.BOARD::Box = \myForm()
    ProcedureReturn *form
  EndWith
EndProcedure

;}
;-* CONSTRUCTOR
Procedure newBoard(containerId)
  Protected *this._BOARD = AllocateStructure(_BOARD)
  With *this
    \methods = ?S_BOARD
    \idContainer = containerId
    OpenGadgetList(\idContainer)
    ; create canvas
    \idCanvas = CanvasGadget(#PB_Any,0,0,GadgetWidth(\idContainer),GadgetHeight(\idContainer),#PB_Canvas_Keyboard|#PB_Canvas_Container)
    SetGadgetData(\idCanvas,*this)
    BindGadgetEvent(\idCanvas,@_BOARD_event())
    ; create image
    \idImage = CreateImage(#PB_Any,GadgetWidth(\idContainer),GadgetHeight(\idContainer))
    ; create vertical scroll bar
    Protected x = GadgetWidth(\idContainer) - 20
    Protected h = GadgetHeight(\idContainer) - 20
    \idScrollV = ScrollBarGadget(#PB_Any,x,0,20,h,0,0,10,#PB_ScrollBar_Vertical)
    SetGadgetData(\idScrollV,*this)
    BindGadgetEvent(\idScrollV,@_BOARD_eventScrool())
    HideGadget(\idScrollV,#True)
    ; create horizontal scroll bar
    Protected y = GadgetHeight(\idContainer) - 20
    Protected w = GadgetWidth(\idContainer) - 20
    \idScrollH = ScrollBarGadget(#PB_Any,0,Y,w,20,0,0,10)
    SetGadgetData(\idScrollH,*this)
    BindGadgetEvent(\idScrollH,@_BOARD_eventScrool())
    HideGadget(\idScrollH,#True)
    CloseGadgetList()
    CloseGadgetList()
    \myGrid = newGrid(20)
    \drawMask = @_BOARD_drawMask()
    \manageScroll = @_BOARD_manageScrool()
    \deselectAll = @_BOARD_deselectAll()
    ProcedureReturn *this
  EndWith
EndProcedure
;}

DataSection
  S_BOARD:
  ; GETTERS
  Data.i @BOARD_getGrid()
  ; PUBLIC METHODS
  Data.i @BOARD_free()
  Data.i @BOARD_build()
  Data.i @BOARD_addForm()
  E_BOARD:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x86)
; CursorPosition = 173
; FirstLine = 45
; Folding = 0f5o-
; EnableXP