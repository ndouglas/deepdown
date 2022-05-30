; The Reset Handler
;
; The NES uses reset events whenever the NES is powered on or reset using the
; RESET button on the front of the control deck.
;
; This should be used to restore the state of the entire machine to default.

.include "inc/constants.inc"

.segment "ZEROPAGE"
.importzp player_x            ; The player's sprite's top-left x coordinate.
.importzp player_y            ; The player's sprite's top-left y coordinate.
.importzp player_sprite       ; The player's sprite's tile index.

.segment "CODE"               ; Start of code segment.
.import main

.export reset_handler
.proc reset_handler
  SEI                         ; Set Interrupt-Ignore bit.
  CLD                         ; Clear Decimal Mode bit.
  LDX CTRL_RESET              ; X = CTRL_RESET
  STX PPU_CTRL                ; Zero out PPU_CTRL.
  LDX MASK_RESET              ; X = MASK_RESET
  STX PPU_MASK                ; Zero out PPU_MASK.

; Memory can be random at startup, so we ensure all sprites' Y coordinates
; are offscreen to avoid weird, random behavior.
  LDX #$00
  LDA #$ff
clear_oam:
  STA $0200, X                ; Set sprite y to be off the screen.
  INX                         ; Increment X.
  INX                         ; Increment X.
  INX                         ; Increment X.
  INX                         ; Increment X.
  BNE clear_oam               ; Until X == A.

vblank_wait:
  BIT PPU_STATUS              ;
  BPL vblank_wait             ; 

; initialize zero-page values
initialize_zero_page:
  LDA #$80                    ; A = #$80
  STA player_x                ; player_x = #$80
  LDA #$a0                    ; A = #$a0
  STA player_y                ; player_y = #$a0
  LDA #$05                    ; A = #$05
  STA player_sprite           ; player_sprite = #$05

  JMP main                    ; Start our game! :)
.endproc
