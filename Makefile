all: clean
	perl -I ./plib/ build.pl

clean:
	rm -f ../public/index.html
	rm -rf ../public/misc
	rm -f *.out

viscreen:
	viscreen "perl -I plib mknews.pl"
	ls 

vitmux:
	vitmux "perl -I plib mkmisc.pl codes"

release:
	./rls.sh
	
