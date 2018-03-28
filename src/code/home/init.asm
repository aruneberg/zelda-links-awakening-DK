;
; Game entry point.
;

; After the boot ROM code is done executing, control
; is transfered to address $100, which immediatly jumps here.
; (See header.asm)
Start::
    ; Switch CPU to double-speed if needed
    cp   GBC ; is running on Game Boy Color?
    jr   nz, .notGBC
    ld   a, [rKEY1]
    and  $80 ; do we need to switch the CPU speed?
    jr   nz, .speedSwitchDone
    ld   a, $30      ; \
    ld   [rP1], a  ; |
    ld   a, $01      ; |
    ld   [rKEY1], a  ; | Switch the CPU speed
    xor  a           ; |
    ld   [rIE], a    ; |
    stop             ; /

.speedSwitchDone
    xor  a
    ld   [rSVBK], a
    ld   a, $01 ; isGBC = true
    jr   Init

.notGBC
    xor  a ; isGBC = false

Init::
    ldh  [hIsGBC], a ; Save isGBC value
    call LCDOff      ; Turn off screen
    ld   sp, $DFFF   ; Init stack pointer

    ; Call 003C:6A22
    ld   a, $3C
    ld   [MBC3SelectBank], a
    call label_6A22

    ; Clear registers
    xor  a
    ld   [rBGP], a
    ld   [rOBP0], a
    ld   [rOBP1], a

    ; Clear Tiles Map 0
    ld   hl, vTiles0
    ld   bc, $1800
    call ClearBytes

    ; Clear Tiles Map 1 (if GBC)
    ld   a, $24
    ld   [MBC3SelectBank], a
    call ClearTilesMap1

    ; Clear Background Map
    call ClearBGMap
    call ClearHRAMAndWRAM

    ; Copy DMA routine to HRAM
    ld   a, $01
    ld   [MBC3SelectBank], a
    call WriteDMACodeToHRAM

    ; Initiate DMA transfer
    call hDMARoutine

    call LCDOn

    ; Load default tiles
    call LoadBank0CTiles

    ; Initialize LCD Status register
    ;   Bit 6: LYC coincidence interrupt enabled
    ;   Bit 5: Mode 2 OAM interrupt disabled
    ;   Bit 4: Mode 1 V-Blank interrupt disabled
    ;   Bit 3: Mode 0 H-Blank interrupt disabled
    ;   Bit 2-0: read-only
    ld   a, %01000100
    ld   [rSTAT], a

    ; Initialize LY Compare register
    ; Request a STAT interrupt when LY equals $4F
    ld   a, $4F
    ld   [rLYC], a

    ; Initialize wCurrentBank
    ld   a, $01
    ld   [wCurrentBank], a

    ; Initialize Interrupts
    ;   Bit 4: Joypad interrupt disabled
    ;   Bit 3: Serial interrupt disabled
    ;   Bit 2: Timer interrupt disabled
    ;   Bit 1: LCD STAT interrupt disabled
    ;   Bit 0: V-Blank interrupt enabled
    ld   a, %00001
    ld   [rIE], a

    ; Initialize save files
    call InitSaveFiles

    ; Initialize sound
    ; (calls 001F:4000)
    ld   a, $1F
    ld   [MBC3SelectBank], a
    call label_4000

    ; Ignore joypad input during 24 frames
    ld   a, 24
    ldh  [hButtonsInactiveDelay], a

    ; Enable interrupts
    ei

    ; If GBC, clear WRAM Bank 5
    ; (calls 20:4854)
    ld   a, $20
    ld   [MBC3SelectBank], a
    call label_4854

    ; Start rendering
    jp   WaitForNextFrame
