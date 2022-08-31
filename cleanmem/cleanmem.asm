    processor 6502

    seg code
    org $F000       ; Define the code origin at $F000

Start:
    sei             ; Disable interupts
    cld             ; Disable the BCD decimal math mode
    ldx #$FF        ; Loads the x register with #$FF
    txs             ; Transfer the X register to the (S)tack pointer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Clear the page zero region ($00 to $FF)
; Meaning the entire RAM and also the TIA registers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    lda #0          ; A = 0
    ldx #$FF        ; X = #$FF

MemLoop:
    sta $0,X        ; Store the value of A inside memory address $0 + X
    dex             ; X--
    bne MemLoop     ; Loop until X is equal to zero (z-flag is set)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fill the ROM size to exactly 4kb
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    org $FFFC
    .word Start     ; Reset vector to $FFFC (where the program starts)
    .word Start     ; Interupt vector at $FFFE (unused in the VCS)