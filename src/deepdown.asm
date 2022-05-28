.include "inc/constants.inc"
.include "inc/header.inc"

.segment "CODE"

.export main
.proc main
  LDX PPU_STATUS                ; Read PPU status and reset address latch
  LDX #$3f                      ; X = 3f
  STX PPU_ADDR                  ; PPU_ADDR=3f__
  LDX #$00                      ; X = 00
  STX PPU_ADDR                  ; PPU_ADDR=3f00; where palettes begin
  LDA #LIGHT_VIOLET             ; A = LIGHT_VIOLET
  STA PPU_DATA                  ; 3f00 = LIGHT_VIOLET
  LDA #MASK_STANDARD            ; Standard PPU_MASK preset
  STA PPU_MASK                  ; PPU_MASK = MASK_STANDARD
forever:
  JMP forever                   ; Loop, lol.
.endproc

.import irq_handler             ; Import IRQ Handler
.import nmi_handler             ; Import NMI Handler
.import reset_handler           ; Import Reset Handler

.segment "VECTORS"
.addr nmi_handler               ; Non-Maskable Interrupt Handler
.addr reset_handler             ; Reset-Button Handler
.addr irq_handler               ; Interrupt Request Handler

.segment "CHR"
.res 8192
