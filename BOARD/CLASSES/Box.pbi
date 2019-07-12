; *************************************************************************
; AUTHOR         : MicrodevWeb
; DESIGNED WITH  : Pb 5.71
; PROJECT        : Board
; PACKAGE        : BOARD.pbi
; CLASS          : Box
; FILE           : Box.pbi
; DATE           : 2019/07/10
; *************************************************************************
;-* PRIVATE METHODS
Procedure _BOX_calcul_size(*this._BOX)
  With *this
    Protected yc,ycl,ycr
    VectorFont(FontID(\myTitle\font))
    Protected w = VectorTextWidth(\myTitle\title)
    Protected hi
    w + \myMargin\left + \myMargin\right
    If \leftIcon
      w + \leftIcon\width + \myMargin\left
    EndIf
    If \rightIcon
      w + \rightIcon\width + \myMargin\right
    EndIf
    Protected h = VectorTextHeight(\myTitle\title)
    If \leftIcon
      hi = \leftIcon\height
    EndIf
    If \rightIcon
      If hi < \rightIcon\height
        hi = \rightIcon\height
      EndIf
    EndIf
    If hi > h
      h = hi
    EndIf
    h + \myMargin\above + \myMargin\below
    ; look for height of content
    ForEach \myLeftContent()
      ycl + \myLeftContent()\myPOS\h + 10 
    Next
    If ycl >0
      ycl - 10 + \myMargin\above
    EndIf
    ForEach \myRightContent()
      ycr + \myRightContent()\myPOS\h + 10 
    Next
    If ycr > 0
      ycr - 10 + \myMargin\above
    EndIf
    If ycl > ycr 
      yc = ycl
    Else
      yc = ycr
    EndIf
    h + yc
    \myPos\w = w
    \myPos\h = h
  EndWith
EndProcedure

Procedure _BOX_hoverMe(*this._BOX,mx,my)
  With *this
    If gModeLink
      ProcedureReturn #False
    EndIf
    If mx >= \myPos\x And mx <= \myPos\x + \myPos\w
      If my >= \myPos\y And my <= \myPos\y + \myPos\h
        ProcedureReturn #True
      EndIf
    EndIf
    ProcedureReturn #False
  EndWith
EndProcedure

Procedure _BOX_hoverContent(*this._BOX,*board,mx,my)
  With *this
    ForEach \myLeftContent()
      If \myLeftContent()\_post_event(\myLeftContent(),*board,mx,my)
        ProcedureReturn #True
      EndIf
    Next
    ForEach \myRightContent()
      If \myRightContent()\_post_event(\myRightContent(),*board,mx,my)
        ProcedureReturn #True
      EndIf
    Next
    ProcedureReturn #False
  EndWith
EndProcedure

;}
;-* PROTECTED METHODS
Procedure BOX_draw(*this._BOX,*board._BOARD)
  With *this
    ; we calculate the size
    _BOX_calcul_size(*this)
    ; we set colors
    \myColor\_set(\myColor,0,\myPos\x - GetGadgetState(*board\idScrollH),\myPos\y - GetGadgetState(*board\idScrollV),\myPos\w,\myPos\h)
    ; we draw the box
    Protected xb,yb
    xb = \myPos\x - GetGadgetState(*board\idScrollH)
    yb = \myPos\y - GetGadgetState(*board\idScrollV)
    AddPathBox(xb,yb,\myPos\w,\myPos\h)
    FillPath()
    If \selected
      VectorSourceColor(\selectedColor)
      AddPathBox(xb,yb,\myPos\w,\myPos\h)
      StrokePath(2)
    EndIf
    Protected xt = \myPos\x+\myMargin\left,yt = \myPos\y + (VectorTextHeight(\myTitle\title) / 2)
    xt - GetGadgetState(*board\idScrollH)
    Protected yyt,x
    Protected xil,yil,xir,yir,y = \myPos\y + (\myMargin\above * 2) ,yy = VectorTextHeight(\myTitle\title)
    ; we draw the left icon
    If \leftIcon
      xil = \myPos\x + \myMargin\left
      yil = \myPos\y + \myMargin\above
      ; considere sroll bar decalage
      xil - GetGadgetState(*board\idScrollH)
      yil - GetGadgetState(*board\idScrollV)
      MovePathCursor(xil,yil)
      DrawVectorImage(ImageID(\leftIcon\image),255,\leftIcon\width,\leftIcon\height)
      xt + \leftIcon\width + \myMargin\left
      yyt = (\leftIcon\height / 2)
      If \leftIcon\height > yy
        yy = \leftIcon\height
      EndIf
    EndIf
    If \rightIcon
      xir = \myPos\x + \myPos\w - \myMargin\right - \rightIcon\width
      yir = \myPos\y + \myMargin\above
      ; considere sroll bar decalage
      xir - GetGadgetState(*board\idScrollH)
      yir - GetGadgetState(*board\idScrollV)
      MovePathCursor(xir,yir)
      DrawVectorImage(ImageID(\rightIcon\image),255,\rightIcon\width,\rightIcon\height)
      If (\rightIcon\height / 2) > yyt
        yyt = (\rightIcon\height / 2)
      EndIf
      If \rightIcon\height > yy
        yy = \rightIcon\height
      EndIf
    EndIf
    yt + yyt
    yt - GetGadgetState(*board\idScrollV)
    ; we draw the title
    MovePathCursor(xt,yt)
    VectorSourceColor(\myTitle\color)
    DrawVectorText(\myTitle\title)
    ; we consider scroll bar
    x = \myPos\x + \myMargin\left
    x - GetGadgetState(*board\idScrollH)
    y - GetGadgetState(*board\idScrollV)
    y + yy
    Protected y2 = y
    ; we draw the left contents
    ForEach \myLeftContent()
      \myLeftContent()\_draw(\myLeftContent(),x,y)
      y + \myLeftContent()\myPOS\h + 10
    Next
    ForEach \myRightContent()
      \myRightContent()\_draw(\myRightContent(),\myPos\x - GetGadgetState(*board\idScrollH) +\myPos\w - \myMargin\right,y2,#True)
      y2 + \myRightContent()\myPOS\h + 10
    Next
  EndWith
EndProcedure

Procedure BOX_event(*this._BOX,*board._BOARD,mx = 0,my = 0)
  With *this
    Static clickOn.b
    Static oldMx,oldMy,oldX,oldY
    Static redraw.b
    If _BOX_hoverContent(*this,*board,mx,my)
      ProcedureReturn #True
    EndIf  

    Select EventType()
      Case #PB_EventType_MouseMove
        If _BOX_hoverMe(*this,mx,my)
          ; if clikOn we're moving the box
          If clickOn
            Protected dx = mx - oldMx
            Protected dy = my - oldMy
            Protected nx,ny
            nx = oldX + dx
            ny = oldY + dy
            
            Define *g._GRID =  *board\myGrid
            *g\manageMagnet(*g,*board,@nx,@ny)
            \myPos\x =  nx
            \myPos\y =  ny
            *board\drawMask(*board,\myPos\x,\myPos\y,\myPos\w,\myPos\h,\displaceringColor)
            *board\manageScroll(*board)
            redraw = #True
            SetGadgetAttribute(*board\idCanvas,#PB_Canvas_Cursor,#PB_Cursor_Arrows)
          Else
            SetGadgetAttribute(*board\idCanvas,#PB_Canvas_Cursor,#PB_Cursor_Hand)
          EndIf
          ProcedureReturn #True
        EndIf
      Case #PB_EventType_LeftButtonDown
        If Not clickOn
          If _BOX_hoverMe(*this,mx,my)
            oldMx = mx
            oldMy = my
            oldX = \myPos\x 
            oldY = \myPos\y 
            clickOn = #True
            SetGadgetAttribute(*board\idCanvas,#PB_Canvas_Cursor,#PB_Cursor_Arrows)
            *board\deselectAll(*board)
            \selected = #True
            Define b.BOARD::Boars = *board
            b\build()
            If \selectCallback
              \selectCallback(*this)
            EndIf
            ProcedureReturn #True
          EndIf
        EndIf
      Case #PB_EventType_LeftButtonUp
        clickOn = #False
        If redraw
          Define b.BOARD::Boars = *board
          b\build()
        EndIf
    EndSelect
    ProcedureReturn #False
  EndWith
EndProcedure
;}
;-* GETTERS METHODS
Procedure BOX_getTitle(*this._BOX)
  With *this
    ProcedureReturn \myTitle
  EndWith
EndProcedure

Procedure BOX_getLeftIcon(*this._BOX)
  With *this
    ProcedureReturn \leftIcon
  EndWith
EndProcedure

Procedure BOX_getRightIcon(*this._BOX)
  With *this
    ProcedureReturn \rightIcon
  EndWith
EndProcedure

Procedure BOX_getMargins(*this._BOX)
  With *this
    ProcedureReturn \myMargin
  EndWith
EndProcedure
;}
;-* SETTERS METHODS
Procedure BOX_setLeftIcon(*this._BOX,*leftIcon)
  With *this
     \leftIcon = *leftIcon
  EndWith
EndProcedure

Procedure BOX_setRightIcon(*this._BOX,*rightIcon)
  With *this
     \rightIcon = *rightIcon
  EndWith
EndProcedure
;}
;-* PUBLIC METHODS
Procedure BOX_free(*this._BOX)
  With *this
    Define i.BOARD::Icon = \leftIcon
    i\free()
    i = \rightIcon
    i\free()
    Define t.BOARD::Title = \myTitle
    t\free()
    FreeStructure(*this)
  EndWith
EndProcedure

Procedure BOX_addLeftContent(*this._BOX,*content)
  With *this
    AddElement(\myLeftContent())
    \myLeftContent() = *content
    ProcedureReturn  *content
  EndWith
EndProcedure

Procedure BOX_addRightContent(*this._BOX,*content)
  With *this
    AddElement(\myRightContent())
    \myRightContent() = *content
    ProcedureReturn *content
  EndWith
EndProcedure
;}
;-* CONSTRUCTOR
Procedure newBox(title.s,*color,x,y)
  Protected *this._BOX = AllocateStructure(_BOX)
  With *this
    FORM_super(*this,?S_BOX,?E_BOX,*color,$FF00EEEE,x,y)
    \myTitle = BOARD::newTitle(title,LoadFont(#PB_Any,"arial",11,#PB_Font_HighQuality),$FF171717)
    \_draw = @BOX_draw()
    \_post_event = @BOX_event()
    \myMargin = newMargins(10,10,10,10)
    \displaceringColor = $7800EEEE
    ProcedureReturn  *this
  EndWith
EndProcedure
;}

DataSection
  S_BOX:
  ; GETTERS
  Data.i @BOX_getTitle()
  Data.i @BOX_getLeftIcon()
  Data.i @BOX_getRightIcon()
  Data.i @BOX_getMargins()
  ; SETTERS
  Data.i @BOX_setLeftIcon()
  Data.i @BOX_setRightIcon()
  ; PUBLIC
  Data.i @BOX_free()
  Data.i @BOX_addLeftContent()
  Data.i @BOX_addRightContent()
  E_BOX:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 63
; FirstLine = 8
; Folding = x-40-PA0-
; EnableXP