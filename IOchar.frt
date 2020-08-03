\ This file contain a few word to do io opperations char by char 
\ instead of doing it string by string or line by line

\ Basic functions
\ Those functions are the core of this lib and let you read ar write
\ a single char on a file.
VARIABLE IOCHAR_BUFF
: READ-CHAR ( fileid -- c ior ) IOCHAR_BUFF SWAP 1 SWAP READ-FILE SWAP 0= OR IOCHAR_BUFF C@ SWAP ;
: WRITE-CHAR ( c fileid -- ior ) SWAP IOCHAR_BUFF C! IOCHAR_BUFF SWAP 1 SWAP WRITE-FILE ;

\ #SI
\ Testiong function.
0 CONSTANT R/O
8 BASE ! 664 CONSTANT W/O DECIMAL
\ This function should print the start of this file
: TEST_IOCHAR_1 ( -- ) S" IOchar.frt" R/O OPEN-FILE DROP 15 0 DO DUP READ-CHAR DROP EMIT LOOP CLOSE-FILE CLOSE-FILE DROP ;
\ This function write a few stars to test1.out
: TEST_IOCHAR_2 ( -- ) S" test1.out" W/O CREATE-FILE DROP 15 0 DO DUP 42 SWAP WRITE-CHAR DROP LOOP CLOSE-FILE DROP ;
\ This function should write the start of this file to test2.out
: TEST_IOCHAR_3 ( -- ) S" IOchar.frt" R/O OPEN-FILE DROP S" test2.out" W/O CREATE-FILE DROP 15 0 DO 2DUP SWAP READ-CHAR DROP SWAP WRITE-CHAR DROP LOOP CLOSE-FILE DROP CLOSE-FILE DROP ;
: TEST_IOCHAR_SUITE TEST_IOCHAR_1 TEST_IOCHAR_2 TEST_IOCHAR_3 ;
TEST_IOCHAR_SUITE

