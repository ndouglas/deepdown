; Zero-Page Data
;
; The best place to store commonly-used variables.  We only have 256 bytes 
; here, though, so we gotta make it count!

.segment "ZEROPAGE"
player_x: .res 1                ; Reserve a byte for the player's X coordinate.
player_y: .res 1                ; Reserve a byte for the player's Y coordinate.
player_dir: .res 1              ; The direction in which the player is moving.
player_sprite: .res 1           ; The first tile of the player's current sprite.

.exportzp player_x              ; Export player_x byte.
.exportzp player_y              ; Export player_y byte.
.exportzp player_dir            ; Export player_dir byte.
.exportzp player_sprite         ; Export player_sprite byte.
