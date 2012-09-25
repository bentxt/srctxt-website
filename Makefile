all: clean
	perl -I ./plib/ build.pl

clean:
	rm -f *.out

viscreen:
	viscreen "perl -I plib mknews.pl"
	ls 

vitmux:
	vitmux "perl -I plib mkmisc.pl src"

release:
	./rls.sh
	
