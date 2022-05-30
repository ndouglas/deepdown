; Draw Player
;
; This procedure draws the player sprite.

.include "../inc/constants.inc"

.importzp player_x          ; Import player_x byte.
.importzp player_y          ; Import player_y byte.
.importzp player_sprite     ; Import player_sprite byte.
.importzp player_dir        ; Import player_dir byte.

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

; Calculate the direction of movement.
get_direction:
  LDA player_dir                     ; A = player_dir
  CMP #$01                           ; If player_dir == 1...
  BEQ set_tiles_r_pre                ; ...player is moving right.
                                     ; Fall through.

; Draw player tiles.
  LDX #$00                          ; X = 00
  LDA player_sprite                 ; A = player_sprite
set_tiles_l:
  STA $0201                         ; ... goes in $0201.
  CLC                               ; Clear carry bit.
  ADC #$01                          ; Increment A.
  STA $0205                         ; ... goes in $0205.
  CLC                               ; Clear carry bit.
  ADC #$01                          ; Increment A.
  STA $0209                         ; ... goes in $0209.
  CLC                               ; Clear carry bit.
  ADC #$01                          ; Increment A.
  STA $020d                         ; ... goes in $020d.
  CLC                               ; Clear carry bit.
  ADC #$01                          ; Increment A.
  STA $0211                         ; ... goes in $0211.
  CLC                               ; Clear carry bit.
  ADC #$01                          ; Increment A.
  STA $0215                         ; ... goes in $0215.
  JMP set_flags_l                   ; Set the sprite palette.

; Draw player tiles.
set_tiles_r_pre:       
  LDX #$00                          ; X = 00
  LDA player_sprite                 ; A = player_sprite (#$05)
set_tiles_r:       
  CLC                               ; Clear carry bit.
  ADC #$01                          ; Increment A. (#$06)
  STA $0201                         ; ... goes in $0201.
  SEC                               ; Set carry bit.
  SBC #$01                          ; Decrement A. (#$05)
  STA $0205                         ; ... goes in $0205.
  CLC                               ; Clear carry bit.
  ADC #$03                          ; Add 3 to A.  (#$08)
  STA $0209                         ; ... goes in $0209.
  SEC                               ; Set carry bit.
  SBC #$01                          ; Decrement A. (#$07)
  STA $020d                         ; ... goes in $020d.
  CLC                               ; Clear carry bit.
  ADC #$03                          ; Add 3 to A. (#$0A)
  STA $0211                         ; ... goes in $0211.
  SEC                               ; Set carry bit.
  SBC #$01                          ; Decrement A. (#$09)
  STA $0215                         ; ... goes in $0215.
  JMP set_flags_r                   ; Set the sprite palette.

; Special attribute flags:
; 7 (MSB)     Flips sprite vertically (if 1)
; 6           Flips sprite horizontally (if 1)
; 5           Sprite priority (behind background if 1)
; 4-2         Not used
; 1-0 (LSB)   Sprite palette

set_flags_l:
  LDA #$00
  STA $0202
  STA $0206
  STA $020a
  STA $020e
  STA $0212
  STA $0216
  JMP draw_sprite   ; Set the player tile locations.

set_flags_r:
  LDA #%01000000                    ; Flip the sprite horizontally.
  STA $0202
  STA $0206
  STA $020a
  STA $020e
  STA $0212
  STA $0216
                                    ; Fall through.

  ; Write player tile locations.
draw_sprite:
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