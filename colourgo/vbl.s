;
;  vbl.s
;  colourgo
;
;  Created by Jeremy Rand on 2017-07-19.
;  Copyright © 2017 Jeremy Rand. All rights reserved.
;



    .export _vblWait, _vblWaitNon2c, _vblWait2c, _vblInit2gs
    .export _gVblWait, _vblIRQCallback


    .include "apple2.inc"


RDVBLBAR      :=  $C019


.proc _vblWait
    jmp (_gVblWait)
.endproc

.proc _vblInit2gs
    lda #$fe
    sta compType
.endproc


.proc _vblWaitNon2c
    lda   compType
@L1:
    cmp   RDVBLBAR
    bpl   @L1
@L2:
    cmp   RDVBLBAR
    bmi   @L2

    rts
.endproc


.proc _vblIRQCallback
    pha
    lda #$0
    sta vbl2cByte
    pla
    rts
.endproc


.proc _vblWait2c
    lda #$ff
    sta vbl2cByte

@L1:
    lda vbl2cByte
    bne @L1

    rts
.endproc


.data

_gVblWait:
    .BYTE   $0, $0

compType:
    .BYTE   $7e

vbl2cByte:
    .BYTE   $00
