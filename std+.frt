\ The words in this file some quick utilities or are ment to do be some standards wordn not implemented in ciforth

\ READ-CHAR et WRITE-CHAR
\ #IR IOchar.frt

\ Copy the content of fileid1 into fileid2
: copy-file ( fileid1 fileid2 -- ) BEGIN 2DUP SWAP READ-CHAR DUP >R 0= IF SWAP WRITE-CHAR DROP ELSE THEN R> UNTIL 2DROP 2DROP ;

\ Some bad implementation of READ-LINE
\ ior is alway 0 and flag is 1 if we reached the end of the file
\ or 0 if we reached the end of a line first
: READ-LINE ( addr1 u1 fileid -- u2 flag ior ) 
0 ROT 0 DO  ( The stack is addr1 fileid u2 )
    SWAP DUP READ-CHAR IF DROP SWAP NIP NIP -1 0 UNLOOP EXIT THEN DUP 10 = IF DROP SWAP LEAVE THEN >R  ( The stack is now addr1 u2 fileID )
    SWAP 1+ ROT DUP R> SWAP C! 1+ ( the stack is fileid u2 addr1 and everything is up to date )
    ROT ROT 
LOOP SWAP DROP SWAP DROP 0 0 ;

\ compare two string, return 0 if there are equals. return 1 otherwize
: COMPARE ( addr1 u1 addr2 u2 -- n ) ROT 2DUP = IF 
    DROP 0 SWAP 0 DO
        DROP 2DUP C@ SWAP C@ = INVERT IF 1 LEAVE THEN 1+ SWAP 1+ 0 LOOP
    SWAP DROP SWAP DROP
    ELSE 1 THEN ;

\ error-exit display a message to stderr and then quit the program
\ with the exit status -1
2 CONSTANT stderr
: error-exit ( addr u -- ) stderr WRITE-FILE -1 EXIT-CODE ! CR BYE ;

\ copy the content of addr1 to addr2 after reversing it 
: COPY.ROT ( addr1 arrd2 n  -- ) DUP ROT + 1- SWAP 0 DO 2DUP SWAP C@ SWAP C! 1- SWAP 1+ SWAP LOOP DROP DROP ;

\ integer exponentiation
: ** ( a b -- a^b ) ?DUP IF 1 SWAP 0 DO OVER * LOOP SWAP DROP ELSE DROP 1 THEN ;

\ convert a char to it's numeric value
: digit ( char -- n ) DUP 58 < IF 48 - ELSE 65 - THEN ;
\ convert a string representing a number right to left and convert it to a number
: (myNum) ( addr n -- n' ) 0 SWAP 0 DO SWAP DUP C@ SWAP 1+ SWAP ROT SWAP digit BASE @ I ** * + LOOP SWAP DROP ;
CREATE myNumBuff 100 ALLOT
\ convert a string to a number
: myNum ( addr n -- n' ) DUP ROT SWAP myNumBuff SWAP COPY.ROT myNumBuff SWAP (myNum) ;
CREATE str 100 ALLOT

