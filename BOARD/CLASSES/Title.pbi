; *************************************************************************
; AUTHOR         : MicrodevWeb
; DESIGNED WITH  : Pb 5.71
; PROJECT        : Board
; PACKAGE        : BOARD.pbi
; CLASS          : Title
; FILE           : Title.pbi
; DATE           : 2019/07/10
; *************************************************************************
;-* PRIVATE METHODS

;}
;-* PROTECTED METHODS
Procedure _TITLE_draw(*this._TITLE,*board._BOARD)
  With *this
    
  EndWith
EndProcedure

Procedure _TITLE_postEvent(*this._TITLE,*board._BOARD)
  With *this
    
  EndWith
EndProcedure
;}
;-* GETTERS METHODS
Procedure.s TITLE_getTitle(*this._TITLE)
  With *this
    ProcedureReturn \title
  EndWith
EndProcedure

Procedure TITLE_getFont(*this._TITLE)
  With *this
    ProcedureReturn \font
  EndWith
EndProcedure

Procedure TITLE_getColor(*this._TITLE)
  With *this
    ProcedureReturn \color
  EndWith
EndProcedure

Procedure TITLE_getWidth(*this._TITLE)
  With *this
    VectorFont(FontID(\font))
    ProcedureReturn VectorTextWidth(\title)
  EndWith
EndProcedure

Procedure TITLE_getHeight(*this._TITLE)
  With *this
    VectorFont(FontID(\font))
    ProcedureReturn VectorTextHeight(\title)
  EndWith
EndProcedure

;}
;-* SETTERS METHODS
Procedure TITLE_setTitle(*this._TITLE,title.s)
  With *this
     \title = title
  EndWith
EndProcedure

Procedure TITLE_setFont(*this._TITLE,font)
  With *this
     \font  = font
  EndWith
EndProcedure

Procedure TITLE_setColor(*this._TITLE,color)
  With *this
     \color = color
  EndWith
EndProcedure
;}
;-* PUBLIC METHODS
Procedure TITLE_free(*this._TITLE)
  With *this
    FreeStructure(*this)
  EndWith
EndProcedure
;}
;-* CONSTRUCTOR
Procedure newTitle(title.s,font,color)
  Protected *this._TITLE = AllocateStructure(_TITLE)
  With *this
    \methods = ?S_TITLE
    \title = title
    \font = font
    \color = color
    \_draw = @_TITLE_draw()
    \_post_event = @_TITLE_postEvent()
    ProcedureReturn *this
  EndWith
EndProcedure
;}

DataSection
  S_TITLE:
  ; GETTERS
  Data.i @TITLE_getTitle()
  Data.i @TITLE_getFont()
  Data.i @TITLE_getColor()
  Data.i @TITLE_getWidth()
  Data.i @TITLE_getHeight()
  ; SETTERS
  Data.i @TITLE_setTitle()
  Data.i @TITLE_setFont()
  Data.i @TITLE_setColor()
  ; PUBLIC
  Data.i @TITLE_free()
  E_TITLE:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 60
; FirstLine = 6
; Folding = Awc-
; EnableXP