.include "../inc/constants.inc"

; Draw Player
;
; This procedure draws the player sprite.

.segment "ZEROPAGE"
.importzp player_x          ; Import player_x byte.
.importzp player_y          ; Import player_y byte.
.importzp player_sprite     ; Import player_sprite byte.

.segment "CODE"             ; Start of code segment.

.import main                ; Import main procedure.

.export draw_player
.proc draw_player
; Save the registers.
enter:
  PHP                       ; Save the processor status register.
  PHA                       ; Save the accumulator register.
  TXA                       ; Transfer X -> A register.
  PHA                       ; Save the X register.
  TYA                       ; Transfer Y -> A register.
  PHA                       ; Save the Y register.

; Draw player tiles.
write_player_tile_numbers:
  LDA #$05                  ; Tile 1...
  STA $0201                 ; ... goes in $0201.
  LDA #$06                  ; Tile 2...
  STA $0205                 ; ... goes in $0205.
  LDA #$07                  ; Tile 3...
  STA $0209                 ; ... goes in $0209.
  LDA #$08                  ; Tile 4...
  STA $020d                 ; ... goes in $020d.
  LDA #$09                  ; Tile 5...
  STA $0211                 ; ... goes in $0211.
  LDA #$0A                  ; Tile 6...
  STA $0215                 ; ... goes in $0215.

  ; write player ship tile attributes
  ; use palette 0
  LDA #$00
  STA $0202
  STA $0206
  STA $020a
  STA $020e
  STA $0212
  STA $0216

  ; Write player tile locations.
write_player_tile_locations:
  ; top left tile:
  LDA player_y                ; A = player_y (top-left tile)
  STA $0200                   ; $0200 = player_y
  LDA player_x                ; A = player_x (top-left tile)
  STA $0203                   ; $0203 = player_x

  ; top right tile (x + 8):
  LDA player_y                ; A = player_y
  STA $0204                   ; $0200 + 4 = player_y
  LDA player_x                ; A = player_x
  CLC                         ; Clear the carry bit.
  ADC #$08                    ; A = player_x + 8
  STA $0207                   ; $0203 + 4 = player_x + 8

  ; middle left tile (y + 8):
  LDA player_y                ; A = player_y
  CLC                         ; Clear the carry bit.
  ADC #$08                    ; A = player_y + 8
  STA $0208                   ; $0200 + 8 = player_y + 8
  LDA player_x                ; A = player_x
  CLC                         ; Clear the carry bit.
  STA $020b                   ; $0203 + 8 = player_x 

  ; middle right tile (x + 8, y + 8)
  LDA player_y                ; A = player_y
  CLC                         ; Clear the carry bit.
  ADC #$08                    ; A = player_y + 8
  STA $020c                   ; $0200 + 12 = player_y + 8
  LDA player_x                ; A = player_x
  CLC                         ; Clear the carry bit.
  ADC #$08                    ; A = player_x + 8
  STA $020f                   ; $0203 + 12 = player_x  + 8

  ; bottom left tile (y + 16):
  LDA player_y                ; A = player_y
  CLC                         ; Clear the carry bit.
  ADC #$10                    ; A = player_y + 16
  STA $0210                   ; $0200 + 16 = player_y + 16
  LDA player_x                ; A = player_x
  CLC                         ; Clear the carry bit.
  STA $0213                   ; $0203 + 16 = player_x

  ; bottom right tile (x + 8, y + 16)
  LDA player_y                ; A = player_y
  CLC                         ; Clear the carry bit.
  ADC #$10                    ; A = player_y + 16
  STA $0214                   ; $0200 + 20 = player_y + 16
  LDA player_x                ; A = player_x
  CLC                         ; Clear the carry bit.
  ADC #$08                    ; A = player_x + 8
  STA $0217                   ; $0203 + 20 = player_x + 8

  ; Restore the registers and return.
exit:
  PLA                       ; Restore the Y register.
  TAY                       ; Transfer A -> Y register.
  PLA                       ; Restore the X register.
  TAX                       ; Transfer A -> X register.
  PLA                       ; Restore the accumulator register.
  PLP                       ; Restore the processor status register.
  RTS                       ; Return to original context.
.endproc