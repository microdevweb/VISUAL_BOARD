; *************************************************************************
; AUTHOR         : MicrodevWeb
; DESIGNED WITH  : Pb 5.71
; PROJECT        : Board
; PACKAGE        : BOARD.pbi
; CLASS          : InputIcon
; FILE           : InputIcon.pbi
; DATE           : 2019/07/10
; *************************************************************************
Global gInputIcon = CatchImage(#PB_Any,?ICON_INPUT)
Global gLinkIcon = CatchImage(#PB_Any,?ICON_LINK)
;-* PRIVATE METHODS
Procedure _INPUT_hoverMe(*this._INPUT,mx,my)
  With *this
    If mx >= \myPOS\x And mx <= \myPOS\x + \myPOS\w
      If my >= \myPOS\y And my <= \myPOS\y + \myPOS\h
        ProcedureReturn #True
      EndIf
    EndIf
    ProcedureReturn #False
  EndWith
EndProcedure
;}
;-* PROTECTED METHODS
Procedure _INPUT_draw(*this._INPUT,x,y,right.b = #False)
  With *this
    Protected xt,yt
    If Not right
      MovePathCursor(x,y)
      \myPOS\x = x
      \myPOS\y = y
      DrawVectorImage(ImageID(\myIcon\getImage()),255,\myIcon\getWidth(),\myIcon\getHeight())
      
      xt = x + \myIcon\getWidth() + 5
      VectorFont(FontID(\myTitle\getFont()))
      yt = y + (\myIcon\getHeight() / 2) - (VectorTextHeight(\myTitle\getTitle()) / 2)
      VectorSourceColor(\myTitle\getColor())
      MovePathCursor(xt,yt)
      DrawVectorText(\myTitle\getTitle())
    Else
      MovePathCursor(x - \myIcon\getWidth(),y)
      \myPOS\x = x - \myIcon\getWidth()
      \myPOS\y = y
      DrawVectorImage(ImageID(\myIcon\getImage()),255,\myIcon\getWidth(),\myIcon\getHeight())
      \myPOS\w = \myIcon\getWidth()
      \myPOS\h = \myIcon\getHeight()
      VectorFont(FontID(\myTitle\getFont()))
      xt = x - \myIcon\getWidth() - 5 - VectorTextWidth(\myTitle\getTitle())
      yt = y + (\myIcon\getHeight() / 2) - (VectorTextHeight(\myTitle\getTitle()) / 2)
      VectorSourceColor(\myTitle\getColor())
      MovePathCursor(xt,yt)
      DrawVectorText(\myTitle\getTitle())
    EndIf
  EndWith
EndProcedure

Procedure _INPUT_event(*this._INPUT,*board._BOARD,mx,my)
  With *this
    Static clickOn.b
    Select EventType()
      Case #PB_EventType_MouseMove
        If _INPUT_hoverMe(*this,mx,my)
          If clickOn
            If *board\editedLink
              If Not *board\editedLink\getInput() 
                *board\editedLink\setInput(*this)
                ProcedureReturn #True
              EndIf
              SetGadgetAttribute(*board\idCanvas,#PB_Canvas_Cursor, #PB_Cursor_Cross)
               ProcedureReturn #True
            EndIf
          EndIf
        EndIf
      Case #PB_EventType_LeftButtonDown
        clickOn = #True
      Case #PB_EventType_LeftButtonUp
        clickOn = #False
    EndSelect
  EndWith
EndProcedure
;}
;-* GETTERS METHODS
Procedure INPUT_getTitle(*this._INPUT)
  With *this
    ProcedureReturn \myTitle
  EndWith
EndProcedure

Procedure INPUT_getIcon(*this._INPUT)
  With *this
    ProcedureReturn \myIcon
  EndWith
EndProcedure

;}
;-* SETTERS METHODS

;}
;-* PUBLIC METHODS
Procedure INPUT_free(*this._INPUT)
  With *this
    \myIcon\free()
    \myTitle\free()
    FreeStructure(*this)
  EndWith
EndProcedure
;}
;-* CONSTRUCTOR
Procedure newInputIcon(title.s)
  Protected *this._INPUT = AllocateStructure(_INPUT)
  With *this
    CONTENT_super(*this,?S_INPUT,?E_INPUT)
    \myTitle = BOARD::newTitle(title,LoadFont(#PB_Any,"arial",8,#PB_Font_HighQuality),$FF030303)
    \myIcon = BOARD::newIcon(gInputIcon,16,16)
    \myPOS\h = 16
    \myPOS\w = 16
    \_draw = @_INPUT_draw()
    \_post_event = @_INPUT_event()
    ProcedureReturn *this
  EndWith
EndProcedure
;}

DataSection
  S_INPUT:
  ; GETTERS
  Data.i @INPUT_getTitle()
  Data.i @INPUT_getIcon()
  ; SETTERS
  
  ; PUBLIC
  Data.i @INPUT_free()
  E_INPUT:
EndDataSection

DataSection
  ICON_INPUT:
  IncludeBinary "IMG\input.png"
  ICON_LINK:
  IncludeBinary "IMG\link.ani"
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 66
; FirstLine = 25
; Folding = f-0-
; EnableXP