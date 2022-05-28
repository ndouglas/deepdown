.include "inc/constants.inc"
.include "inc/header.inc"

.segment "CODE"         ; Start of code segment.

.export main
.proc main
  LDX PPU_STATUS            ; Read PPU status and reset address latch
  LDX #$3f                  ; X = 3f
  STX PPU_ADDR              ; PPU_ADDR=3f__
  LDX #$00                  ; X = 00
  STX PPU_ADDR              ; PPU_ADDR=3f00; where palettes begin
  LDA #LIGHT_CHARTREUSE     ; A = LIGHT_CHARTREUSE
  STA PPU_DATA              ; 3f00 = LIGHT_CHARTREUSE
  LDA #MEDIUM_CHARTREUSE    ; A = MEDIUM_CHARTREUSE
  STA PPU_DATA              ; 3f01 = MEDIUM_CHARTREUSE
  LDA #DARK_CHARTREUSE      ; A = DARK_CHARTREUSE
  STA PPU_DATA              ; 3f02 = DARK_CHARTREUSE
  LDA #BLACK                ; A = BLACK
  STA PPU_DATA              ; 3f03 = BLACK
vblankwait:                 ; Wait for another vblank before continuing
  BIT PPU_STATUS            ;
  BPL vblankwait            ;
  LDA #CTRL_STANDARD        ; Standard PPU_CTRL preset
  STA PPU_CTRL              ; PPU_CTRL = CTRL_STANDARD
  LDA #MASK_STANDARD        ; Standard PPU_MASK preset
  STA PPU_MASK              ; PPU_MASK = MASK_STANDARD
forever:
  JMP forever               ; Loop, lol.
.endproc

.import irq_handler     ; Import IRQ Handler
.import nmi_handler     ; Import NMI Handler
.import reset_handler   ; Import Reset Handler

.segment "VECTORS"
.addr nmi_handler       ; Non-Maskable Interrupt Handler
.addr reset_handler     ; Reset-Button Handler
.addr irq_handler       ; Interrupt Request Handler

.segment "CHR"                           ; Start of character segment.
.incbin "../graphics/graphics.chr"       ; Include the graphics. 
