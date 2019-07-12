; *************************************************************************
; AUTHOR         : MicrodevWeb
; DESIGNED WITH  : Pb 5.71
; PROJECT        : Board
; PACKAGE        : BOARD.pbi
; CLASS          : Link
; FILE           : Link.pbi
; DATE           : 2019/07/10
; *************************************************************************
;-* PRIVATE METHODS

;}
;-* PROTECTED METHODS
Procedure _LINK_draw(*this._LINK,*board._BOARD,mx,my)
  With *this
    Protected x,y,x1,y1
    x = \output\myPOS\x + (\output\myPOS\w / 2)
    y = \outPut\myPos\y + (\outPut\myPos\h / 2)
    If \input
      x1 = \inPut\myPos\x
      y1 = \inPut\myPos\y + (\inPut\myPos\h / 2) 
    Else
      x1 = mx
      y1 = my
    EndIf
    Protected x2,y2,x3,y3
    If Not \input
      If x < x1
        x2 = x1 + ((x - x1) * 0.5)
        x3 = x - ((x - x1) * 0.5)
      Else
        x2 = x1 -  ((x1 - x) * 0.5)
        x3 = x + ((x - x1) * 0.5)
      EndIf
      If y < y1
        y2 = y1 - ((y -  y1) * 0.5)
      Else
        y2 = y1 + ((y1 -  y) * 0.5)
      EndIf
    Else
      If x1 < x
        x1 + (\input\myPOS\w / 2)
        x + (\output\myPOS\w / 2)
      Else
        x + (\outPut\myPos\w / 2)
      EndIf
      
      If x < x1
        x2 = x1 + ((x - x1) * 0.5)
        x3 = x - ((x - x1) * 0.5)
      Else
        x2 = x1 -  ((x1 - x) * 0.5)
        x3 = x + ((x - x1) * 0.5)
      EndIf
      If y < y1
        y2 = y1 - ((y -  y1) * 0.5)
      Else
        y2 = y1 + ((y1 -  y) * 0.5)
      EndIf
    EndIf
    MovePathCursor(x1,y1)
    AddPathCurve(x2,y1,x3,y,x,y)
    VectorSourceColor($FF00D7FF)
    StrokePath(2)
  EndWith
EndProcedure
;}
;-* GETTERS METHODS
Procedure LINK_getOutput(*this._LINK)
  With *this
    ProcedureReturn \output
  EndWith
EndProcedure

Procedure LINK_getInput(*this._LINK)
  With *this
    ProcedureReturn \input
  EndWith
EndProcedure
;}
;-* SETTER METHODS
Procedure LINK_setOutput(*this._LINK,*output)
  With *this
     \output = *output
  EndWith
EndProcedure

Procedure LINK_setInput(*this._LINK,*input)
  With *this
     \input = *input
  EndWith
EndProcedure
;}
;-* PUBLIC METHODS
Procedure LINK_free(*this._LINK)
  With *this
     FreeStructure(*this)
  EndWith
EndProcedure
;}
;-* CONSTRUCTOR
Procedure newLink(*output,*input)
  Protected *this._LINK = AllocateStructure(_LINK)
  With *this
    \methods = ?S_LINK
    \input = *input
    \output = *output
    \draw = @_LINK_draw()
    ProcedureReturn *this
  EndWith
EndProcedure
;}

DataSection
  S_LINK:
  ; GETTERS
  Data.i @LINK_getOutput()
  Data.i @LINK_getInput()
  ; SETTER
  Data.i @LINK_setOutput()
  Data.i @LINK_setInput()
  ; PUBLIC
  Data.i @LINK_free()
  E_LINK:
EndDataSection


; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 41
; FirstLine = 27
; Folding = +Pe-
; EnableXP