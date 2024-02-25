; SHVC-BlinkenLight
; David Lindecrantz <optiroc@me.com>
;
; The most minimal example program I could conceive that does *something*.

.p816
.smart +

.export Reset, NMIHandler, EmptyHandler

; MMIO registers
INIDISP     = $2100
BGMODE      = $2105
CGADD       = $2121
CGDATA      = $2122
TM          = $212C
TS          = $212D
NMITIMEN    = $4200

; Entry point
Reset:
    .a8             ; At reset M and X = 1
    .i8

    sei             ; Disable interrupts
    clc             ; Enter native mode
    xce

    stz BGMODE      ; Turn off all PPU layers
    stz TM
    stz TS

    lda #$0F        ; Turn on screen
    sta INIDISP

    lda #$80        ; Enable NMI
    sta NMITIMEN

:   wai             ; Wait indefinitely
    bra :-          ; (only wake up in NMI)

; VBlank interrupt handler
NMIHandler:
    stz CGADD       ; CGRAM address = 0
    sta CGDATA      ; Color 0 low byte = A
    stz CGDATA      ; Color 0 high byte = 0
    dec             ; A -= 1
    rti

; Unused handlers
EmptyHandler:
    rti
