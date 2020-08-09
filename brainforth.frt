\ #IR std+.frt
\ #IR arguments.frt

0 CONSTANT R/O
8 BASE ! 664 CONSTANT W/O DECIMAL

\ Importing definitions
\ Try to inport the definitions neeed to convert brainfuck into Forth
: open-def ( -- fileid ) S" /usr/share/brainforth/symbols.frt" R/O OPEN-FILE IF DROP S" /usr/local/share/brainforth/symbols.frt" R/O OPEN-FILE IF DROP S" symbols.frt" R/O OPEN-FILE IF S" Error : symbol file not found" error-exit THEN THEN THEN ;
\ Put the oppened definitions in the output file
: output-def ( filedid -- ) open-def SWAP copy-file ;
\ Wrap the brainfuck program to make it compilable
: begin-bfk ( fileid -- ) DUP S" : MAIN ( -- ) brainfuck-init " ROT WRITE-FILE DROP 10 SWAP WRITE-CHAR DROP ;
: end-bfk ( fileid -- ) DUP DUP DUP 59 SWAP WRITE-CHAR DROP 10 SWAP WRITE-CHAR DROP S" MAIN" ROT WRITE-FILE DROP 10 SWAP WRITE-CHAR DROP ;

\ Reading the brainfuck input file
\ Chexk if a char is a new line or a brainfuck symbol
: printable-char ( char -- bool ) 8 XDUP 91 = >R 93 = >R 60 = >R 62 = >R 46 = >R 44 = >R 43 = >R 45 = >R 10 = R> R> R> R> R> R> R> R> 8 0 DO OR LOOP ;
\ inCode tell if the last charater was braifuck code or just comments
VARIABLE inCode
1 inCode !
: code-char ( fileid -- ) inCode @ IF DROP ELSE S"  ) " ROT WRITE-FILE DROP 1 inCode ! THEN ;
: comment-char ( fileid -- ) inCode @ IF S" ( " ROT WRITE-FILE DROP 0 inCode ! ELSE DROP THEN ;
\ Import a char to the output file
: process-char ( fileid char -- ) DUP printable-char 
    IF OVER code-char OVER WRITE-CHAR DROP 32 SWAP WRITE-CHAR DROP \ Writing the char then a space
    ELSE DUP 41 = IF DROP 93 THEN OVER comment-char SWAP WRITE-CHAR DROP THEN ; \ writting the chat if it is not a closing parenthesis
\ main loop
: loop-file ( filein fileout -- ) OVER READ-CHAR BEGIN 0= WHILE OVER SWAP process-char OVER READ-CHAR REPEAT DROP DROP DROP ;

\ Interface
\ Print help message
: help ( -- ) ." brainforth, a brainfuck to forth transpiler
Usage : brainforth <input file> <output file>" CR ;
\ Check that the correct number of arguments is given
: testArgs ( -- ) argc 1 = IF help THEN argc 3 = INVERT IF S" Error : invalid argument number." error-exit THEN ;
\ Open the two input files given as arguments and check if everything is OK
: init-files ( -- fileid1 fileid2 ) 1 arg R/O OPEN-FILE 2 arg W/O CREATE-FILE ROT OR IF S" Error : argument files can't be read." error-exit THEN ;
: MAIN ( -- ) testArgs init-files 2DUP DUP output-def DUP begin-bfk loop-file DUP end-bfk CLOSE-FILE CLOSE-FILE 2DROP ;

