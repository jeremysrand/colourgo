;
;  main.s
;  colourgo
;
;  Created by Jeremy Rand on 2017-07-19.
;  Copyright © 2017 Jeremy Rand. All rights reserved.
;


COUT = $fded
KEYBOARD = $c000
STROBE = $c010

main:
    ldx #$00
loop:
    lda msg, X
    beq wait
    ora #$80
    jsr COUT
    inx
    jmp loop
    
wait:
    lda KEYBOARD
    bpl wait
    lda STROBE
    rts

msg:    .asciiz "HELLO, WORLD"
