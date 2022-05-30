; Draw Player
;
; This procedure draws the player sprite.

.include "../inc/constants.inc"

.importzp player_dir        ; Import player_dir byte.
.importzp player_input      ; Import player_input byte.

.segment "CODE"             ; Start of code segment.

.import main                ; Import main procedure.

.export read_input
.proc read_input
; Save the registers.
enter:
  PHP                       ; Save the processor status register.
  PHA                       ; Save the accumulator register.
  TXA                       ; Transfer X -> A register.
  PHA                       ; Save the X register.
  TYA                       ; Transfer Y -> A register.
  PHA                       ; Save the Y register.

; Tell both controllers to latch input.
latch_input:
  LDA #$01                  ; A = 1
  STA IO_PLAYER1            ; Reset latch.
  LDA #$00                  ; A = 0
  STA IO_PLAYER1            ; Set latch.
  
; Read the actual buttons pressed.
read_buttons:
  LDA #$00                  ; A = 0
  STA player_input          ; player_input = 0
  LDX #$08                  ; X = 8
read_buttons_loop:
  LDA IO_PLAYER1            ; player 1 input
  LSR A                     ; Carry = A[0]
  ROL player_input          ; player_input[0] = Carry
  DEX                       ; Decrement X.
  BNE read_buttons_loop     ; Loop.

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



