\ #IR std+.frt
\ #IR arguments.frt
\ #IR debug.frt

0 CONSTANT R/O
8 BASE ! 664 CONSTANT W/O DECIMAL

\ Importing definitions
: open-def ( -- fileid ) S" /usr/share/brainforth/symbols.frt" R/O OPEN-FILE IF DROP S" /usr/local/share/brainforth/symbols.frt" R/O OPEN-FILE IF DROP S" symbols.frt" R/O OPEN-FILE IF S" Error : symbol file not found" error-exit THEN THEN THEN ;
: output-def ( filedid -- ) open-def SWAP copy-file ;
: begin-bfk ( fileid -- ) S" : MAIN ( -- ) brainfuck-init " ROT WRITE-FILE DROP ;
: end-bfk ( fileid -- ) S" ; 
MAIN
" ROT WRITE-FILE DROP ;

\ Reading the brainfuck input file
: printable-char ( char -- bool ) 8 XDUP 91 = >R 93 = >R 60 = >R 62 = >R 46 = >R 44 = >R 43 = >R 45 = >R 10 = R> R> R> R> R> R> R> R> 8 0 DO OR LOOP ;
: process-char ( fileid char -- ) DUP printable-char IF OVER WRITE-CHAR DROP 32 SWAP WRITE-CHAR DROP ELSE DROP DROP THEN ;
: loop-file ( filein fileout -- ) OVER READ-CHAR BEGIN 0= WHILE OVER SWAP process-char OVER READ-CHAR REPEAT DROP DROP DROP ;

\ Interface
\ Print help message
: help ( -- ) ." Message todo" ;
\ Check that the correct number of arguments is given
: testArgs ( -- ) argc 1 = IF help THEN argc 3 = INVERT IF S" Error : invalid argument number." error-exit THEN ;
\ Open the two input files given as arguments and check if everything is OK
: init-files ( -- fileid1 fileid2 ) 1 arg R/O OPEN-FILE 2 arg W/O CREATE-FILE ROT OR IF S" Error : argument files can't be read." error-exit THEN ;
: MAIN ( -- ) testArgs 42 init-files 2DUP DUP output-def DUP begin-bfk loop-file DUP end-bfk CLOSE-FILE CLOSE-FILE 2DROP ;

