\ #IR std+.frt
\ #IR arguments.frt
\ #IR debug.frt

0 CONSTANT R/O
8 BASE ! 664 CONSTANT W/O DECIMAL

\ Importing definitions
: open-def ( -- fileid ) S" /usr/share/brainforth/symbols.frt" R/O OPEN-FILE IF DROP S" /usr/local/share/brainforth/symbols.frt" R/O OPEN-FILE IF DROP S" symbols.frt" R/O OPEN-FILE IF S" Error : symbol file not found" error-exit THEN THEN THEN ;
: output-def ( filedid -- ) open-def SWAP copy-file ;

\ Tests
: test1 ( -- ) "out.frt" W/O CREATE-FILE DROP output-def CLOSE-FILE ;
