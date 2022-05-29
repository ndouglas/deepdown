.include "inc/constants.inc"
.include "inc/header.inc"

.segment "RODATA"       ; Start of read-only data segment.

palettes:

background_palettes:
.byte BLACK, DARK_RED, MEDIUM_RED, LIGHT_RED 
.byte BLACK, DARK_SPRING, MEDIUM_SPRING, LIGHT_SPRING 
.byte BLACK, DARK_OLIVE, MEDIUM_OLIVE, LIGHT_OLIVE 
.byte BLACK, DARK_AZURE, MEDIUM_AZURE, LIGHT_AZURE 

character_palettes:
.byte BLACK, DARK_RED, MEDIUM_RED, LIGHT_RED 
.byte BLACK, DARK_SPRING, MEDIUM_SPRING, LIGHT_SPRING 
.byte BLACK, DARK_OLIVE, MEDIUM_OLIVE, LIGHT_OLIVE 
.byte BLACK, DARK_AZURE, MEDIUM_AZURE, LIGHT_AZURE 

; Sprites
; 
; Sprites have the following structure:
; - Y position of top left corner of the sprite (0-255)
; - Tile number from sprite pattern table (0-255)
; - Special attribute flags (see below)
; - X position of the top left corner of the sprite (0-255)
;
; Special attribute flags:
; 7 (MSB)     Flips sprite vertically (if 1)
; 6           Flips sprite horizontally (if 1)
; 5           Sprite priority (behind background if 1)
; 4-2         Not used
; 1-0 (LSB)   Sprite palette

sprites:
.byte $70, $05, %00000010, $80    
.byte $70, $06, %00000010, $88    
.byte $78, $07, %00000010, $80    
.byte $78, $08, %00000010, $88    

.segment "ZEROPAGE"
player_x: .res 1            ; Reserve a byte for the player's X coordinate.
player_y: .res 1            ; Reserve a byte for the player's Y coordinate.
player_dir: .res 1          ; The direction in which the player is moving.

.exportzp player_x          ; Export player_x byte.
.exportzp player_y          ; Export player_y byte.
.exportzp player_dir        ; Explore player_dir byte.

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

.import irq_handler     ; Import IRQ Handler.
.import nmi_handler     ; Import NMI Handler.
.import reset_handler   ; Import Reset Handler.

.import draw_player     ; Import draw_player procedure.
.import update_player   ; Import update_player procedure.

.segment "VECTORS"
.addr nmi_handler       ; Non-Maskable Interrupt Handler.
.addr reset_handler     ; Reset-Button Handler.
.addr irq_handler       ; Interrupt Request Handler.

.segment "CHR"                           ; Start of character segment.
.incbin "../graphics/graphics.chr"       ; Include the graphics. 
