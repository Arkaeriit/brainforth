\ Debuguing words
\ Print th top of the stack
: .? DUP . ;
\ Print the top of the stack as a char
: .c? DUP EMIT SPACE ;
\ Print the two first element of the stack
: .?? 2DUP . . ;
\ Print the 3 first element on the stack
: .??? .? >R .? >R .? R> R> ;



: array-init ( size -- addr ) DUP HERE SWAP ALLOT DUP ROT 0 DO DUP 0 SWAP C! 1+ LOOP DROP ;
: brainfuck-init ( -- addr )1024 array-init ;

: [ ( addr -- addr ) POSTPONE BEGIN POSTPONE DUP POSTPONE C@ POSTPONE WHILE ;

: ] ( addr -- addr ) POSTPONE REPEAT ;

: . ( addr -- addr ) DUP C@ EMIT ;

: + ( addr -- addr ) DUP DUP C@ 1+ SWAP C! ;

: MAIN brainfuck-init + + + + + + + + + + + . ;
MAIN

