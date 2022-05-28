.include "inc/constants.inc"

; The Non-Maskable Interrupt (NMI) Handler
;
; The NES uses NMI events every time the PPU enters VBLANK.
;
; VBLANK, or "vertical blank", is the period during which the electron gun
; within a Cathode-Ray Tube television is resetting between successive
; draws of the screen, 60 times per second (NTSC).
;
; During this time (and _only_ during this time), the picture is not changing.
;
; This makes it the best time to perform graphical updates.
;
; This needs to run in ~1250 milioseconds, or 0.00125 seconds.

.segment "CODE"             ; Start of code segment.

.import main

.export nmi_handler
.proc nmi_handler
  LDA #$00                  ; A = 00
  STA OAM_ADDR              ; OAM_ADDR will start at byte zero.
  LDA #$02                  ; A = 02
  STA OAM_DMA               ; Transfer $0200-$02ff to OAM.
  RTI                       ; Return to original context.
.endproc
