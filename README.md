# minimax8085-keypad-vfd
Keypad and VFD extension board for the MiniMax 8085 SBC

![MiniMax8085 with Keypad and VFD](images/MiniMax8085-Keypad_and_VFD.jpg)

## Hardware Documentation

### Schematic and PCB Layout

[Schematic - Version 1.0](KiCad/MiniMax8085-Keypad-VFD-Schematic-1.0.pdf)

[PCB Layout - Version 1.0](KiCad/MiniMax8085-Keypad-VFD-Board-1.0.pdf)

### Design Description

#### Address Decode / Chip Select

The Keypad and VFD extension board uses 74HCT138 3-to-8 decoder and 74HCT32 quad 2-input OR gate ICs for address decode:
* Enable signal G1 of 74HCT138 is connected to IO/M signal, and therefore the decoder is enabled only during I/O operations, when IO/M signal value is HIGH
* Enable signals /G2A and /G2B of 74HCT138 are connected to address lines A6 and A7, so that decoder is enabled when both of these signals are low - 0x00 - 0x3F address range
* Inputs A-C of 74HCT138 are connected to address lines A3 - A4, therefore each output of 74HCT138 is active (LOW) for a block of 8 consequitive I/O addresses, /Y0 - for 0x00-0x07, /Y1 - for 0x08-0x0F, ... , /Y6 for 0x30-0x37, and /Y6 for 0x38-0x3F
* Output /Y6 of 74HCT138 is connected to the input of the OR gate U3C, another input of that gate is connected to /RD signal. As the result, the output of the gate U3C - /KPD_RD is active (LOW) during read cycles from 0x30-0x37 I/O range. /KPD_RD is used as the read signal for the keypad encoder
* Output /Y7 of 74HCT138 is connected to inputs of the OR gate U3A and U3B. The second input of the OR gate U3B is connected to /RD signal, so that the output of U3B - /VFD_RD is active (LOW) during read cycles from 0x38-0x3F I/O range. /VFD_RD is used as the read signal for the VFD module. The second input of the OR gate U3A is connected to /WR signal, so that the output of U3A - /VFD_WR is active (LOW) during write cycles to 0x38-0x3F I/O range. /VFD_WR is used as the write signal for the VFD module

#### VFD Interface

The VFD is configured in Intel 8000 mode (using a solder link on the module), and the interface is staright-forward:
* Data lines DB0-DB7 of the VFD modules are connected to AD0-AD7 signals
* Register select input RS of the VFD module is connected to address line A0, therefore writing to even addresses in 0x38-0x3F range, writes the command register, while writing or reading odd addresses goes to DDRAM (display memory) or CGRAM (character generator memory)
* /RD and /WR inputs of the VFD module are connected to /VFD_RD and /VFD_WR signals respectfully

#### Keypad Interface

The Keypad and VFD extension board uses 74C923 20-key encoder for scanning the keypad. When this IC detects that a keypad button has been pressed, it activates D_AVAIL output, connected to the RST7_5 interrupt signal, resulting in an interrupt to the 8085 CPU. The interrupt service routine can then read the keypad button code from I/O ports in range 0x30-0x37. Only AD0-AD5 data lines are used, therefore the 0x1F AND mask should be applied by the interrupt service routine to the value read from the port.

### Bill of Materials

#### Version 1.0

[MiniMax8085 Keypad and VFD project on Mouser.com](https://www.mouser.com/ProjectManager/ProjectDetail.aspx?AccessID=7fc9d2ae6d) - View and order all components except of the PCB, the VFD module, and the 74C923 20-key encoder.

[MiniMax8085 Keypad and VFD project on OSH Park](https://oshpark.com/shared_projects/jRaDS2Pu) - View and order the PCB.

Component type     | Reference  | Description                                 | Quantity | Possible sources and notes 
------------------ | ---------- | ------------------------------------------- | -------- | --------------------------
PCB                |            | MiniMax 8085 VFD & Keypad PCB               | 1        | Order from a PCB manufacturer of your choice using provided Gerber or KiCad files
Integrated Circut  | U1         | 74C923 20-key encoder, DIP-20               | 1        | eBay
Integrated Circut  | U2         | 74HCT138 3-to-8 line decoder, DIP-16        | 1        | Mouser [595-SN74HCT138N](https://www.mouser.com/ProductDetail/595-SN74HCT138N)<br>Note: Possible replacements: 74LS138, 74HC138, 74ALS138
Integrated Circut  | U3         | 74HCT32 quad 2-input OR gate, DIP-14        | 1        | Mouser [595-SN74HCT32N](https://www.mouser.com/ProductDetail/595-SN74HCT32N)<br>Note: Possible replacements: 74LS32, 74HC32, 74ALS32
IC Socket          | U1         | DIP-20, 300 mil socket                      | 1        | Mouser [517-4820-3000-CP](https://www.mouser.com/ProductDetail/517-4820-3000-CP)
IC Socket          | U2         | DIP-16, 300 mil socket                      | 1        | Mouser [517-4816-3000-CP](https://www.mouser.com/ProductDetail/517-4816-3000-CP)
IC Socket          | U3         | DIP-14, 300 mil socket                      | 1        | Mouser [517-4814-3000-CP](https://www.mouser.com/ProductDetail/517-4814-3000-CP)
Tactile Switch     | SW1 - SW20 | 12x12mm tactile switch, projected type (Omron B3F-4050, Omron B3F-5050) | 20       | Mouser [653-B3F-4050](https://www.mouser.com/ProductDetail/653-B3F-4050), [653-B3F-5050](https://www.mouser.com/ProductDetail/653-B3F-5050)
Switch Key Tops    | SW1 - SW16 | 12x12mm keycap, gray (Omron B32-1300)       | 16       | Mouser [653-B32-1300](https://www.mouser.com/ProductDetail/653-B32-1300)
Switch Key Tops    | SW17       | 12x12mm keycap, blue (Omron B32-1340)       | 1        | Mouser [653-B32-1340](https://www.mouser.com/ProductDetail/653-B32-1340)
Switch Key Tops    | SW18       | 12x12mm keycap, yellow (Omron B32-1330)     | 1        | Mouser [653-B32-1330](https://www.mouser.com/ProductDetail/653-B32-1330)
Switch Key Tops    | SW19       | 12x12mm keycap, red (Omron B32-1380)        | 1        | Mouser [653-B32-1380](https://www.mouser.com/ProductDetail/653-B32-1380)
Switch Key Tops    | SW20       | 12x12mm keycap, green (Omron B32-1350)      | 1        | Mouser [653-B32-1350](https://www.mouser.com/ProductDetail/653-B32-1350)
Header             | P1         | 2x20 pin header, 2.54 mm pitch, straight    | 1        | Mouser [649-67996-140HLF](https://www.mouser.com/ProductDetail/649-67996-140HLF)<br>Note: This header is soldered to the MiniMax 8085 Keypad and VFD board
Header             | P1         | 2x20 socket, 2.54 mm pitch                  | 1        | Mouser [517-929852-01-20-RB](https://www.mouser.com/ProductDetail/517-929852-01-20-RB)<br>Note: This socket is assembled to the MiniMax 8085 board
Header             | P2         | 2x7 pin header, 2.54 mm pitch, right angle  | 1        | Mouser [649-68020-114HLF](https://www.mouser.com/ProductDetail/649-68020-114HLF)
Capacitor          | C1 - C4    | 0.1 µF, MLCC, 5 mm lead spacing             | 4        | Mouser [594-K104K15X7RF53H5](https://www.mouser.com/ProductDetail/594-K104K15X7RF53H5)
Capacitor          | C5         | 1 µF, MLCC, 5 mm lead spacing               | 1        | Mouser [810-FG28X5R1H105KRT0](https://www.mouser.com/ProductDetail/810-FG28X5R1H105KRT0)
Capacitor          | C6         | 10 µF, MLCC, 5 mm lead spacing              | 1        | Mouser [810-FG24X7R1A106KRT0](https://www.mouser.com/ProductDetail/810-FG24X7R1A106KRT0)
VFD Display        |            | 2x24 VFD character display                  | 1        | SurplusGizmos.com [CU24025ECPB-W1J](http://www.surplusgizmos.com/Noritake-Itron-CU24025ECPB-W1J-VFD-Display-Module-2x24-charectors-HD44780_p_2103.html)<br>Note: Can be substituted with other VFD or LCD modules. The module must support Intel i80xx mode.
Header             |            | 2x7 pin header, 2.54 mm pitch, straight     | 1        | Mouser [649-67996-114HLF](https://www.mouser.com/ProductDetail/649-67996-114HLF)<br>Note: Solder this header to the VFD module
Connector          |            | 2x7 pin IDC socket, 2.54 mm pitch           | 2        | Mouser [517-D89114-0131HK](https://www.mouser.com/ProductDetail/517-D89114-0131HK)
Cable              |            | 14 wire ribbon cable, 28AWG                 | 1 ft.    | Mouser [517-3365-14FT](https://www.mouser.com/ProductDetail/517-3365-14FT)

## Programming Keypad and VFD Extension Board

### Keypad and VFD Sample Code

This program echoes pressed keypad keys on the console and VFD display

<pre><code>
; Input keys from keypad and display them on VFD
; It assumed that the code runs from RAM under MON85
; Use the following MON85 commands to run the code:
; U 8000
; G 8040

; USART registers
USART_DATA     EQU     08h
USART_CMD      EQU     09h
; Keypad and VFD registers
KEYPAD_DATA    EQU     30h
VFD_CMD        EQU     38h
VFD_DATA       EQU     39h

;Assembly                                Address  Opcode

; RST75 - RST 7.5 Hardware interrupt vector
RST75:          JMP     KEYPAD_ISR      ; 803C    C3 60 80
                NOP                     ; 803F    00
; Initialize VFD display
START:          MVI     A,06H           ; 8040    3E 06
                OUT     VFD_CMD         ; 8042    D3 38
                MVI     A,0FH           ; 8044    3E 0F
                OUT     VFD_CMD         ; 8046    D3 38
                MVI     A,80H           ; 8048    3E 80
                OUT     VFD_CMD         ; 804A    D3 38
; Unmask RST 7.5
                MVI     A,1BH           ; 804C    3E 1B
                SIM                     ; 804E    30
; Enable interrupts
                EI                      ; 804F    FB
; Loop - wait for ESC key
ESC_WAIT:       IN      USART_CMD       ; 8050    DB 09
; Wait for RxRDY
                ANI     02H             ; 8052    E6 02
                JZ      ESC_WAIT        ; 8054    CA 50 80
                IN      USART_DATA      ; 8057    DB 08
; Is it ESC?
                CPI     1BH             ; 8059    FE 1B
                JNZ     ESC_WAIT        ; 805B    C2 50 80
; Exit to MON85
                RST     0               ; 805E    C7
                NOP                     ; 805F    00

; Keypad interrupt service routine                
KEYPAD_ISR:     PUSH PSW                ; 8060    F5
                IN      KEYPAD_DATA     ; 8061    DB 30
; Keypad outputs only lower 5 bits, reset higher bits
                ANI     1FH             ; 8063    E6 1F
; Convert to ASCII / Hexadecimal
                ADI     30H             ; 8065    C6 30
; Is it a digit (0-9)?
                CPI     3AH             ; 8067    FE 3A
                JC      PRINT_CHAR      ; 8069    DA 6E 80
; Otherwise show a letter (A-J)
                ADI     07H             ; 806C    C6 07
PRINT_CHAR:     PUSH    PSW             ; 806E    F5
; Wait for TxRDY
USART_WAIT:     IN      USART_CMD       ; 806F    DB 09
                ANI     01H             ; 8071    E6 01
                JZ      USART_WAIT      ; 8073    CA 6F 80
                POP     PSW             ; 8076    F1
; Write character to USART
                OUT     USART_CMD       ; 8077    D3 08
; Write charatcer to VFD
                OUT     VFD_DATA        ; 8079    D3 39
                POP     PSW             ; 807B    F1
; Re-enable interrupts
                EI                      ; 807C    FB
                RET                     ; 807D    C9
</code></pre>
