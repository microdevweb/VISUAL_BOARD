; *************************************************************************
; AUTHOR         : MicrodevWeb
; DESIGNED WITH  : Pb 5.71
; PROJECT        : Board
; PACKAGE        : BOARD.pbi
; CLASS          : Colors
; FILE           : Colors.pbi
; DATE           : 2019/07/10
; *************************************************************************
;-* PRIVATE METHODS

;}
;-* PROTECTED METHODS
Procedure _COLORS_set(*this._COLORS,color = 0 ,x = 0 ,y = 0 ,w = 0 ,h = 0 )
  With *this
    If color = 1
      VectorSourceColor(\back)
    ElseIf color = 2
      VectorSourceColor(\front)
    EndIf
  EndWith
EndProcedure
;}
;-* GETTERS METHODS
Procedure COLORS_getBack(*this._COLORS)
  With *this
    ProcedureReturn \back
  EndWith
EndProcedure

Procedure COLORS_getFront(*this._COLORS)
  With *this
    ProcedureReturn \front
  EndWith
EndProcedure
;}
;-* SETTER METHODS
Procedure COLORS_setBack(*this._COLORS,back)
  With *this
     \back = back
  EndWith
EndProcedure

Procedure COLORS_setFront(*this._COLORS,front)
  With *this
     \front = front
  EndWith
EndProcedure
;}
;-* PUBLIC METHODS
Procedure COLORS_free(*this._COLORS)
  With *this
    FreeStructure(*this)
  EndWith
EndProcedure
;}
;-* CONSTRUCTOR
Procedure newColors(back,front)
  Protected *this._colors = AllocateStructure(_colors)
  With *this
    ABCOLORS_super(*this,?S_COLORS,?E_COLORS)
    \back = back
    \front = front
    \_set = @_COLORS_set()
    ProcedureReturn *this
  EndWith
EndProcedure
;}

DataSection
  S_COLORS:
  ; GETTERS
  Data.i @COLORS_getBack()
  Data.i @COLORS_getFront()
  ; SETTER
  Data.i @COLORS_setBack()
  Data.i @COLORS_setFront()
  ; PUBLIC METHODS
  Data.i @COLORS_free()
  E_COLORS:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 13
; FirstLine = 8
; Folding = Oy-
; EnableXP