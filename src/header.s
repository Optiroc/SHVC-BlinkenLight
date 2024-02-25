; SHVC ROM Header for ca65
; David Lindecrantz <optiroc@me.com>

.autoimport +

.define .ident("ROM_TITLE") "SHVC-BLINKENLIGHTS   "
.define .ident("ROM_GAMECODE") "BLNK"
.define .ident("ROM_MAKERCODE") "MB"

ROM_COUNTRY = 0
ROM_VERSION = 0
ROM_VERSION_MINOR = 0
ROM_CHIPSET = 0
ROM_ROMSIZE = 5
ROM_RAMSIZE = 0
ROM_EXPRAMSIZE = 0
ROM_MAPMODE = 0
ROM_SPEED = 0

.segment "HEADER"
    .byte ROM_MAKERCODE
    .byte ROM_GAMECODE
    .byte 0, 0, 0, 0, 0, 0
    .byte $00
    .byte ROM_EXPRAMSIZE
    .byte ROM_VERSION_MINOR
    .byte >ROM_CHIPSET
    .byte ROM_TITLE
    .byte (ROM_MAPMODE & $0f) + ((ROM_SPEED & $01) << 4) + $20
    .byte <ROM_CHIPSET
    .byte ROM_ROMSIZE
    .byte ROM_RAMSIZE
    .byte ROM_COUNTRY
    .byte $33
    .byte ROM_VERSION
    .word $ffff
    .word $0000

.segment "VECTOR"
    ; Native mode vectors
    .word 0, 0
    .word .loword(EmptyHandler)     ; COP
    .word .loword(EmptyHandler)     ; BRK
    .word .loword(EmptyHandler)     ; ABORT
    .word .loword(NMIHandler)       ; NMI
    .word .loword(EmptyHandler)     ; RST
    .word .loword(EmptyHandler)     ; IRQ

    ; Emulation mode vectors
    .word 0, 0, 0, 0, 0, 0
    .word .loword(Reset)            ; RESET
    .word 0
