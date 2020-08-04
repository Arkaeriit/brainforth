\ Starting the environement
: array-init ( size -- addr ) DUP HERE SWAP ALLOT DUP ROT 0 DO DUP 0 SWAP C! 1+ LOOP DROP ;
: brainfuck-init ( -- addr ) 1024 array-init ;

\ Definig brainfuck symbols as forth words
: [ ( addr -- addr ) POSTPONE BEGIN POSTPONE DUP POSTPONE C@ POSTPONE WHILE ; IMMEDIATE
: ] ( addr -- addr ) POSTPONE REPEAT ; IMMEDIATE
: . ( addr -- addr ) DUP C@ EMIT ;
: , ( addr -- addr ) DUP KEY SWAP C! ;
: + ( addr -- addr ) DUP DUP C@ 1+ SWAP C! ;
: - ( addr -- addr ) DUP DUP C@ 1- SWAP C! ;
: > ( addr -- addr+1 ) 1+ ; 
: < ( addr -- addr-1 ) 1- ; 

