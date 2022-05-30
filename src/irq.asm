; The Interrupt Request (IRQ) Handler
;
; Interrupt requests can be fired from the NES' sound hardware or some custom
; cartridge hardware events.

.include "inc/constants.inc"

.segment "CODE"         ; Start of code segment.

.export irq_handler
.proc irq_handler
  RTI                   ; Return to original context.
.endproc
