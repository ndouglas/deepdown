.include "../inc/constants.inc"

; Update Player
;
; This procedure updates the location of the player sprite.

.segment "ZEROPAGE"
.importzp player_x          ; Import player_x byte.
.importzp player_y          ; Import player_y byte.
.importzp player_dir        ; Import player_dir byte.

.segment "CODE"             ; Start of code segment.

.import main                ; Import main procedure.

.export update_player
.proc update_player
; Save the registers.
enter:
  PHP                       ; Save the processor status register.
  PHA                       ; Save the accumulator register.
  TXA                       ; Transfer X -> A register.
  PHA                       ; Save the X register.
  TYA                       ; Transfer Y -> A register.
  PHA                       ; Save the Y register.

; Are we at the right edge of the screen?
is_at_right_edge:
  LDA player_x              ; A = player_x
  CMP #X_MAX_SPRITE         ; Are we at or past the right edge of the screen?
  BCC not_at_right_edge     ; If not, jump.

; Force player to move left.
set_move_direction_left:
  LDA #$00                  ; A = 0
  STA player_dir            ; player_dir = 0; move LEFT.
  JMP get_direction         ; Now 

; We're not at the right edge of the screen.
not_at_right_edge:
  LDA player_x              ; A = player_x
  CMP #X_MIN_SPRITE         ; Are we at or past the left edge of the screen?
  BCS get_direction         ; If not, jump.

; Force player to move right.
set_move_direciton_right:
  LDA #$01                  ; A = 1
  STA player_dir            ; player_dir = 1; move RIGHT.
                            ; Fall through.

; Calculate the direction of movement.
get_direction:
  LDA player_dir            ; A = player_dir
  CMP #$01                  ; If player_dir == 1...
  BEQ move_right            ; ...player is moving right.
                            ; Fall through.

; Actually move left.
move_left:
  DEC player_x              ; Decrement player_x value.
  JMP exit                  ; Skip to the end of the subroutine.

; Actually move right.
move_right:
  INC player_x              ; Increment player_x value.
                            ; Fall through.

; Restore the registers and return.
exit:
  PLA                       ; Restore the Y register.
  TAY                       ; Transfer A -> Y register.
  PLA                       ; Restore the X register.
  TAX                       ; Transfer A -> X register.
  PLA                       ; Restore the accumulator register.
  PLP                       ; Restore the processor status register.
  RTS                       ; Return to original context.
.endproc