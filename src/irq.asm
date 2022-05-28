.include "inc/constants.inc"

; The Interrupt Request (IRQ) Handler
;
; Interrupt requests can be fired from the NES' sound hardware or some custom
; cartridge hardware events.
;

.segment "CODE"         ; Start of code segment.

.import main

.export irq_handler
.proc irq_handler
  RTI                   ; Return to original context.
.endproc
