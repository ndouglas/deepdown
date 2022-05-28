.include "inc/constants.inc"
.include "inc/header.inc"

.segment "CODE"

.proc irq_handler
  RTI
.endproc

.proc nmi_handler
  RTI
.endproc

.import reset_handler

.export main
.proc main
  LDX PPU_STATUS
  LDX #$3f
  STX PPU_ADDR
  LDX #$00
  STX PPU_ADDR
  LDA #$29
  STA PPU_DATA
  LDA #%00011110
  STA PPU_MASK
forever:
  JMP forever
.endproc

.segment "VECTORS"
.addr nmi_handler, reset_handler, irq_handler

.segment "CHR"
.res 8192
