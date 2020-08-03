
all : brainforth

brainforth : BRAINFORTH.frt
	lina -c BRAINFORTH.frt
	mv BRAINFORTH brainforth

BRAINFORTH.frt : brainforth.frt
	preforth brainforth.frt BRAINFORTH.frt

test : brainforth
	./brainforth
	cat out.frt

clean :
	rm -f BRAINFORTH.frt
	rm -f brainforth

