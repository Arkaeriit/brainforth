
all : brainforth

brainforth : BRAINFORTH.frt
	lina -c BRAINFORTH.frt
	mv BRAINFORTH brainforth

BRAINFORTH.frt : brainforth.frt
	preforth brainforth.frt BRAINFORTH.frt

clean :
	rm -f BRAINFORTH.frt
	rm -f brainforth

install :
	mkdir -p /usr/local/share/brainforth
	cp -f symbols.frt /usr/local/share/brainforth/symbols.frt
	cp -f brainforth /usr/local/bin/brainforth

uninstall :
	rm -fr /usr/local/share/brainforth
	rm -f brainforth /usr/local/bin/brainforth

