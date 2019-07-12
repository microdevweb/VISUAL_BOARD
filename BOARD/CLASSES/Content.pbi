; *************************************************************************
; AUTHOR         : MicrodevWeb
; DESIGNED WITH  : Pb 5.71
; PROJECT        : Board
; PACKAGE        : BOARD.pbi
; CLASS          : Content (Abstract)
; FILE           : Content.pbi
; DATE           : 2019/07/10
; *************************************************************************
;-* PRIVATE METHODS

;}
;-* PROTECTED METHODS

;}
;-* GETTERS METHODS

;}
;-* SETTERS METHODS

;}
;-* PUBLIC METHODS

;}
;-* CONSTRUCTOR
Procedure CONTENT_super(*this._CONTENT,*s_daughter,*E_daughter)
  With *this
    ; allouer la mémoire
    Protected motherLen = ?E_CONTENT - ?S_CONTENT,daughterLen = *E_daughter - *s_daughter
    \methods = AllocateMemory(motherLen + daughterLen)
    ; empiler les adresses des méthodes
    MoveMemory(?S_CONTENT,\methods,motherLen)
    MoveMemory(*s_daughter,\methods + motherLen,daughterLen)
    ; set values
    
  EndWith
EndProcedure
;}

DataSection
  S_CONTENT:
  
  E_CONTENT:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 25
; FirstLine = 10
; Folding = --
; EnableXP