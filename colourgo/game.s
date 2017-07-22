;
;  main.s
;  colourgo
;
;  Created by Jeremy Rand on 2017-07-19.
;  Copyright © 2017 Jeremy Rand. All rights reserved.
;


    .export _game

    .import _vblWait

    .include "apple2.inc"


MAXY=191
MAXXBYTE=40
MAXX=280

ZPADDR0=<$80
ZPADDR1=<$82
ZPADDR2=<$84
ZPADDR3=<$86
ZPADDR4=<$88
ZPADDR5=<$8a
ZPADDR6=<$8c
ZPADDR7=<$8e

LEVELADDR=<$90

COL_BLACK=0
COL_VIOLET=1
COL_GREEN=2
COL_WHITE=3

CHAR_HEIGHT=10
NUM_CHAR_BITMAPS=3
CHAR_MAX_JUMPS=2
CHAR_XPOS=3

CHAR_STATE_NONE=0
CHAR_STATE_JUMPING=1
CHAR_STATE_FALLING=2

JUMP_SPEED=5
GRAVITY=64

GRID_YPOS=140
GRID_HEIGHT=5
GRID_MAX_SHIFT=7

LEVEL_STRUCT_SIZE=5

LINE0 = $2000
LINE1 = LINE0 + 1024
LINE2 = LINE1 + 1024
LINE3 = LINE2 + 1024
LINE4 = LINE3 + 1024
LINE5 = LINE4 + 1024
LINE6 = LINE5 + 1024
LINE7 = LINE6 + 1024
LINE8 = LINE0 + 128
LINE9 = LINE8 + 1024
LINE10 = LINE9 + 1024
LINE11 = LINE10 + 1024
LINE12 = LINE11 + 1024
LINE13 = LINE12 + 1024
LINE14 = LINE13 + 1024
LINE15 = LINE14 + 1024
LINE16 = LINE8 + 128
LINE17 = LINE16 + 1024
LINE18 = LINE17 + 1024
LINE19 = LINE18 + 1024
LINE20 = LINE19 + 1024
LINE21 = LINE20 + 1024
LINE22 = LINE21 + 1024
LINE23 = LINE22 + 1024
LINE24 = LINE16 + 128
LINE25 = LINE24 + 1024
LINE26 = LINE25 + 1024
LINE27 = LINE26 + 1024
LINE28 = LINE27 + 1024
LINE29 = LINE28 + 1024
LINE30 = LINE29 + 1024
LINE31 = LINE30 + 1024
LINE32 = LINE24 + 128
LINE33 = LINE32 + 1024
LINE34 = LINE33 + 1024
LINE35 = LINE34 + 1024
LINE36 = LINE35 + 1024
LINE37 = LINE36 + 1024
LINE38 = LINE37 + 1024
LINE39 = LINE38 + 1024
LINE40 = LINE32 + 128
LINE41 = LINE40 + 1024
LINE42 = LINE41 + 1024
LINE43 = LINE42 + 1024
LINE44 = LINE43 + 1024
LINE45 = LINE44 + 1024
LINE46 = LINE45 + 1024
LINE47 = LINE46 + 1024
LINE48 = LINE40 + 128
LINE49 = LINE48 + 1024
LINE50 = LINE49 + 1024
LINE51 = LINE50 + 1024
LINE52 = LINE51 + 1024
LINE53 = LINE52 + 1024
LINE54 = LINE53 + 1024
LINE55 = LINE54 + 1024
LINE56 = LINE48 + 128
LINE57 = LINE56 + 1024
LINE58 = LINE57 + 1024
LINE59 = LINE58 + 1024
LINE60 = LINE59 + 1024
LINE61 = LINE60 + 1024
LINE62 = LINE61 + 1024
LINE63 = LINE62 + 1024
LINE64 = LINE0 + 40
LINE65 = LINE64 + 1024
LINE66 = LINE65 + 1024
LINE67 = LINE66 + 1024
LINE68 = LINE67 + 1024
LINE69 = LINE68 + 1024
LINE70 = LINE69 + 1024
LINE71 = LINE70 + 1024
LINE72 = LINE64 + 128
LINE73 = LINE72 + 1024
LINE74 = LINE73 + 1024
LINE75 = LINE74 + 1024
LINE76 = LINE75 + 1024
LINE77 = LINE76 + 1024
LINE78 = LINE77 + 1024
LINE79 = LINE78 + 1024
LINE80 = LINE72 + 128
LINE81 = LINE80 + 1024
LINE82 = LINE81 + 1024
LINE83 = LINE82 + 1024
LINE84 = LINE83 + 1024
LINE85 = LINE84 + 1024
LINE86 = LINE85 + 1024
LINE87 = LINE86 + 1024
LINE88 = LINE80 + 128
LINE89 = LINE88 + 1024
LINE90 = LINE89 + 1024
LINE91 = LINE90 + 1024
LINE92 = LINE91 + 1024
LINE93 = LINE92 + 1024
LINE94 = LINE93 + 1024
LINE95 = LINE94 + 1024
LINE96 = LINE88 + 128
LINE97 = LINE96 + 1024
LINE98 = LINE97 + 1024
LINE99 = LINE98 + 1024
LINE100 = LINE99 + 1024
LINE101 = LINE100 + 1024
LINE102 = LINE101 + 1024
LINE103 = LINE102 + 1024
LINE104 = LINE96 + 128
LINE105 = LINE104 + 1024
LINE106 = LINE105 + 1024
LINE107 = LINE106 + 1024
LINE108 = LINE107 + 1024
LINE109 = LINE108 + 1024
LINE110 = LINE109 + 1024
LINE111 = LINE110 + 1024
LINE112 = LINE104 + 128
LINE113 = LINE112 + 1024
LINE114 = LINE113 + 1024
LINE115 = LINE114 + 1024
LINE116 = LINE115 + 1024
LINE117 = LINE116 + 1024
LINE118 = LINE117 + 1024
LINE119 = LINE118 + 1024
LINE120 = LINE112 + 128
LINE121 = LINE120 + 1024
LINE122 = LINE121 + 1024
LINE123 = LINE122 + 1024
LINE124 = LINE123 + 1024
LINE125 = LINE124 + 1024
LINE126 = LINE125 + 1024
LINE127 = LINE126 + 1024
LINE128 = LINE64 + 40
LINE129 = LINE128 + 1024
LINE130 = LINE129 + 1024
LINE131 = LINE130 + 1024
LINE132 = LINE131 + 1024
LINE133 = LINE132 + 1024
LINE134 = LINE133 + 1024
LINE135 = LINE134 + 1024
LINE136 = LINE128 + 128
LINE137 = LINE136 + 1024
LINE138 = LINE137 + 1024
LINE139 = LINE138 + 1024
LINE140 = LINE139 + 1024
LINE141 = LINE140 + 1024
LINE142 = LINE141 + 1024
LINE143 = LINE142 + 1024
LINE144 = LINE136 + 128
LINE145 = LINE144 + 1024
LINE146 = LINE145 + 1024
LINE147 = LINE146 + 1024
LINE148 = LINE147 + 1024
LINE149 = LINE148 + 1024
LINE150 = LINE149 + 1024
LINE151 = LINE150 + 1024
LINE152 = LINE144 + 128
LINE153 = LINE152 + 1024
LINE154 = LINE153 + 1024
LINE155 = LINE154 + 1024
LINE156 = LINE155 + 1024
LINE157 = LINE156 + 1024
LINE158 = LINE157 + 1024
LINE159 = LINE158 + 1024
LINE160 = LINE152 + 128
LINE161 = LINE160 + 1024
LINE162 = LINE161 + 1024
LINE163 = LINE162 + 1024
LINE164 = LINE163 + 1024
LINE165 = LINE164 + 1024
LINE166 = LINE165 + 1024
LINE167 = LINE166 + 1024
LINE168 = LINE160 + 128
LINE169 = LINE168 + 1024
LINE170 = LINE169 + 1024
LINE171 = LINE170 + 1024
LINE172 = LINE171 + 1024
LINE173 = LINE172 + 1024
LINE174 = LINE173 + 1024
LINE175 = LINE174 + 1024
LINE176 = LINE168 + 128
LINE177 = LINE176 + 1024
LINE178 = LINE177 + 1024
LINE179 = LINE178 + 1024
LINE180 = LINE179 + 1024
LINE181 = LINE180 + 1024
LINE182 = LINE181 + 1024
LINE183 = LINE182 + 1024
LINE184 = LINE176 + 128
LINE185 = LINE184 + 1024
LINE186 = LINE185 + 1024
LINE187 = LINE186 + 1024
LINE188 = LINE187 + 1024
LINE189 = LINE188 + 1024
LINE190 = LINE189 + 1024
LINE191 = LINE190 + 1024


.CODE

.proc _game

; Set up hires screen
    jsr clearScreen
    jsr setLevelAddr

@nextframe:
    jsr _vblWait

    jsr drawCharacter
    jsr drawGrids

    jsr updateGrid
    jsr updateCharacter

    lda shouldQuit
    beq @nextframe

    lda TXTSET

    rts

.endproc


.proc resetGame
    lda #0
    sta characterBitmap
    sta characterY
    sta characterOldY
    sta characterNumJumps
    sta characterYSpeed
    sta characterYSpeedFrac

    sta gridXShift
    sta gridXPos

    lda #COL_VIOLET
    sta characterColour

    lda #CHAR_HEIGHT
    sta characterYBottom
    sta characterOldYBottom

    lda #CHAR_STATE_FALLING
    sta characterState

    jmp setLevelAddr
.endproc


.proc setLevelAddr
    ldx level
    lda levelsLo,x
    sta LEVELADDR
    lda levelsHi,x
    sta LEVELADDR+1
    bne @notAtTheEnd

;   If the high byte of the level address is 0, then there are no more levels
;   For now, just loop back to level 0.  TODO - Something better.
    sta level
    jsr setLevelAddr

@notAtTheEnd:
    rts
.endproc


.proc gameOver

    jsr drawCharacter

@loop:
    lda KBD
    bpl @loop
    ldx KBDSTRB

    cmp #$9b    ; Compare to Escape
    beq @quit
    cmp #$d1    ; Compare to 'Q'
    beq @quit
    cmp #$f1    ; Compare to 'q'
    beq @quit
    jsr resetGame
    jmp clearScreen

@quit:
    lda #$01
    sta shouldQuit
    rts
.endproc


.proc levelWon
    lda #COL_WHITE
    sta characterColour
    inc level

; This is weird but at this point, all of the logic we
; need to progress to the next level is in gameOver...
    jmp gameOver
.endproc


.proc updateCharacter

; Save the old character position so it can be erased

    jsr updateCharacterState
    jsr updateCharacterPos
    jsr updateCharacterBitmap
    jsr updateCharacterColour

    rts

.endproc


.proc updateCharacterState

    lda BUTN1
    bpl @buttonUp
    lda #$01
    jmp @buttonDown
@buttonUp:
    lda #$00
@buttonDown:
    cmp lastButtonState
    beq @return             ; No change in button state so exit
    sta lastButtonState

    lda characterState
    cmp #CHAR_STATE_JUMPING
    beq @jumping

    lda lastButtonState
    beq @return             ; If button is not down, exit
    ldx characterNumJumps
    cpx #CHAR_MAX_JUMPS
    beq @return             ; If we have reached max jumps, exit
    inx
    stx characterNumJumps
    lda #CHAR_STATE_JUMPING
    sta characterState
    lda #JUMP_SPEED
    sta characterYSpeed
    lda #0
    sta characterYSpeedFrac
    rts

@jumping:
    lda lastButtonState
    bne @return             ; If the button is still pressed, exit
    lda #CHAR_STATE_FALLING
    sta characterState
    lda #0
    sta characterYSpeed
    sta characterYSpeedFrac

@return:
    rts

; Local
lastButtonState: .BYTE $00

.endproc


.proc updateCharacterPos

    lda characterY
    sta characterOldY
    lda characterYBottom
    sta characterOldYBottom

    lda #0
    sta ZPADDR6+1

    lda characterState
    cmp #CHAR_STATE_NONE
    beq @stateNone
    cmp #CHAR_STATE_JUMPING
    beq @stateJumping
    jmp updateCharacterPosFalling

@stateNone:
    jmp updateCharacterPosNone

@stateJumping:
    jmp updateCharacterPosJumping
.endproc


.proc nextGridAtCharacter
    lda ZPADDR6+1
    bne @nextGrid

    lda LEVELADDR
    sta ZPADDR6
    lda LEVELADDR+1
    sta ZPADDR6+1

    lda #$0
    sta gridLeft

    lda gridXPos
    clc
    adc #MAXXBYTE
    sta screenRight

    ldy #$1
    lda (ZPADDR6),y
    beq @noneFound

@gridLoop:
    lda gridLeft
    cmp screenRight
    bcs @noneFound
    ldy #$1
    clc
    adc (ZPADDR6),y
; If we got a carry, that means the width of the next grid plus
; the grid left overflowed 256.  If that happens we are definitely
; not left of gridXPos.  We just need to subtract gridXPos to get
; onto screen coords.
    bcs @overflow
    cmp gridXPos
    bcc @nextGrid
    sec
@overflow:
    sbc gridXPos
    tax
    lda gridXShift
    beq @skipRightAdjust
    cmp #3
    bcs @skipRightAdjust
    dex
    dex
@skipRightAdjust:
    cpx #MAXXBYTE
    bcc @rightIsNotOffScreen
    ldx #MAXXBYTE
@rightIsNotOffScreen:
    stx gridScreenRight

    lda gridLeft
    sec
    sbc gridXPos
    bpl @leftIsOnScreen
    lda #$0
    tax
    jmp @skipLeftAdjust

@leftIsOnScreen:
    tax
    lda gridXShift
    beq @skipLeftAdjust
    cmp #4
    bcs @skipLeftAdjust
    dex
    dex

@skipLeftAdjust:
    txa
    cmp #CHAR_XPOS+1
    bcs @noneFound

    lda gridScreenRight
    cmp #CHAR_XPOS
    bcs @foundOne

@nextGrid:
    lda ZPADDR6
    clc
    adc #LEVEL_STRUCT_SIZE
    bcc @doNotIncHiByte
    inc ZPADDR6+1
@doNotIncHiByte:
    sta ZPADDR6

    ldy #$1
    lda (ZPADDR6),y
    beq @noneFound

    ldy #$0
    lda gridLeft
    clc
    adc (ZPADDR6),y
    cmp screenRight
    beq @L2
    bcs @noneFound
@L2:
    sta gridLeft
    jmp @gridLoop

@noneFound:
    sec
    rts

@foundOne:
    clc
    rts

; Locals
screenRight: .BYTE $00
gridLeft:    .BYTE $00
.endproc


.proc updateCharacterPosNone

@loop:
    jsr nextGridAtCharacter
    bcs @floorGone
    ldy #2
    lda (ZPADDR6),y
    cmp characterYBottom
    bne @loop

    ldy #4
    lda (ZPADDR6),y
    cmp characterColour
    beq @checkForWin
    jmp gameOver

@checkForWin:
    ldy #LEVEL_STRUCT_SIZE+1
    lda (ZPADDR6),y
    bne @return
    jmp levelWon

@floorGone:
    lda #CHAR_STATE_FALLING
    sta characterState
    lda #0
    sta characterYSpeed
    sta characterYSpeedFrac

@return:
    rts
.endproc


.proc updateCharacterPosJumping

; For jumping, we need to calculate the top first and check
; for collisions

    lda characterY
    sec
    sbc characterYSpeed
    bcc @hitCeiling
    sta characterY

@loop:
    jsr nextGridAtCharacter
    bcs @didNotHitHead

    ldy #2
    lda (ZPADDR6),y
    sta gridTop

    ldy #3
    lda (ZPADDR6),y
    sta gridBottom

    cmp characterOldY
    bcc @wasBelowToStart
    jmp @loop

@wasBelowToStart:
    cmp characterY
    bcc @loop
    jmp @startFalling

@hitCeiling:
    lda #$0
    jmp @startFalling

@dropToBottomOfGrid:
    lda gridBottom

@startFalling:
    sta characterY
    lda #0
    sta characterYSpeed
    sta characterYSpeedFrac
    sta characterNumJumps
    lda #CHAR_STATE_FALLING
    sta characterState
    jmp @updateYBottom

@didNotHitHead:
    lda characterYSpeedFrac
    clc
    adc #GRAVITY
    sta characterYSpeedFrac
    bcc @updateYBottom
    dec characterYSpeed
    bne @updateYBottom
    lda #CHAR_STATE_FALLING
    sta characterState

@updateYBottom:  ; Need to calculate characterYBottom now from characterY
    lda characterY
    clc
    adc #CHAR_HEIGHT
    sta characterYBottom
    rts

; Locals
gridTop:       .BYTE $00
gridBottom:    .BYTE $00

.endproc


.proc updateCharacterPosFalling

; For falling, we need to calculate the bottom first and check
; for collisions
    lda characterYBottom
    clc
    adc characterYSpeed
    sta characterYBottom
    cmp #MAXY
    bcc @loop

    lda #MAXY
    sta characterYBottom
    sec
    sbc #CHAR_HEIGHT
    sta characterY
    jsr gameOver
    rts

@loop:
    jsr nextGridAtCharacter
    bcs @didNotLand

    ldy #3
    lda (ZPADDR6),y
    sta gridBottom

    ldy #2
    lda (ZPADDR6),y

    cmp characterOldYBottom
    bcs @wasAboveToStart

    lda characterYBottom
    sec
    sbc #CHAR_HEIGHT
    cmp gridBottom
    bcc @dropToBottomOfGrid
    jmp @loop

@wasAboveToStart:
    cmp characterYBottom
    beq @L1
    bcs @loop
@L1:
    sta characterYBottom
    lda #0
    sta characterYSpeed
    sta characterYSpeedFrac
    sta characterNumJumps
    lda #CHAR_STATE_NONE
    sta characterState
    jmp @updateY

@dropToBottomOfGrid:
    lda gridBottom
    sec
    sbc #CHAR_HEIGHT
    sta characterYBottom

@didNotLand:
    lda characterYSpeedFrac
    clc
    adc #GRAVITY
    sta characterYSpeedFrac
    bcc @updateY
    inc characterYSpeed

@updateY:  ; Need to calculate characterY now from characterYBottom
    lda characterYBottom
    sec
    sbc #CHAR_HEIGHT
    sta characterY
    rts

; Locals
gridBottom:          .BYTE $00

.endproc


.proc updateCharacterBitmap

    ldx characterBitmap
    inx
    cpx #NUM_CHAR_BITMAPS
    bne @noBitmapWrap
    ldx #0
@noBitmapWrap:
    stx characterBitmap
    rts

.endproc


.proc updateCharacterColour
    lda KBD
    bpl @return
    ldx KBDSTRB
    cmp #$9b    ; Compare to Escape
    beq @quit
    cmp #$d1    ; Compare to 'Q'
    beq @quit
    cmp #$f1    ; Compare to 'q'
    beq @quit

    lda characterColour
    cmp #COL_VIOLET
    beq @changeToGreen
    lda #COL_VIOLET
    sta characterColour
    rts

@changeToGreen:
    lda #COL_GREEN
    sta characterColour
    rts

@quit:
    lda #$01
    sta shouldQuit

@return:    ; No key pressed
    rts
.endproc


.proc drawCharacter
    ldx characterColour
    lda colourEvenLookup,x
    sta evenVal
    lda colourOddLookup,x
    sta oddVal

    ldx characterBitmap
    lda characterBitmapLo,x
    sta ZPADDR1
    lda characterBitmapHi,x
    sta ZPADDR1+1

    ldx characterOldY
    cpx characterY
    beq @doNotEraseOld

@oldEraseLoop:
    lda loAddrs,x
    sta ZPADDR0
    lda page1HiAddrs,x
    sta ZPADDR0+1

    ldy #CHAR_XPOS
    lda #0
    sta (ZPADDR0),y
    iny
    sta (ZPADDR0),y

    inx
    cpx characterOldYBottom
    bne @oldEraseLoop

@doNotEraseOld:
    ldy characterY
    ldx #0
@drawLoop:
    lda loAddrs,y
    sta ZPADDR0
    lda page1HiAddrs,y
    sta ZPADDR0+1
    sty yPos

    ldy #CHAR_XPOS
    lda oddVal
    and (ZPADDR1,x)
    sta (ZPADDR0),y
    inc ZPADDR1
    bne @doNotIncHiByte1
    inc ZPADDR1+1

@doNotIncHiByte1:
    iny
    lda evenVal
    and (ZPADDR1,x)
    sta (ZPADDR0),y
    inc ZPADDR1
    bne @doNotIncHiByte2
    inc ZPADDR1+1

@doNotIncHiByte2:
    ldy yPos
    iny
    cpy characterYBottom
    bne @drawLoop

    rts

; Locals
evenVal: .BYTE $00
oddVal:  .BYTE $00
yPos:    .BYTE $00

.endproc


.proc updateGrid
    dec gridXShift
    beq @moveGridPos
    bpl @return
    ldx #GRID_MAX_SHIFT-1
    stx gridXShift
    rts

@moveGridPos:
    inc gridXPos
    inc gridXPos

@loop:
    ldy #$1
    lda gridXPos
    cmp (LEVELADDR),y
    bcc @return

; At this point, we know that this grid is not visible
; Check to see if the start of the next grid is left justified
; or off screen.
    ldy #LEVEL_STRUCT_SIZE
    cmp (LEVELADDR),y
    bcc @return

; At this point, we know that the gridXPos is at the start of
; the next grid or maybe past the start.  Move the LEVELADDR
; pointer forward to this grid and update gridXPos to be
; relative to this grid.
    lda LEVELADDR
    clc
    adc #LEVEL_STRUCT_SIZE
    bcc @doNotIncHiByte
    inc LEVELADDR+1
@doNotIncHiByte:
    sta LEVELADDR
    ldy #$0
    lda gridXPos
    sec
    sbc (LEVELADDR),y
    sta gridXPos

; We should check to see if this new grid is visible and if not,
; adjust the grid position again.
    jmp @loop

@return:
    rts
.endproc


.proc drawGrids
    lda LEVELADDR
    sta ZPADDR6
    lda LEVELADDR+1
    sta ZPADDR6+1

    lda #$0
    sta gridLeft

    lda gridXPos
    clc
    adc #MAXXBYTE
    sta screenRight

    ldy #$1
    lda (ZPADDR6),y
    bne @gridLoop
    rts

@gridLoop:
    lda gridLeft
    cmp screenRight
    bcs @return
    ldy #$1
    clc
    adc (ZPADDR6),y
; If we got a carry, that means the width of the next grid plus
; the grid left overflowed 256.  If that happens we are definitely
; not left of gridXPos.  We just need to subtract gridXPos to get
; onto screen coords.
    bcs @overflow
    cmp gridXPos
    bcc @nextGrid
    sec
@overflow:
    sbc gridXPos
    tax

; Now depending on the X shift, we need to stop drawing the
; body of the grid and fill in the right end cap.  We need
; to decrement the right boundary N times according to this
; chart:
;     Shift 0 - 0 decrements
;     Shift 1 - 2 decrements
;     Shift 2 - 2 decrements
;     Shift 3 - 1 decrement
;     Shift 4 - 1 decrement
;     Shift 5 - 1 decrement
;     Shift 6 - 1 decrement
;
; Another special case, for a situation where the gridRight
; is 0 so the grid and the shift is 0 or 6, that means the
; grid is coming off the screen.  We need to do no decrement
; and draw the grid to clear the cap.
    lda gridXShift
    beq @L1
    cpx #$0
    beq @gridRightZeroSpecialCase
    dex
    cmp #$3
    bcs @L1
    dex
    jmp @L1
@gridRightZeroSpecialCase:
    cmp #$6
    bne @nextGrid
@L1:
    cpx #MAXXBYTE
    bcc @rightIsNotOffScreen
    ldx #MAXXBYTE
@rightIsNotOffScreen:
    stx gridScreenRight

    lda gridLeft
    sec
    sbc gridXPos
    bpl @leftIsOnScreen
    lda #$0
@leftIsOnScreen:
    sta gridScreenLeft

    jsr drawGrid

;@debugLoop:
;   lda KBD
;   bpl @debugLoop
;   lda KBDSTRB

@nextGrid:
    lda ZPADDR6
    clc
    adc #LEVEL_STRUCT_SIZE
    bcc @doNotIncHiByte
    inc ZPADDR6+1
@doNotIncHiByte:
    sta ZPADDR6

    ldy #$1
    lda (ZPADDR6),y
    beq @return

    ldy #$0
    lda gridLeft
    clc
    adc (ZPADDR6),y
    cmp screenRight
    beq @L2
    bcs @return
@L2:
    sta gridLeft
    jmp @gridLoop

@return:
    rts

; Locals
screenRight: .BYTE $00
gridLeft:    .BYTE $00

.endproc


.proc drawGrid
    ldy #$2
    lda (ZPADDR6),y
    tay
    lda loAddrs,y
    sta ZPADDR0
    lda page1HiAddrs,y
    sta ZPADDR0+1

    iny
    lda loAddrs,y
    sta ZPADDR1
    lda page1HiAddrs,y
    sta ZPADDR1+1

    iny
    lda loAddrs,y
    sta ZPADDR2
    lda page1HiAddrs,y
    sta ZPADDR2+1

    iny
    lda loAddrs,y
    sta ZPADDR3
    lda page1HiAddrs,y
    sta ZPADDR3+1

    iny
    lda loAddrs,y
    sta ZPADDR4
    lda page1HiAddrs,y
    sta ZPADDR4+1

    iny
    lda loAddrs,y
    sta ZPADDR5
    lda page1HiAddrs,y
    sta ZPADDR5+1

    ldx gridXShift
    ldy #$4
    lda (ZPADDR6),y
    tay
    lda colourEvenLookup,y
    sta evenVal
    and evenGrid,x
    sta evenGridVal
    lda colourOddLookup,y
    sta oddVal
    and oddGrid,x
    sta oddGridVal

    ldy #LEVEL_STRUCT_SIZE+1
    lda (ZPADDR6),y
    bne @notLastGrid
    lda evenVal
    sta evenGridVal
    lda oddVal
    sta oddGridVal

@notLastGrid:
    lda evenGridRight,x
    and evenVal
    sta evenRightCap
    lda oddGridRight,x
    and oddVal
    sta oddRightCap

    ldy gridScreenLeft
    beq @L1
    cpx #$0
    beq @L1
    jmp @L2
@L1:
    jmp @nextGridComponent
; Draw the left cap

@L2:
    lda evenGridLeft,x
    and evenVal
    sta evenLeftCap
    lda evenGridLeft,x
    eor #$ff
    sta evenLeftMask

    lda oddGridLeft,x
    and oddVal
    sta oddLeftCap
    lda oddGridLeft,x
    eor #$ff
    sta oddLeftMask

    dey

    tya
    and #$01
    bne @leftCapOdd1

    lda evenLeftCap
    and evenGridVal
    tax
    lda evenLeftMask
    and (ZPADDR0),y
    ora evenLeftCap
    jmp @nextLeftCapComponent

@leftCapOdd1:
    lda oddLeftCap
    and oddGridVal
    tax
    lda oddLeftMask
    and (ZPADDR0),y
    ora oddLeftCap
    ldx oddGridVal

@nextLeftCapComponent:
    jsr drawGridComponent
    dey
    bmi @drawBodyComponents

    tya
    and #$01
    bne @leftCapOdd2

    lda evenLeftCap
    and evenGridVal
    tax
    lda evenLeftMask
    and (ZPADDR0),y
    ora evenLeftCap
    jsr drawGridComponent
    jmp @drawBodyComponents

@leftCapOdd2:
    lda oddLeftCap
    and oddGridVal
    tax
    lda oddLeftMask
    and (ZPADDR0),y
    ora oddLeftCap
    jsr drawGridComponent

@drawBodyComponents:
    ldy gridScreenLeft
@nextGridComponent:
    cpy gridScreenRight
    beq @lastGridComponent
    tya
    and #$01
    bne @bodyOdd

    lda evenVal
    ldx evenGridVal
    jmp @drawComponent

@bodyOdd:
    lda oddVal
    ldx oddGridVal

@drawComponent:
    jsr drawGridComponent
    iny
    jmp @nextGridComponent

@lastGridComponent:
    cpy #MAXXBYTE
    beq @return

    tya
    and #$01
    bne @rightCapOdd1

    lda evenGridVal
    and evenRightCap
    tax
    lda evenRightCap
    jmp @nextRightCapComponent

@rightCapOdd1:
    lda oddGridVal
    and oddRightCap
    tax
    lda oddRightCap

@nextRightCapComponent:
    jsr drawGridComponent

    iny
    cpy #MAXXBYTE
    beq @return

    lda #$00
    tax
    jsr drawGridComponent

@return:
    rts

; Locals
evenVal:      .BYTE $00
oddVal:       .BYTE $00
evenGridVal:  .BYTE $00
oddGridVal:   .BYTE $00
evenLeftCap:  .BYTE $00
oddLeftCap:   .BYTE $00
evenLeftMask: .BYTE $00
oddLeftMask:  .BYTE $00
evenRightCap: .BYTE $00
oddRightCap:  .BYTE $00
.endproc


.proc drawGridComponent
    sta (ZPADDR0),y
    sta (ZPADDR5),y
    txa
    sta (ZPADDR1),y
    sta (ZPADDR2),y
    sta (ZPADDR3),y
    sta (ZPADDR4),y
    rts
.endproc


.proc clearScreen
    ldx #0
    ldy #0

@L1:
    lda loAddrs,x
    sta ZPADDR0
    lda page1HiAddrs,x
    sta ZPADDR0+1

    lda #$0
@L2:
    sta (ZPADDR0),y
    iny
    cpy #MAXXBYTE
    bne @L2

    inx
    cpx #MAXY
    bne @L1

    lda TXTCLR
    lda MIXCLR
    lda HIRES
    lda LOWSCR

    rts
.endproc


.DATA

loAddrs:
.LOBYTES   LINE0,   LINE1,   LINE2,   LINE3,   LINE4,   LINE5,   LINE6,   LINE7
.LOBYTES   LINE8,   LINE9,  LINE10,  LINE11,  LINE12,  LINE13,  LINE14,  LINE15
.LOBYTES  LINE16,  LINE17,  LINE18,  LINE19,  LINE20,  LINE21,  LINE22,  LINE23
.LOBYTES  LINE24,  LINE25,  LINE26,  LINE27,  LINE28,  LINE29,  LINE30,  LINE31
.LOBYTES  LINE32,  LINE33,  LINE34,  LINE35,  LINE36,  LINE37,  LINE38,  LINE39
.LOBYTES  LINE40,  LINE41,  LINE42,  LINE43,  LINE44,  LINE45,  LINE46,  LINE47
.LOBYTES  LINE48,  LINE49,  LINE50,  LINE51,  LINE52,  LINE53,  LINE54,  LINE55
.LOBYTES  LINE56,  LINE57,  LINE58,  LINE59,  LINE60,  LINE61,  LINE62,  LINE63
.LOBYTES  LINE64,  LINE65,  LINE66,  LINE67,  LINE68,  LINE69,  LINE70,  LINE71
.LOBYTES  LINE72,  LINE73,  LINE74,  LINE75,  LINE76,  LINE77,  LINE78,  LINE79
.LOBYTES  LINE80,  LINE81,  LINE82,  LINE83,  LINE84,  LINE85,  LINE86,  LINE87
.LOBYTES  LINE88,  LINE89,  LINE90,  LINE91,  LINE92,  LINE93,  LINE94,  LINE95
.LOBYTES  LINE96,  LINE97,  LINE98,  LINE99, LINE100, LINE101, LINE102, LINE103
.LOBYTES LINE104, LINE105, LINE106, LINE107, LINE108, LINE109, LINE110, LINE111
.LOBYTES LINE112, LINE113, LINE114, LINE115, LINE116, LINE117, LINE118, LINE119
.LOBYTES LINE120, LINE121, LINE122, LINE123, LINE124, LINE125, LINE126, LINE127
.LOBYTES LINE128, LINE129, LINE130, LINE131, LINE132, LINE133, LINE134, LINE135
.LOBYTES LINE136, LINE137, LINE138, LINE139, LINE140, LINE141, LINE142, LINE143
.LOBYTES LINE144, LINE145, LINE146, LINE147, LINE148, LINE149, LINE150, LINE151
.LOBYTES LINE152, LINE153, LINE154, LINE155, LINE156, LINE157, LINE158, LINE159
.LOBYTES LINE160, LINE161, LINE162, LINE163, LINE164, LINE165, LINE166, LINE167
.LOBYTES LINE168, LINE169, LINE170, LINE171, LINE172, LINE173, LINE174, LINE175
.LOBYTES LINE176, LINE177, LINE178, LINE179, LINE180, LINE181, LINE182, LINE183
.LOBYTES LINE184, LINE185, LINE186, LINE187, LINE188, LINE189, LINE190, LINE191

page1HiAddrs:
.HIBYTES   LINE0,   LINE1,   LINE2,   LINE3,   LINE4,   LINE5,   LINE6,   LINE7
.HIBYTES   LINE8,   LINE9,  LINE10,  LINE11,  LINE12,  LINE13,  LINE14,  LINE15
.HIBYTES  LINE16,  LINE17,  LINE18,  LINE19,  LINE20,  LINE21,  LINE22,  LINE23
.HIBYTES  LINE24,  LINE25,  LINE26,  LINE27,  LINE28,  LINE29,  LINE30,  LINE31
.HIBYTES  LINE32,  LINE33,  LINE34,  LINE35,  LINE36,  LINE37,  LINE38,  LINE39
.HIBYTES  LINE40,  LINE41,  LINE42,  LINE43,  LINE44,  LINE45,  LINE46,  LINE47
.HIBYTES  LINE48,  LINE49,  LINE50,  LINE51,  LINE52,  LINE53,  LINE54,  LINE55
.HIBYTES  LINE56,  LINE57,  LINE58,  LINE59,  LINE60,  LINE61,  LINE62,  LINE63
.HIBYTES  LINE64,  LINE65,  LINE66,  LINE67,  LINE68,  LINE69,  LINE70,  LINE71
.HIBYTES  LINE72,  LINE73,  LINE74,  LINE75,  LINE76,  LINE77,  LINE78,  LINE79
.HIBYTES  LINE80,  LINE81,  LINE82,  LINE83,  LINE84,  LINE85,  LINE86,  LINE87
.HIBYTES  LINE88,  LINE89,  LINE90,  LINE91,  LINE92,  LINE93,  LINE94,  LINE95
.HIBYTES  LINE96,  LINE97,  LINE98,  LINE99, LINE100, LINE101, LINE102, LINE103
.HIBYTES LINE104, LINE105, LINE106, LINE107, LINE108, LINE109, LINE110, LINE111
.HIBYTES LINE112, LINE113, LINE114, LINE115, LINE116, LINE117, LINE118, LINE119
.HIBYTES LINE120, LINE121, LINE122, LINE123, LINE124, LINE125, LINE126, LINE127
.HIBYTES LINE128, LINE129, LINE130, LINE131, LINE132, LINE133, LINE134, LINE135
.HIBYTES LINE136, LINE137, LINE138, LINE139, LINE140, LINE141, LINE142, LINE143
.HIBYTES LINE144, LINE145, LINE146, LINE147, LINE148, LINE149, LINE150, LINE151
.HIBYTES LINE152, LINE153, LINE154, LINE155, LINE156, LINE157, LINE158, LINE159
.HIBYTES LINE160, LINE161, LINE162, LINE163, LINE164, LINE165, LINE166, LINE167
.HIBYTES LINE168, LINE169, LINE170, LINE171, LINE172, LINE173, LINE174, LINE175
.HIBYTES LINE176, LINE177, LINE178, LINE179, LINE180, LINE181, LINE182, LINE183
.HIBYTES LINE184, LINE185, LINE186, LINE187, LINE188, LINE189, LINE190, LINE191

page2HiAddrs:
.HIBYTES   LINE0+$2000,   LINE1+$2000,   LINE2+$2000,   LINE3+$2000,   LINE4+$2000,   LINE5+$2000,   LINE6+$2000,   LINE7+$2000
.HIBYTES   LINE8+$2000,   LINE9+$2000,  LINE10+$2000,  LINE11+$2000,  LINE12+$2000,  LINE13+$2000,  LINE14+$2000,  LINE15+$2000
.HIBYTES  LINE16+$2000,  LINE17+$2000,  LINE18+$2000,  LINE19+$2000,  LINE20+$2000,  LINE21+$2000,  LINE22+$2000,  LINE23+$2000
.HIBYTES  LINE24+$2000,  LINE25+$2000,  LINE26+$2000,  LINE27+$2000,  LINE28+$2000,  LINE29+$2000,  LINE30+$2000,  LINE31+$2000
.HIBYTES  LINE32+$2000,  LINE33+$2000,  LINE34+$2000,  LINE35+$2000,  LINE36+$2000,  LINE37+$2000,  LINE38+$2000,  LINE39+$2000
.HIBYTES  LINE40+$2000,  LINE41+$2000,  LINE42+$2000,  LINE43+$2000,  LINE44+$2000,  LINE45+$2000,  LINE46+$2000,  LINE47+$2000
.HIBYTES  LINE48+$2000,  LINE49+$2000,  LINE50+$2000,  LINE51+$2000,  LINE52+$2000,  LINE53+$2000,  LINE54+$2000,  LINE55+$2000
.HIBYTES  LINE56+$2000,  LINE57+$2000,  LINE58+$2000,  LINE59+$2000,  LINE60+$2000,  LINE61+$2000,  LINE62+$2000,  LINE63+$2000
.HIBYTES  LINE64+$2000,  LINE65+$2000,  LINE66+$2000,  LINE67+$2000,  LINE68+$2000,  LINE69+$2000,  LINE70+$2000,  LINE71+$2000
.HIBYTES  LINE72+$2000,  LINE73+$2000,  LINE74+$2000,  LINE75+$2000,  LINE76+$2000,  LINE77+$2000,  LINE78+$2000,  LINE79+$2000
.HIBYTES  LINE80+$2000,  LINE81+$2000,  LINE82+$2000,  LINE83+$2000,  LINE84+$2000,  LINE85+$2000,  LINE86+$2000,  LINE87+$2000
.HIBYTES  LINE88+$2000,  LINE89+$2000,  LINE90+$2000,  LINE91+$2000,  LINE92+$2000,  LINE93+$2000,  LINE94+$2000,  LINE95+$2000
.HIBYTES  LINE96+$2000,  LINE97+$2000,  LINE98+$2000,  LINE99+$2000, LINE100+$2000, LINE101+$2000, LINE102+$2000, LINE103+$2000
.HIBYTES LINE104+$2000, LINE105+$2000, LINE106+$2000, LINE107+$2000, LINE108+$2000, LINE109+$2000, LINE110+$2000, LINE111+$2000
.HIBYTES LINE112+$2000, LINE113+$2000, LINE114+$2000, LINE115+$2000, LINE116+$2000, LINE117+$2000, LINE118+$2000, LINE119+$2000
.HIBYTES LINE120+$2000, LINE121+$2000, LINE122+$2000, LINE123+$2000, LINE124+$2000, LINE125+$2000, LINE126+$2000, LINE127+$2000
.HIBYTES LINE128+$2000, LINE129+$2000, LINE130+$2000, LINE131+$2000, LINE132+$2000, LINE133+$2000, LINE134+$2000, LINE135+$2000
.HIBYTES LINE136+$2000, LINE137+$2000, LINE138+$2000, LINE139+$2000, LINE140+$2000, LINE141+$2000, LINE142+$2000, LINE143+$2000
.HIBYTES LINE144+$2000, LINE145+$2000, LINE146+$2000, LINE147+$2000, LINE148+$2000, LINE149+$2000, LINE150+$2000, LINE151+$2000
.HIBYTES LINE152+$2000, LINE153+$2000, LINE154+$2000, LINE155+$2000, LINE156+$2000, LINE157+$2000, LINE158+$2000, LINE159+$2000
.HIBYTES LINE160+$2000, LINE161+$2000, LINE162+$2000, LINE163+$2000, LINE164+$2000, LINE165+$2000, LINE166+$2000, LINE167+$2000
.HIBYTES LINE168+$2000, LINE169+$2000, LINE170+$2000, LINE171+$2000, LINE172+$2000, LINE173+$2000, LINE174+$2000, LINE175+$2000
.HIBYTES LINE176+$2000, LINE177+$2000, LINE178+$2000, LINE179+$2000, LINE180+$2000, LINE181+$2000, LINE182+$2000, LINE183+$2000
.HIBYTES LINE184+$2000, LINE185+$2000, LINE186+$2000, LINE187+$2000, LINE188+$2000, LINE189+$2000, LINE190+$2000, LINE191+$2000

colourEvenLookup:
    .BYTE $00, $55, $2a, $ff

colourOddLookup:
    .BYTE $00, $2a, $55, $ff

evenGrid:
    .BYTE $03, $0c, $30, $40, $00, $00, $00

oddGrid:
    .BYTE $00, $00, $00, $01, $06, $18, $60

evenGridLeft:
    .BYTE $00, $7c, $70, $40, $00, $00, $00

oddGridLeft:
    .BYTE $00, $7f, $7f, $7f, $7e, $78, $60

evenGridRight:
    .BYTE $03, $0f, $3f, $00, $00, $00, $00

oddGridRight:
    .BYTE $00, $00, $00, $01, $07, $1f, $7f

characterBitmap1:
.BYTE $70, $01
.BYTE $70, $01
.BYTE $30, $00
.BYTE $7c, $01
.BYTE $33, $06
.BYTE $30, $00
.BYTE $30, $00
.BYTE $4f, $01
.BYTE $40, $01
.BYTE $40, $01

characterBitmap2:
.BYTE $70, $01
.BYTE $70, $01
.BYTE $30, $00
.BYTE $3c, $06
.BYTE $73, $01
.BYTE $30, $00
.BYTE $7c, $01
.BYTE $43, $07
.BYTE $43, $07
.BYTE $03, $00

characterBitmap3:
.BYTE $70, $01
.BYTE $70, $01
.BYTE $30, $00
.BYTE $7c, $01
.BYTE $3c, $06
.BYTE $70, $01
.BYTE $7c, $01
.BYTE $3c, $00
.BYTE $3f, $00
.BYTE $0c, $00

characterBitmapLo:
.LOBYTES characterBitmap3, characterBitmap2, characterBitmap1

characterBitmapHi:
.HIBYTES characterBitmap3, characterBitmap2, characterBitmap1

characterColour:     .BYTE COL_VIOLET
characterBitmap:     .BYTE $00
characterY:          .BYTE 0
characterYBottom:    .BYTE CHAR_HEIGHT
characterOldY:       .BYTE 0
characterOldYBottom: .BYTE CHAR_HEIGHT
characterState:      .BYTE CHAR_STATE_FALLING
characterNumJumps:   .BYTE $00
characterYSpeed:     .BYTE $00
characterYSpeedFrac: .BYTE $00

gridY:           .BYTE GRID_YPOS
gridXShift:      .BYTE $00
gridXPos:        .BYTE $00
gridScreenLeft:  .BYTE $00
gridScreenRight: .BYTE $00

shouldQuit: .BYTE $00

level:      .BYTE $0

; A level consists of the following for each grid:
;     Byte 0 - Offset of the start of this grid from the previous grid's start
;     Byte 1 - Grid width
;     Byte 2 - Grid top
;     Byte 3 - Grid bottom
;     Byte 4 - Grid colour
; The end of a level has a grid width of 0
level1:
.BYTE 0, 80, 140, 140+GRID_HEIGHT, COL_VIOLET
.BYTE 90, 80, 140, 140+GRID_HEIGHT, COL_VIOLET
.BYTE 90, 80, 140, 140+GRID_HEIGHT, COL_VIOLET
.BYTE 90, 40, 140, 140+GRID_HEIGHT, COL_VIOLET
.BYTE 40, $00, $00, $00, $00

level2:
.BYTE 0, 80, 140, 140+GRID_HEIGHT, COL_VIOLET
.BYTE 90, 80, 140, 140+GRID_HEIGHT, COL_GREEN
.BYTE 90, 80, 140, 140+GRID_HEIGHT, COL_VIOLET
.BYTE 90, 40, 140, 140+GRID_HEIGHT, COL_GREEN
.BYTE 40, $00, $00, $00, $00

level3:
.BYTE 0, 80, 80, 80+GRID_HEIGHT, COL_VIOLET
.BYTE 60, 80, 100, 100+GRID_HEIGHT, COL_GREEN
.BYTE 60, 80, 120, 120+GRID_HEIGHT, COL_VIOLET
.BYTE 60, 40, 140, 140+GRID_HEIGHT, COL_GREEN
.BYTE 40, $00, $00, $00, $00

level4:
.BYTE 0, 80, 140, 140+GRID_HEIGHT, COL_VIOLET
.BYTE 60, 80, 120, 120+GRID_HEIGHT, COL_VIOLET
.BYTE 60, 80, 140, 140+GRID_HEIGHT, COL_VIOLET
.BYTE 60, 40, 120, 120+GRID_HEIGHT, COL_VIOLET
.BYTE 40, $00, $00, $00, $00

level5:
.BYTE 0, 80, 140, 140+GRID_HEIGHT, COL_VIOLET
.BYTE 60, 80, 120, 120+GRID_HEIGHT, COL_VIOLET
.BYTE 10, 70, 160, 160+GRID_HEIGHT, COL_GREEN
.BYTE 50, 80, 140, 140+GRID_HEIGHT, COL_VIOLET
.BYTE 60, 40, 120, 120+GRID_HEIGHT, COL_VIOLET
.BYTE 40, $00, $00, $00, $00

level6:
.BYTE 0, 80, 140, 140+GRID_HEIGHT, COL_VIOLET
.BYTE 100, 20, 120, 120+GRID_HEIGHT, COL_GREEN
.BYTE 40, 20, 100, 100+GRID_HEIGHT, COL_VIOLET
.BYTE 34, 20, 80, 80+GRID_HEIGHT, COL_GREEN
.BYTE 34, 20, 60, 60+GRID_HEIGHT, COL_VIOLET
.BYTE 30, 20, 40, 40+GRID_HEIGHT, COL_GREEN
.BYTE 40, $00, $00, $00, $00

levelsLo:
.LOBYTES level1, level2, level3, level4, level5, level6, 0

levelsHi:
.HIBYTES level1, level2, level3, level4, level5, level6, 0

