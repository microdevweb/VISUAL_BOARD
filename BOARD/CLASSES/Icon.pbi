; *************************************************************************
; AUTHOR         : MicrodevWeb
; DESIGNED WITH  : Pb 5.71
; PROJECT        : Board
; PACKAGE        : BOARD.pbi
; CLASS          : Icon
; FILE           : Icon.pbi
; DATE           : 2019/07/10
; *************************************************************************
;-* PRIVATE METHODS

;}
;-* PROTECTED METHODS
Procedure _ICON_draw(*this._ICON,x,y)
  With *this
    
  EndWith
EndProcedure
Procedure _ICON_event(*this._ICON,*board._BOARD)
  With *this
    
  EndWith
EndProcedure
;}
;-* GETTERS METHODS
Procedure ICON_getImage(*this._ICON)
  With *this
    ProcedureReturn \image
  EndWith
EndProcedure

Procedure ICON_getWidth(*this._ICON)
  With *this
    ProcedureReturn \width
  EndWith
EndProcedure

Procedure ICON_getHeight(*this._ICON)
  With *this
    ProcedureReturn \height
  EndWith
EndProcedure
;}
;-* SETTERS METHODS
Procedure ICON_setImage(*this._ICON,image)
  With *this
     \image = image
  EndWith
EndProcedure

Procedure ICON_setWidth(*this._ICON,width)
  With *this
     \width = width
  EndWith
EndProcedure

Procedure ICON_setHeight(*this._ICON,height)
  With *this
     \height = height
  EndWith
EndProcedure
;}
;-* PUBLIC METHODS
Procedure ICON_free(*this._ICON)
  With *this
     FreeStructure(*this)
  EndWith
EndProcedure
;}
;-* CONSTRUCTOR
Procedure newIcon(image,width,height)
  Protected *this._ICON = AllocateStructure(_ICON)
  With *this
    \methods = ?S_ICON
    \image = image
    \width = width
    \height = height
    \_draw = @_ICON_draw()
    \_postEvent = @_ICON_event()
    ProcedureReturn *this
  EndWith
EndProcedure
;}

DataSection
  S_ICON:
  ; GETTERS
  Data.i @ICON_getImage()
  Data.i @ICON_getWidth()
  Data.i @ICON_getHeight()
  ; SETTERS
  Data.i @ICON_setImage()
  Data.i @ICON_setWidth()
  Data.i @ICON_setHeight()
  ; PUBLIC
  Data.i @ICON_free()
  E_ICON:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 70
; Folding = AE0
; EnableXP