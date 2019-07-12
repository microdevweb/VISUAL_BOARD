; *************************************************************************
; AUTHOR         : MicrodevWeb
; DESIGNED WITH  : Pb 5.71
; PROJECT        : Board
; PACKAGE        : BOARD.pbi
; CLASS          : _Form (Abstract)
; FILE           : Form.pbi
; DATE           : 2019/07/10
; *************************************************************************
;-* PRIVATE METHODS

;}
;-* PROTECTED METHODS

;}
;-* GETTERS METHODS
Procedure FORM_getColors(*this._FORM)
  With *this._FORM
    ProcedureReturn \myColor
  EndWith
EndProcedure

Procedure FORM_getPosX(*this._FORM)
  With *this._FORM
    ProcedureReturn \myPos\x
  EndWith
EndProcedure

Procedure FORM_getPosY(*this._FORM)
  With *this._FORM
    ProcedureReturn \myPos\y
  EndWith
EndProcedure

Procedure FORM_getWidht(*this._FORM)
  With *this._FORM
    ProcedureReturn \myPos\w
  EndWith
EndProcedure

Procedure FORM_getHeight(*this._FORM)
  With *this._FORM
    ProcedureReturn \myPos\h
  EndWith
EndProcedure

Procedure FORM_getSelectedColor(*this._FORM)
  With *this._FORM
    ProcedureReturn \selectedColor
  EndWith
EndProcedure

Procedure FORM_getData(*this._FORM)
  With *this
    ProcedureReturn \data 
  EndWith
EndProcedure
;}
;-* SETTERS METHODS
Procedure FORM_setPosX(*this._FORM,x)
  With *this._FORM
     \myPos\x = x
  EndWith
EndProcedure

Procedure FORM_setPosY(*this._FORM,y)
  With *this._FORM
     \myPos\y = y
  EndWith
EndProcedure

Procedure FORM_setSelectedColor(*this._FORM,selectedColor)
  With *this._FORM
     \selectedColor = selectedColor
  EndWith
EndProcedure

Procedure FORM_setData(*this._FORM,*data)
  With *this
    \data = *data
  EndWith
EndProcedure
;}
;-* PUBLIC METHODS
Procedure FORM_setSelecteCallback(*this._FORM,*callback)
  With *this
    \selectCallback = *callback
  EndWith
EndProcedure
;}
;-* CONSTRUCTOR
Procedure FORM_super(*this._FORM,*s_daughter,*E_daughter,*colors,selectedColor,x,y)
  With *this
    ; allocate memory
    Protected motherLen = ?E_FORM - ?S_FORM,daughterLen = *E_daughter - *s_daughter
    \methods = AllocateMemory(motherLen + daughterLen)
    ; empilate method address
    MoveMemory(?S_FORM,\methods,motherLen)
    MoveMemory(*s_daughter,\methods + motherLen,daughterLen)
    ; set values
    \myColor = *colors
    \myPos\x = x
    \myPos\y = y
    \selectedColor = selectedColor
  EndWith
EndProcedure
;}

DataSection
  S_FORM:
  ; GETTERS
  Data.i @FORM_getColors()
  Data.i @FORM_getPosX()
  Data.i @FORM_getPosY()
  Data.i @FORM_getWidht()
  Data.i @FORM_getHeight()
  Data.i @FORM_getSelectedColor()
  Data.i @FORM_getData()
  ; SETTERS
  Data.i @FORM_setPosX()
  Data.i @FORM_setPosY()
  Data.i @FORM_setSelectedColor()
  Data.i @FORM_setData()
  ; PUBLIC
  Data.i @FORM_setSelecteCallback()
  E_FORM:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 122
; FirstLine = 44
; Folding = EYc+
; EnableXP