.include "constants.inc"

.segment "CODE"

.import main

.export reset_handler
.proc reset_handler
  SEI
  CLD
  LDX #$00
  STX PPU_CTRL
  STX PPU_MASK
vblankwait:
  BIT PPU_STATUS
  BPL vblankwait
  JMP main
.endproc
