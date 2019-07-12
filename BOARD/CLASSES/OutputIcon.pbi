; *************************************************************************
; AUTHOR         : MicrodevWeb
; DESIGNED WITH  : Pb 5.71
; PROJECT        : Board
; PACKAGE        : BOARD.pbi
; CLASS          : OutputIcon
; FILE           : OutputIcon.pbi
; DATE           : 2019/07/10
; *************************************************************************
Global gOutputIcon = CatchImage(#PB_Any,?ICON_OUTPUT)
;-* PRIVATE METHODS
Procedure _OUTPUT_hoverMe(*this._INPUT,mx,my)
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
Procedure _OUTPUT_draw(*this._OUTPUT,x,y,right.b = #False)
  With *this
    Protected xt,yt
    If Not right
      MovePathCursor(x,y)
      \myPOS\x = x
      \myPOS\y = y
      DrawVectorImage(ImageID(\myIcon\getImage()),255,\myIcon\getWidth(),\myIcon\getHeight())
      \myPOS\w = \myIcon\getWidth()
      \myPOS\h = \myIcon\getHeight()
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

Procedure _OUTPUT_event(*this._OUTPUT,*board._BOARD,mx,my)
  With *this
    Static clickOn.b
    Select EventType()
      Case #PB_EventType_MouseMove
        If _OUTPUT_hoverMe(*this,mx,my)
          SetGadgetAttribute(*board\idCanvas,#PB_Canvas_Cursor, #PB_Cursor_Cross)
          ProcedureReturn #True
        EndIf
      Case #PB_EventType_LeftButtonDown
        If _OUTPUT_hoverMe(*this,mx,my)
          If Not clickOn
            If Not *board\editedLink
              *board\editedLink = newLink(*this,0)
              clickOn = #True
            EndIf
          EndIf
          ProcedureReturn #True
        EndIf
      Case #PB_EventType_LeftButtonUp
        clickOn = #False
        If _OUTPUT_hoverMe(*this,mx,my)
          If *board\editedLink
            If Not *board\editedLink\getOutput()
              If *board\linkCallback
                If *board\linkCallback(*this,#True)
                  *board\editedLink\setOutput(*this)
                  ProcedureReturn  #True
                Else
                  ProcedureReturn  #True
                EndIf
              EndIf
            Else
              ProcedureReturn  #True
            EndIf
          EndIf
        EndIf
    EndSelect
  EndWith
EndProcedure
;}
;-* GETTERS METHODS
Procedure OUTPUT_getTitle(*this._OUTPUT)
  With *this
    ProcedureReturn \myTitle
  EndWith
EndProcedure

Procedure OUTPUT_getIcon(*this._OUTPUT)
  With *this
    ProcedureReturn \myIcon
  EndWith
EndProcedure

;}
;-* SETTERS METHODS

;}
;-* PUBLIC METHODS
Procedure OUTPUT_free(*this._OUTPUT)
  With *this
    \myIcon\free()
    \myTitle\free()
    FreeStructure(*this)
  EndWith
EndProcedure
;}
;-* CONSTRUCTOR
Procedure newOutputIcon(title.s)
  Protected *this._OUTPUT = AllocateStructure(_OUTPUT)
  With *this
    CONTENT_super(*this,?S_OUTPUT,?E_OUTPUT)
    \myTitle = BOARD::newTitle(title,LoadFont(#PB_Any,"arial",8,#PB_Font_HighQuality),$FF030303)
    \myIcon = BOARD::newIcon(gOutputIcon,16,16)
    \myPOS\h = 16
    \_draw = @_OUTPUT_draw()
    \_post_event = @_OUTPUT_event()
    ProcedureReturn *this
  EndWith
EndProcedure
;}

DataSection
  S_OUTPUT:
  ; GETTERS
  Data.i @OUTPUT_getTitle()
  Data.i @OUTPUT_getIcon()
  ; SETTERS
  
  ; PUBLIC
  Data.i @OUTPUT_free()
  E_OUTPUT:
EndDataSection

DataSection
  ICON_OUTPUT:
  IncludeBinary "IMG\output.png"
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 69
; FirstLine = 59
; Folding = -----
; EnableXP