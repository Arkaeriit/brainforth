\ This file contain a fex words to manipulate arguments 

\ Give the number of arguments, including the name of the program
: argc ( -- n ) ARGS @ @ ;
\ Give the address to the array where the arguments are
: argv ( -- addr ) ARGS @ 1 CELLS + @ ;
\ Give the address of the nth argument
: (arg) ( n -- addr ) 1+ CELLS ARGS @ + @ ;
\ Give the length of the C string whose adress have been given
: strlen ( addr -- u ) DUP BEGIN DUP 1+ SWAP C@ 0= UNTIL 1- SWAP - ;
\ Give the address and the length of the nth argument
: arg ( n -- addr u ) (arg) DUP strlen ;

\ #SI
\ Print the number of arguments, then the length of the program name and then print every arguments
: ARGS_TEST_1  argc . argv strlen . argc 0 DO I arg TYPE SPACE LOOP ;
ARGS_TEST_1

