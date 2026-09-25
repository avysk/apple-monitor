;;; Output subroutines

; Output a character in the accumulator using routine with address
; in $36 and $37
COUT    EQU     $FDED

; Output a character in the accumulator to the current position on the screen,
; and advance the cursor. Return, line feed, bell, and control characters are
; handled properly.
; All registers are preserved.
COUT1   EQU     $FDF0

; Set inverse output mode for COUT1.
; A and X are preserved, $3F -> Y.
SETINV  EQU     $FE80

; Set normal output mode for COUT1.
; A and X are preserved, $FF -> Y.
SETNORM EQU     $FE84

; Send "return" to the current output device.
CROUT   EQU     $FD8E

; Clear the current line from the current cursor position to the end of the
; line. Then call CROUT.
CROUT1  EQU     $FD8B

; Output a hexadecimal representation of the value in the accumulator.
; A is corrupted.
PRBYTE  EQU     $FDDA

; Output a hexadecimal representation of the low nibble of A.
; A is corrupted.
PRHEX   EQU     $FDE3

; Output a hexadecimal representation of the value in the A and X registers as
; a 4-digit hexadecimal number.
; A is corrupted.
PRNTAX  EQU     $F941

; Output three spaces.
; A is corrupted, $00 -> X.
PRBLNK  EQU     $F948

; Output a number of spaces equal to the value in the X register (0 means 256).
; A is corrupted, $00 -> X.
PRBL2   EQU     $F94A

; Sends "bell" to the current output device.
; $87 -> A.
BELL    EQU     $FF3A

; Beep the speaker for 1 second.
; A and X are corrupted.
BELL1   EQU     $FBDD

;;; Input subroutines

; Put a flashing input cursor at the current position of output cursor and uses
; subroutine with address in $38 and $39 (usually KEYIN) to read a character.
RDKEY   EQU     $FD0C

; Alternative input routine that reads a character from the standard input but
; also interprets some escape codes
RDCHAR  EQU     $FD35

; Read a character from keyboard (will be returned in A) and also removes a
; flashing input cursor and randomizes the random number seed
KEYIN   EQU     $FD1B

; Input a line. The prompt character must be in the location $33. The line is
; written to the buffer starting at $200. X will hold the length of the input
; line
GETLN   EQU     $FD6A

; Issue a carriage return and then call GETLN.
GETLNZ  EQU     $FD67

; Same as GETLN, but the prompt character is not used
GETLN1  EQU     $FD6F

;;; Low-Res graphic subroutines

; Sets the low-res graphics color to the value in the accumulator.
SETCOL  EQU     $F864

; Increment the low-res graphics color by 3
NEXTCOL EQU     $F85F

; Plot a block on a low-res screen. The vertical position is taken from A, the
; horizontal one from Y
; A is corrupted, X and Y are preserved.
PLOT    EQU     $F800

; Draw a horizontal line of blocks on a low-res screen. The vertical position
; is taken from A, the left horizontal one from Y, the right from localion @2C
; A and Y are corrupted, X is preserved.
HLINE   EQU     $F819

; Draw a vertical line of blocks on a low-res screen. The horizontal position
; is taken from Y, the top vertical one from A, the bottom from localion @2D
; A is corrupted.
VLINE   EQU     $F828

; Clear the low-res screen. If the display is in text mode, it is filled with
; character @
; A and Y are desroyed.
CLRSCR  EQU     $F832

; Clear the top 40 rows of the low-res screen (works as CLRSCR otherwise)
CLRTOP  EQU     $F836

; Return the color of a block on the low-res screen. The vertical position is
; taken from A, the horizontal one from Y. The color is returned in A
; X and Y are preserved.
SCRN    EQU     $F871

;;; Hi-Res graphic subroutines

; Initiolize hi-res page 1 and clear and display screen
HGR     EQU     $F3E2

; Initiolize hi-res page 2 and clear and display screen
HGR2    EQU     $F3D8

; Clear the current screen to black1
HCLR    EQU     $F3F2

; Clear the current screen to the last plotted HCOLOR
BKGND   EQU     $F3F6

; Set the current HCOLOR to the contents of the X register (0-7)
HCOLOR  EQU     $F6F0

; Position the hi-res "cursor" to the position, specified in X, Y (low, high)
; horizontally and in A vertically
HPOSN   EQU     $F411

; Plot; as HPOSN but plot current HCOLOR at the position given
HPLOT   EQU     $F457

; Return the current "cursor" position.
; Horizontal coordinate is returned in $E0, $E1 (low, high) and vertical
; coordinate is returned in $E2
HFIND   EQU     $F5CB

; Draw a line from the previous plot to the point given. The horizontal
; coordinate should be set in A, X (low, high) and vertical in Y
HLIN    EQU     $F53A

; Puts the address of the shape number indicated by X into $1A, $1B.
; X, Y (low, high) are also set to this address.
; see DRAW and XDRAW
SHNUM   EQU     $F730

; Draw a shape pointed to by X, Y (low, high) in the current HCOLOR. Use SHNUM
; first to set X and Y
DRAW    EQU     $F601

; Erase a shape by drawing it using XOR. Otherwise works like DRAW.
XDRAW   EQU     $F65D

;;; Other subroutines

; For the given value of the accumulator, sleep 1/4 (26+27*A+5*A*A) miliseconds
; X and Y are preserved, $0 -> A.
WAIT    EQU     $FCA8

; Read value of a game controller (0-3) whose number is passed in X. A number
; from $00 to $FF is returned in Y
; A is corrupted
PREAD   EQU     $FB1E

; Print "ERR" and a bell to the standard output device
; A is corrupted
PRERR   EQU     $FF2D

; Save registers A-X-Y-P-S in locations $45-$49
IOSAVE  EQU     $FF4A

; Restore registers A-X-Y-P-S from locations $45-$49
IOREST  EQU     $FF3F
