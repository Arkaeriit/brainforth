\ #IR std+.frt
\ #IR arguments.frt
\ #IR debug.frt

0 CONSTANT R/O
8 BASE ! 664 CONSTANT W/O DECIMAL

\ Importing definitions
: open-def ( -- fileid ) S" /usr/share/brainforth/symbols.frt" R/O OPEN-FILE IF DROP S" /usr/local/share/brainforth/symbols.frt" R/O OPEN-FILE IF DROP S" symbols.frt" R/O OPEN-FILE IF S" Error : symbol file not found" error-exit THEN THEN THEN ;
: output-def ( filedid -- ) open-def SWAP copy-file ;
: begin-bfk ( fileid -- ) S" : MAIN ( -- ) " ROT WRITE-FILE DROP ;
: end-bfk ( fileid -- ) DUP DUP DUP 59 SWAP WRITE-CHAR DROP 10 SWAP WRITE-CHAR DROP S" MAIN" ROT WRITE-FILE DROP 10 SWAP WRITE-CHAR DROP ;

\ Reading the brainfuck input file
: printable-char ( char -- bool ) 8 XDUP 91 = >R 93 = >R 60 = >R 62 = >R 46 = >R 44 = >R 43 = >R 45 = >R 10 = R> R> R> R> R> R> R> R> 8 0 DO OR LOOP ;
: process-char ( fileid char -- ) DUP printable-char IF OVER WRITE-CHAR DROP 32 SWAP WRITE-CHAR DROP ELSE DROP DROP THEN ;
: loop-file ( filein fileout -- ) OVER READ-CHAR BEGIN 0= WHILE OVER SWAP process-char OVER READ-CHAR REPEAT DROP DROP ;

\ Tests
: test1 ( -- ) S" out.frt" W/O CREATE-FILE DROP DUP DUP output-def begin-bfk end-bfk CLOSE-FILE ;
: test2 ( -- ) S" in.bfk" R/O OPEN-FILE DROP S" out.frt" W/O CREATE-FILE DROP 2DUP loop-file CLOSE-FILE CLOSE-FILE ;
