.include "inc/constants.inc"

.segment "CODE"

.import main

.export irq_handler
.proc irq_handler
  RTI                           ; Return to original context
.endproc
