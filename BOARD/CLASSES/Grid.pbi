; *************************************************************************
; AUTHOR         : MicrodevWeb
; DESIGNED WITH  : Pb 5.71
; PROJECT        : Board
; PACKAGE        : BOARD.pbi
; CLASS          : Grid
; FILE           : Grid.pbi
; DATE           : 2019/07/10
; *************************************************************************
;-* PRIVATE METHODS
Procedure _GRID_postEvent(*this._GRID,*board._BOARD,mx = 0,my = 0)
  With *this
    If EventType() = #PB_EventType_MouseWheel
      If GetGadgetAttribute(*board\idCanvas,#PB_Canvas_Modifiers) = #PB_Canvas_Control
        Select  GetGadgetAttribute(*board\idCanvas,#PB_Canvas_WheelDelta)
          Case 1
            If \zoomFactor < 10
              \zoomFactor + 0.1
            EndIf
          Case -1
            If \zoomFactor > 0.5
              \zoomFactor - 0.1
            EndIf
        EndSelect
        ; redraw canvas
        Define b.BOARD::Boars = *board
        b\build()
      EndIf
    EndIf
  EndWith
EndProcedure
;}
;-* PROTECTED METHODS
Procedure _GRID_draw(*this._GRID,*board._BOARD,mx = 0,my = 0)
  With *this
    ; fill with back color
    Define *c._COLORS = \myColors
    *c\_set(*c,1)
    FillVectorOutput()
    ; draw column
    *c\_set(*c,2)
    Protected c = \size,w = ImageWidth(*board\idImage)
    Protected h = ImageHeight(*board\idImage)
    coordianteTo(w,h,@w,@h)
    ; we considere scroll bar decalage
    c - GetGadgetState(*board\idScrollH)
    While  c < w
      If c >= 0
        MovePathCursor(c,0)
        AddPathLine(c,h)
      EndIf
      c + \size
    Wend
    ; draw lines
    Protected r = \size
    ; we considere scroll bar decalage
    r - GetGadgetState(*board\idScrollV)
    While  r < h
      If r >= 0
        MovePathCursor(0,r)
        AddPathLine(w,r)
      EndIf
      r + \size
    Wend
    StrokePath(1)
  EndWith
EndProcedure

Procedure _GRID_manageMagnet(*this._GRID,*board._BOARD,*x,*y)
  ; gestion de l'aimantation
  With *this
    Protected x = PeekL(*x),y = PeekL(*y),lM.f =  \size - \sensitive,LP.f = \sensitive
    If Mod(PeekL(*x),\size) >= LM
      x =  Round(PeekL(*x)/\size,#PB_Round_Up) * \size
    ElseIf Mod(PeekL(*x),\size) <= LP
      x =  Round(PeekL(*x)/\size,#PB_Round_Nearest) * \size
    EndIf
    If Mod(PeekL(*y),\size) >= LM
      Y =  Round(PeekL(*y)/\size,#PB_Round_Up) * \size
    ElseIf Mod(PeekL(*y),\size) <= LP
      Y =  Round(PeekL(*y)/\size,#PB_Round_Nearest) * \size
    EndIf
    
    PokeL(*x,x)
    PokeL(*y,y)
  EndWith
EndProcedure
;}

;-* GETTERS METHODS
Procedure GRID_getSize(*this._GRID)
  With *this
    ProcedureReturn \size
  EndWith
EndProcedure

Procedure GRID_getColors(*this._GRID)
  With *this
    ProcedureReturn \myColors
  EndWith
EndProcedure

Procedure.f GRID_getZoomFactor(*this._GRID)
  With *this
    ProcedureReturn \zoomFactor
  EndWith
EndProcedure
;}
;-* SETTER METHODS
Procedure GRID_setSize(*this._GRID,size)
  With *this
     \size = size
  EndWith
EndProcedure

Procedure GRID_setZoomFactor(*this._GRID,zoomFactor)
  With *this
     \zoomFactor = zoomFactor
  EndWith
EndProcedure
;}
;-* PUBLIC METHODS
Procedure GRID_free(*this._GRID)
  With *this
    \myColors\free()
    FreeStructure(*this)
  EndWith
EndProcedure
;}
;-* CONSTRUCTOR
Procedure newGrid(size)
  Protected *this._GRID = AllocateStructure(_GRID)
  With *this
    \methods = ?S_GRID
    \size = SIZE
    \sensitive = 10
    \zoomFactor = 1
    \myColors = newColors($FF575757,$FFBFBFBF)
    \_draw = @_GRID_draw()
    \_post_event = @_GRID_postEvent()
    \manageMagnet = @_GRID_manageMagnet()
    ProcedureReturn *this
  EndWith
EndProcedure
;}

DataSection
  S_GRID:
  ; GETTERS
  Data.i @GRID_getSize()
  Data.i @GRID_getColors()
  Data.i @GRID_getZoomFactor()
  ; SETTER
  Data.i @GRID_setSize()
  Data.i @GRID_setZoomFactor()
  ; PUBLIC METHODS
  Data.i @GRID_free()
  E_GRID:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x86)
; CursorPosition = 10
; FirstLine = 7
; Folding = -0j9-
; EnableXP