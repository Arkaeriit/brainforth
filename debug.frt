\ Debuguing words
\ Print th top of the stack
: .? DUP . ;
\ Print the top of the stack as a char
: .c? DUP EMIT SPACE ;
\ Print the two first element of the stack
: .?? 2DUP . . ;
\ Print the 3 first element on the stack
: .??? .? >R .? >R .? R> R> ;

