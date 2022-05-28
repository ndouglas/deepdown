.include "inc/constants.inc"

.segment "CODE"

.import main

.export nmi_handler
.proc nmi_handler
  LDA #$00                      ; A = 00
  STA OAM_ADDR                  ; OAM_ADDR will start at byte zero
  LDA #$02                      ; A = 02
  STA OAM_DMA                   ; Transfer $0200-$02ff to OAM
  RTI                           ; Return to original context
.endproc
