; *************************************************************************
; AUTHOR         : MicrodevWeb
; DESIGNED WITH  : Pb 5.71
; PROJECT        : Board
; PACKAGE        : BOARD.pbi
; CLASS          : GradientColor
; FILE           : GradientColor.pbi
; DATE           : 2019/07/10
; *************************************************************************
;-* PRIVATE METHODS

;}
;-* PROTECTED METHODS
Procedure _GRADIENT_set(*this._GRADIENT_COLOR,color = 0 ,x = 0 ,y = 0 ,w = 0 ,h = 0 )
  With *this
    If Not \horizontal
      VectorSourceLinearGradient(0,y,0,y+h)
      ForEach \myColors()
        VectorSourceGradientColor(\myColors()\color,\myColors()\position)
      Next
    EndIf
  EndWith
EndProcedure
;}
;-* GETTERS METHODS

;}
;-* SETTER METHODS

;}
;-* PUBLIC METHODS
Procedure GRADIENT_addColor(*this._GRADIENT_COLOR,color,position.f)
  With *this
    AddElement(\myColors())
    \myColors()\color = color
    \myColors()\position = position
  EndWith
EndProcedure
;}
;-* CONSTRUCTOR
Procedure newGradientColor(Firstcolor,position.f,horizontal.b = #False)
  Protected *this._GRADIENT_COLOR = AllocateStructure(_GRADIENT_COLOR)
  With *this
    ABCOLORS_super(*this,?S_GRADIENT_COLOR,?E_GRADIENT_COLOR)
    \_set = @_GRADIENT_set()
    \horizontal = horizontal
    AddElement(\myColors())
    \myColors()\color = Firstcolor
    \myColors()\position = position
    ProcedureReturn *this
  EndWith
EndProcedure
;}

DataSection
  S_GRADIENT_COLOR:
  ; PUBLIC
  Data.i @GRADIENT_addColor()
  E_GRADIENT_COLOR:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 16
; FirstLine = 7
; Folding = --
; EnableXP