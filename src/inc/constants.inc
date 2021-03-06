; PPU Constants
;
; The Picture-Processing Unit (PPU) is TL;DR: the GPU.
;

PPU_CTRL        = $2000         ; Controls PPU rendering.
                                ; 7 (MSB)   Trigger NMI every frame.
                                ; 6         
                                ; 5         
                                ; 4         Sprite pattern table     
                                ; 3         
                                ; 2         
                                ; 1         
                                ; 0 (LSB)   
PPU_MASK        = $2001         ; Instructs PPU on how to draw.
                                ; 7 (MSB)   Emphasize Blue channel.
                                ; 6         Emphasize Green channel.
                                ; 5         Emphasize Red channel.
                                ; 4         Enable foreground.
                                ; 3         Enable background.
                                ; 2         Enable foreground Left edge (8px).
                                ; 1         Enable background Left edge (8px).
                                ; 0 (LSB)   Enable greyscale mode.
PPU_STATUS      = $2002         ; (RO) PPU status, resets PPUADDR address latch.
PPU_SPR_ADDR    = $2003         ;
PPU_SPR_DATA    = $2004         ;
PPU_SCROLL      = $2005         ;
PPU_ADDR        = $2006         ; Select address in PPU memory to write PPUDATA.
PPU_DATA        = $2007         ; Data to write at PPUADDR in PPU memory.

; PPU_MASK Preset Constants
;
; These are values used to set different modes for PPU_MASK.
;

MASK_RESET      = %00000000     ; Disable everything.
MASK_STANDARD   = %00011110     ; Enable FG/BG/LEFG/LEBG.

; PPU_CTRL Preset Constants
;
; These are values used to set different modes for PPU_CTRL.
;

CTRL_RESET      = %00000000     ; Disable everything.
CTRL_STANDARD   = %10010000     ; Enable NMI, sprites use first pattern table.

; OAM Constants
;
; Object Attribute Memory (OAM) is where sprites are stored.
;

OAM_ADDR    = $2003         ; Select address in OAM memory to write.
OAM_DMA     = $4014         ; (WO) Initiate writing a page to OAM DMA.

; Vector Location Constants
;

VECTOR_NMI    = $FFFA       ; Non-Maskable Interrupt (NMI) Handler
VECTOR_RST    = $FFFC       ; Reset (RST) Handler 
VECTOR_IRQ    = $FFFE       ; Interrupt Request (IRQ) Handler

; Color Constants
;
; Only the 52 unique/safe colors (of 64 possible) are included.
;
; We exclude:
; - "forbidden greyscale" ($0D, $1D, $2D, $3D)
; - the white at $20 (identical to $30)
; - all blacks identical to $0F ($0E*, $1F, $2F, $3F)
;
; The columns run:
; - $x0: Gray
; - $x1: Azure
; - $x2: Blue
; - $x3: Violet
; - $x4: Magenta
; - $x5: Rose
; - $x6: Red or maroon
; - $x7: Orange
; - $x8: Yellow or olive
; - $x9: Chartreuse
; - $xA: Green
; - $xB: Spring
; - $xC: Cyan
;
; The scale runs from 0-3, dark/medium/light/pale.
;

BLACK               = $0F       ; Classic black
WHITE               = $30       ; Classic white
DARK_GRAY           = $00       ; e.g. _Dragon Quest_ mountains
LIGHT_GRAY          = $10       ; e.g. _Dragon Quest_ mountains
DARK_AZURE          = $01       ; e.g. _Final Fantasy_ menu
MEDIUM_AZURE        = $11       ; e.g. _Dragon Quest_ water/sky
LIGHT_AZURE         = $21       ; e.g. _Final Fantasy_ sea
PALE_AZURE          = $31       ; e.g. _Final Fantasy_ sea
DARK_BLUE           = $02       ; 
MEDIUM_BLUE         = $12       ; e.g. _Dragon Quest_ blue armor
LIGHT_BLUE          = $22       ; e.g. _Super Mario Bros._ blue sky
PALE_BLUE           = $32       ;
DARK_VIOLET         = $03       ;
MEDIUM_VIOLET       = $13       ;
LIGHT_VIOLET        = $23       ;
PALE_VIOLET         = $33       ;
DARK_MAGENTA        = $04       ;
MEDIUM_MAGENTA      = $14       ;
LIGHT_MAGENTA       = $24       ;
PALE_MAGENTA        = $34       ;
DARK_ROSE           = $05       ; 
MEDIUM_ROSE         = $15       ; 
LIGHT_ROSE          = $25       ;
PALE_ROSE           = $35       ; e.g. _Dragon Quest_ common skin
DARK_RED            = $06       ; e.g. _Donkey Kong_ brown
MEDIUM_RED          = $16       ; e.g. _Super Mario Bros._ red
LIGHT_RED           = $26       ;
PALE_RED            = $36       ; e.g. _Super Mario Bros._ Mario's skin
DARK_ORANGE         = $07       ;
MEDIUM_ORANGE       = $17       ; e.g. _Donkey Kong_ barrels
LIGHT_ORANGE        = $27       ; e.g. _Donkey Kong_ Pauline yellow
PALE_ORANGE         = $37       ; e.g. _Legend of Zelda_ ground
DARK_OLIVE          = $08       ;
MEDIUM_OLIVE        = $18       ; e.g. _Final Fantasy_ monk hair
LIGHT_OLIVE         = $28       ; e.g. _Final Fantasy_ monk skin
PALE_OLIVE          = $38       ; e.g. _Mega Man_ Rockman face
DARK_CHARTREUSE     = $09       ;
MEDIUM_CHARTREUSE   = $19       ; e.g. _Super Mario Bros._ Luigi
LIGHT_CHARTREUSE    = $29       ; e.g. _Legend of Zelda II_ Link
PALE_CHARTREUSE     = $39       ;
DARK_GREEN          = $0A       ;
MEDIUM_GREEN        = $1A       ; e.g. _Final Fantasy_ foliage
LIGHT_GREEN         = $2A       ; e.g. _Legend of Zelda II_ Link
PALE_GREEN          = $3A       ;
DARK_SPRING         = $0B       ;
MEDIUM_SPRING       = $1B       ; 
LIGHT_SPRING        = $2B       ; 
PALE_SPRING         = $3B       ;
DARK_CYAN           = $0C       ; e.g. _Dragon Quest_ slime
MEDIUM_CYAN         = $1C       ; 
LIGHT_CYAN          = $2C       ; 
PALE_CYAN           = $3C       ;

; Positional Constants
;
; The NES has 256 columns but only 240 rows.
;

X_MAX               = $ff       ; 256 columns.
Y_MAX               = $ef       ; 240 rows.
X_MAX_SPRITE        = $e0       ; This is the rightmost X coordinate of the
                                ; sprite (256 - 16).
Y_MAX_SPRITE        = $d0       ; This is the bottommost Y coordinate of the
                                ; sprite (240 - 16).
X_MIN_SPRITE        = $10       ; This is the leftmost X coordinate of the
                                ; sprite (0 + 16).
Y_MIN_SPRITE        = $10       ; This is the topmost Y coordinate of the
                                ; sprite (0 + 16).

; Input/Output Constants
;
;
;

IO_PLAYER1          = $4016       ; Player One controller.
IO_PLAYER2          = $4017       ; Player Two controller.
IO_PLAYER_A         = %10000000   ; Button A.
IO_PLAYER_B         = %01000000   ; Button B.
IO_PLAYER_SELECT    = %00100000   ; Select.
IO_PLAYER_START     = %00010000   ; Start.
IO_PLAYER_UP        = %00001000   ; Up.
IO_PLAYER_DOWN      = %00000100   ; Down.
IO_PLAYER_LEFT      = %00000010   ; Left.
IO_PLAYER_RIGHT     = %00000001   ; Right.
