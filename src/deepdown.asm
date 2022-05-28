.include "inc/constants.inc"
.include "inc/header.inc"

.segment "RODATA"       ; Start of read-only data segment.
palettes:
.byte LIGHT_RED, MEDIUM_RED, DARK_RED, BLACK 
.byte LIGHT_SPRING, MEDIUM_SPRING, DARK_SPRING, BLACK 
.byte LIGHT_OLIVE, MEDIUM_OLIVE, DARK_OLIVE, BLACK 
.byte LIGHT_AZURE, MEDIUM_AZURE, DARK_AZURE, BLACK 
sprites:
.byte $70, $05, $00, $80    
.byte $70, $06, $00, $88    
.byte $78, $07, $00, $80    
.byte $78, $08, $00, $88    


.segment "CODE"         ; Start of code segment.

.export main
.proc main
  LDX PPU_STATUS            ; Read PPU status and reset address latch.
  LDX #$3f                  ; X = 3f
  STX PPU_ADDR              ; PPU_ADDR=3f__
  LDX #$00                  ; X = 00
  STX PPU_ADDR              ; PPU_ADDR=3f00; where palettes begin.

; Load palettes.
  LDX #$00                  ; X = 00
load_palettes:              ; Load our color palettes.
  LDA palettes, X           ; A = 'palettes' + X
  STA PPU_DATA              ; Set palette color.
  INX                       ; Increment X.
  CPX #$10                  ; Are we at the end of the palettes?
  BNE load_palettes         ; If not, continue looping.

; Load sprites.
  LDX #$00                  ; X = 00
load_sprites:               ; Load our sprites.
  LDA sprites, X            ; A = 'sprites' + X             
  STA $0200, X              ; Set sprite data at 'sprites' + X.
  INX                       ; Increment X.
  CPX #$10                  ; Are we at the end of the sprite?
  BNE load_sprites          ; If not, continue looping.

vblankwait:                 ; Wait for another vblank before continuing.
  BIT PPU_STATUS            ;
  BPL vblankwait            ;
  LDA #CTRL_STANDARD        ; Standard PPU_CTRL preset.
  STA PPU_CTRL              ; PPU_CTRL = CTRL_STANDARD
  LDA #MASK_STANDARD        ; Standard PPU_MASK preset.
  STA PPU_MASK              ; PPU_MASK = MASK_STANDARD

forever:
  JMP forever               ; Loop, lol.
.endproc

.import irq_handler     ; Import IRQ Handler.
.import nmi_handler     ; Import NMI Handler.
.import reset_handler   ; Import Reset Handler.

.segment "VECTORS"
.addr nmi_handler       ; Non-Maskable Interrupt Handler.
.addr reset_handler     ; Reset-Button Handler.
.addr irq_handler       ; Interrupt Request Handler.

.segment "CHR"                           ; Start of character segment.
.incbin "../graphics/graphics.chr"       ; Include the graphics. 
