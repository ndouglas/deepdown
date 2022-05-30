; The Non-Maskable Interrupt (NMI) Handler
;
; The NES uses NMI events every time the PPU enters VBLANK.
;
; VBLANK, or "vertical blank", is the period during which the electron gun
; within a Cathode-Ray Tube television is resetting between successive
; draws of the screen, 60 times per second (NTSC).
;
; During this time (and _only_ during this time), the picture is not changing.
;
; This makes it the best time to perform graphical updates.
;
; This needs to run in ~1250 milioseconds, or 0.00125 seconds.

.include "inc/constants.inc"

.segment "CODE"             ; Start of code segment.

.import main                ; Import the main procedure.
.import read_input          ; Import the read_input procedure.
.import update_player       ; Import the update_player procedure.
.import draw_player         ; Import the draw_player procedure.

.export nmi_handler         ; Export the NMI Handler.
.proc nmi_handler
  LDA #$00                  ; A = 00
  STA OAM_ADDR              ; OAM_ADDR will start at byte zero.
  LDA #$02                  ; A = 02
  STA OAM_DMA               ; Transfer $0200-$02ff to OAM.

  ; update tiles *after* DMA transfer
handle_player:
  JSR read_input            ; Read the player's input.
  JSR update_player         ; Update the player's position.
  JSR draw_player           ; Draw the player.

set_scroll:
  LDA #$00                  ; A = 00
  STA PPU_SCROLL            ; Set scroll position to first nametable.
  STA PPU_SCROLL            ; Set scroll position to first nametable, no scrolling.

exit:
  RTI                       ; Return to original context.
.endproc
