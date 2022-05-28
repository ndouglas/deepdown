.include "inc/constants.inc"

; The Reset Handler
;
; The NES uses reset events whenever the NES is powered on or reset using the
; RESET button on the front of the control deck.
;
; This should be used to restore the state of the entire machine to default.

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
vblankwait:
  BIT PPU_STATUS              ;
  BPL vblankwait              ; 
  JMP main                    ; Start our game! :)
.endproc
