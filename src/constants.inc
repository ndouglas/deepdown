; PPU Constants

PPU_CTRL    = $2000         ; Controls PPU rendering.
                            ; 7 (MSB)   Trigger NMI every frame
                            ; 6         
                            ; 5         
                            ; 4         
                            ; 3         
                            ; 2         
                            ; 1         
                            ; 0 (LSB)   
PPU_MASK    = $2001         ; Instructs PPU on how to draw.
                            ; 7 (MSB)   Emphasize Blue channel
                            ; 6         Emphasize Green channel
                            ; 5         Emphasize Red channel
                            ; 4         Foreground enable
                            ; 3         Background enable
                            ; 2         Left edge (8px) foreground enable
                            ; 1         Left edge (8px) background enable
                            ; 0 (LSB)   Greyscale mode enable
PPU_STATUS  = $2002         ; (RO) PPU status, resets PPUADDR address latch
PPU_ADDR    = $2006         ; Select address in PPU memory to write PPUDATA
PPU_DATA    = $2007         ; Data to write at PPUADDR in PPU memory

; Color Constants

; Only the 52 unique/safe colors (of 64 possible) are included.
; We exclude:
; - "forbidden greyscale" ($0D, $1D, $2D, $3D)
; - the white at $20 (identical to $30)
; - all blacks identical to $0F ($0E*, $1F, $2F, $3F)
; The columns run:
; $x0: Gray
; $x1: Azure
; $x2: Blue
; $x3: Violet
; $x4: Magenta
; $x5: Rose
; $x6: Red or maroon
; $x7: Orange
; $x8: Yellow or olive
; $x9: Chartreuse
; $xA: Green
; $xB: Spring
; $xC: Cyan
; The scale runs from 0-3, dark/medium/light/pale.

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