.include "../inc/constants.inc"

; Update Player
;
; This procedure updates the location of the player sprite.

.importzp player_x          ; Import player_x byte.
.importzp player_y          ; Import player_y byte.
.importzp player_dir        ; Import player_dir byte.
.importzp player_input      ; Import player_input byte.

.segment "CODE"             ; Start of code segment.

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

; Read player input.
read_input:
  LDA player_input          ; A = player_input
  AND #IO_PLAYER_LEFT       ; Check for player left input.
  BEQ not_left              ; If not pressed, skip to not_left.
  LDA #$00                  ; A = 0
  STA player_dir            ; player_dir = left
  JMP not_right             ; Override right, if also pressed.

not_left:
  LDA player_input          ; A = player_input
  AND #IO_PLAYER_RIGHT      ; Check for player right input.
  BEQ not_right             ; If not pressed, skip to not_right.
  LDA #$01                  ; A = 1
  STA player_dir            ; player_dir = right
                            ; Fall through.
not_right:
                            ; Fall through.

; Are we at the right edge of the screen?
is_at_right_edge:
  LDA player_x              ; A = player_x
  CMP #X_MAX_SPRITE         ; Are we at or past the right edge of the screen?
  BCC is_at_left_edge       ; If not, jump.
                            ; Fall through.

; Force player to move left.
set_dir_left:
  LDA #$00                  ; A = 0
  STA player_dir            ; player_dir = 0; move LEFT.
  JMP get_direction         ; Now 

; We're not at the right edge of the screen.
is_at_left_edge:
  LDA player_x              ; A = player_x
  CMP #X_MIN_SPRITE         ; Are we at or past the left edge of the screen?
  BCS get_direction         ; If not, jump.
                            ; Fall through.

; Force player to move right.
set_dir_right:
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