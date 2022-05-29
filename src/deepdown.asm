.include "inc/constants.inc"
.include "inc/header.inc"

.segment "RODATA"       ; Start of read-only data segment.

identity_table:
.byte $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f
.byte $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1a, $1b, $1c, $1d, $1e, $1f
.byte $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2a, $2b, $2c, $2d, $2e, $2f
.byte $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3a, $3b, $3c, $3d, $3e, $3f
.byte $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4a, $4b, $4c, $4d, $4e, $4f
.byte $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5a, $5b, $5c, $5d, $5e, $5f
.byte $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6a, $6b, $6c, $6d, $6e, $6f
.byte $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $7a, $7b, $7c, $7d, $7e, $7f
.byte $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a, $8b, $8c, $8d, $8e, $8f
.byte $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9a, $9b, $9c, $9d, $9e, $9f
.byte $a0, $a1, $a2, $a3, $a4, $a5, $a6, $a7, $a8, $a9, $aa, $ab, $ac, $ad, $ae, $af
.byte $b0, $b1, $b2, $b3, $b4, $b5, $b6, $b7, $b8, $b9, $ba, $bb, $bc, $bd, $be, $bf
.byte $c0, $c1, $c2, $c3, $c4, $c5, $c6, $c7, $c8, $c9, $ca, $cb, $cc, $cd, $ce, $cf
.byte $d0, $d1, $d2, $d3, $d4, $d5, $d6, $d7, $d8, $d9, $da, $db, $dc, $dd, $de, $df
.byte $e0, $e1, $e2, $e3, $e4, $e5, $e6, $e7, $e8, $e9, $ea, $eb, $ec, $ed, $ee, $ef
.byte $f0, $f1, $f2, $f3, $f4, $f5, $f6, $f7, $f8, $f9, $fa, $fb, $fc, $fd, $fe, $ff

.export identity_table

palettes:

background_palettes:
.byte BLACK, DARK_RED, MEDIUM_RED, LIGHT_RED 
.byte BLACK, DARK_SPRING, MEDIUM_SPRING, LIGHT_SPRING 
.byte BLACK, DARK_OLIVE, MEDIUM_OLIVE, LIGHT_OLIVE 
.byte BLACK, DARK_AZURE, MEDIUM_AZURE, LIGHT_AZURE 

foreground_palettes:
.byte BLACK, MEDIUM_RED, PALE_RED, MEDIUM_AZURE 
.byte BLACK, DARK_SPRING, MEDIUM_SPRING, LIGHT_SPRING 
.byte BLACK, DARK_OLIVE, MEDIUM_OLIVE, LIGHT_OLIVE 
.byte BLACK, DARK_AZURE, MEDIUM_AZURE, LIGHT_AZURE 

.segment "ZEROPAGE"
player_x: .res 1                ; Reserve a byte for the player's X coordinate.
player_y: .res 1                ; Reserve a byte for the player's Y coordinate.
player_dir: .res 1              ; The direction in which the player is moving.
player_sprite: .res 1           ; The first tile of the player's current sprite.

.exportzp player_x              ; Export player_x byte.
.exportzp player_y              ; Export player_y byte.
.exportzp player_dir            ; Export player_dir byte.
.exportzp player_sprite         ; Export player_sprite byte.

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

.segment "VECTORS"
.import nmi_handler     ; Import NMI Handler.
.addr nmi_handler       ; Use Non-Maskable Interrupt Handler.
.import reset_handler   ; Import Reset Handler.
.addr reset_handler     ; Use Reset-Button Handler.
.import irq_handler     ; Import IRQ Handler.
.addr irq_handler       ; Use Interrupt Request Handler.

.segment "CHR"                           ; Start of character segment.
.incbin "../graphics/graphics.chr"       ; Include the graphics. 
