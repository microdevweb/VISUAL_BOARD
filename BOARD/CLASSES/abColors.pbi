; *************************************************************************
; AUTHOR         : MicrodevWeb
; DESIGNED WITH  : Pb 5.71
; PROJECT        : Board
; PACKAGE        : BOARD.pbi
; CLASS          : abColors (ABSTRACT)
; FILE           : abColors.pbi
; DATE           : 2019/07/10
; *************************************************************************
;-* PRIVATE METHODS

;}
;-* PROTECTED METHODS

;}
;-* GETTERS METHODS

;}
;-* SETTER METHODS

;}
;-* PUBLIC METHODS

;}
;-* CONSTRUCTOR
Procedure ABCOLORS_super(*this._ABCOLORS,*s_daughter,*E_daughter)
  With *this
    ; allocate memory
    Protected motherLen = ?E_ABCOLORS - ?S_ABCOLORS,daughterLen = *E_daughter - *s_daughter
    \methods = AllocateMemory(motherLen + daughterLen)
    ; empilate methods address
    MoveMemory(?S_ABCOLORS,\methods,motherLen)
    MoveMemory(*s_daughter,\methods + motherLen,daughterLen)
    ; set values
    
  EndWith
EndProcedure
;}

DataSection
  S_ABCOLORS:
  
  E_ABCOLORS:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 25
; FirstLine = 15
; Folding = --
; EnableXP