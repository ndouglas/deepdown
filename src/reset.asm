.include "inc/constants.inc"

.segment "CODE"

.import main

.export reset_handler
.proc reset_handler
  SEI                               ; Set Interrupt-Ignore bit.
  CLD                               ; Clear Decimal Mode bit.
  LDX #$00                          ; X = 0000
  STX PPU_CTRL                      ; Zero out PPU_CTRL.
  STX PPU_MASK                      ; Zero out PPU_MASK.
vblankwait:
  BIT PPU_STATUS                    ;
  BPL vblankwait                    ; 
  JMP main                          ; Start our game! :)
.endproc
