# minimax8085-keypad-vfd
Keypad and VFD extension board for the MiniMax 8085 SBC

![MiniMax8085 with Keypad and VFD](images/MiniMax8085-Keypad_and_VFD.jpg)

## Hardware Documentation

### Schematic and PCB Layout

[Schematic - Version 1.0](KiCad/MiniMax8085-Keypad-VFD-Schematic-1.0.pdf)

[PCB Layout - Version 1.0](KiCad/MiniMax8085-Keypad-VFD-Board-1.0.pdf)

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
