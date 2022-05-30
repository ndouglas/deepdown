; Deepdown
;
; This is a sort of "meta" file that will be used for some central functionality.

.include "inc/constants.inc"
.include "inc/header.inc"

.segment "CODE"                           ; Start of code segment.
.import main                              ; Import our main procedure.

.segment "VECTORS"
.import nmi_handler                       ; Import NMI Handler.
.addr nmi_handler                         ; Use Non-Maskable Interrupt Handler.
.import reset_handler                     ; Import Reset Handler.
.addr reset_handler                       ; Use Reset-Button Handler.
.import irq_handler                       ; Import IRQ Handler.
.addr irq_handler                         ; Use Interrupt Request Handler.

.segment "CHR"                            ; Start of character segment.
.incbin "../graphics/graphics.chr"        ; Include the graphics. 
