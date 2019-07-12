; *************************************************************************
; AUTHOR         : MicrodevWeb
; DESIGNED WITH  : Pb 5.71
; PROJECT        : Board
; PACKAGE        : BOARD.pbi
; CLASS          : Margins
; FILE           : Margins.pbi
; DATE           : 2019/07/10
; *************************************************************************
;-* PRIVATE METHODS

;}
;-* PROTECTED METHODS

;}
;-* GETTERS METHODS
Procedure MARGINS_getAbove(*this._MARGIN)
  With *this
    ProcedureReturn \above
  EndWith
EndProcedure

Procedure MARGINS_getBelow(*this._MARGIN)
  With *this
    ProcedureReturn \below
  EndWith
EndProcedure

Procedure MARGINS_getLeft(*this._MARGIN)
  With *this
    ProcedureReturn \left
  EndWith
EndProcedure

Procedure MARGINS_getRight(*this._MARGIN)
  With *this
    ProcedureReturn \right
  EndWith
EndProcedure
;}
;-* SETTERS METHODS
Procedure MARGINS_setAbove(*this._MARGIN,above)
  With *this
     \above = above
  EndWith
EndProcedure

Procedure MARGINS_setBelow(*this._MARGIN,below)
  With *this
     \below = below
  EndWith
EndProcedure

Procedure MARGINS_setLeft(*this._MARGIN,left)
  With *this
     \left = left
  EndWith
EndProcedure

Procedure MARGINS_setRight(*this._MARGIN,right)
  With *this
     \right = right
  EndWith
EndProcedure
;}
;-* PUBLIC METHODS

;}
;-* CONSTRUCTOR
Procedure newMargins(above,below,left,right)
  Protected *this._MARGIN = AllocateStructure(_MARGIN)
  With *this
    \methods = ?S_MARGIN
    \above = above
    \below = below
    \right = right
    \left = left
    ProcedureReturn *this
  EndWith
EndProcedure
;}

DataSection
  S_MARGIN:
  ; GETTERS
  Data.i @MARGINS_getAbove()
  Data.i @MARGINS_getBelow()
  Data.i @MARGINS_getLeft()
  Data.i @MARGINS_getRight()
  ; SETTERS
  Data.i @MARGINS_setAbove()
  Data.i @MARGINS_setBelow()
  Data.i @MARGINS_setLeft()
  Data.i @MARGINS_setRight()
  E_MARGIN:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 15
; FirstLine = 1
; Folding = AA5
; EnableXP