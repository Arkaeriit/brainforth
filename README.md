# Brainforth
A Brainfuck to Forth transpiler

## What is brainforth?
Brainforth transpile Brainfuck into Forth by defining the symbols used in Bainfuck as Forth words with the same meaning. The lead to a transpiled code looking a lot like the initial code.

Exemple:
This Brainfuck code:
```brainfuck
+[+.] Print all ASCII characters in increasing order
-[-.] Print all ASCII characters in decreasing order
```

Is transpiled into this:
```forth
\ Starting the environement
: array-init ( size -- addr ) DUP HERE SWAP ALLOT DUP ROT 0 DO DUP 0 SWAP C! 1+ LOOP DROP ;
: brainfuck-init ( -- addr ) 1048576 array-init ;

\ Definig brainfuck symbols as forth words
: [ ( addr -- addr ) POSTPONE BEGIN POSTPONE DUP POSTPONE C@ POSTPONE WHILE ; IMMEDIATE
: ] ( addr -- addr ) POSTPONE REPEAT ; IMMEDIATE
: . ( addr -- addr ) DUP C@ EMIT ;
: , ( addr -- addr ) DUP KEY SWAP C! ;
: + ( addr -- addr ) DUP DUP C@ 1+ SWAP C! ;
: - ( addr -- addr ) DUP DUP C@ 1- SWAP C! ;
: > ( addr -- addr+1 ) 1+ ;
: < ( addr -- addr-1 ) 1- ;

: MAIN ( -- ) brainfuck-init
+ [ + . ] ( Print all ASCII characters in incresing order )
- [ - . ] ( Print all ASCII characters in decreasing order )
;
MAIN
```
Note how the content of the main word is similar to the Brainfuck code.

## Usage
```bash
brainforth <input file> <output file>
```

## Building brainforth
Brainforth is witten in ciforth and since the words are separated in various files you need preforth (https://github.com/Arkaeriit/preforth) to build it with the makefile. If you don't want to use preforth you could paste IOchar.frt then std+.frt then arguments.frt and then brainforth.frt in the same file.

