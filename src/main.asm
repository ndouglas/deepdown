; Main
;
; The main procedure, which is responsible for the post-RESET setup.

.include "inc/constants.inc"

.import palettes            ; Import our palettes from read-only data.

.segment "CODE"             ; Start of code segment.

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
  CPX #$20                  ; Are we at the end of the palettes?
  BNE load_palettes         ; If not, continue looping.

vblankwait:                 ; Wait for another vblank before continuing.
  BIT PPU_STATUS            ;
  BPL vblankwait            ;
  LDA #CTRL_STANDARD        ; Standard PPU_CTRL preset.
  STA PPU_CTRL              ; PPU_CTRL = CTRL_STANDARD
  LDA #MASK_STANDARD        ; Standard PPU_MASK preset.
  STA PPU_MASK              ; PPU_MASK = MASK_STANDARD

  ; write a nametable
  ; big stars first
  LDA PPU_STATUS
  LDA #$20
  STA PPU_ADDR
  LDA #$6b
  STA PPU_ADDR
  LDX #$2f
  STX PPU_DATA

  LDA #$21
  STA PPU_ADDR
  LDA #$57
  STA PPU_ADDR
  STX PPU_DATA

  LDA #$22
  STA PPU_ADDR
  LDA #$23
  STA PPU_ADDR
  STX PPU_DATA

  LDA #$23
  STA PPU_ADDR
  LDA #$52
  STA PPU_ADDR
  STX PPU_DATA

  ; finally, attribute table
  LDA PPU_STATUS
  LDA #$23
  STA PPU_ADDR
  LDA #$c2
  STA PPU_ADDR
  LDA #%01000000
  STA PPU_DATA

forever:
  JMP forever               ; Loop, lol.
.endproc
