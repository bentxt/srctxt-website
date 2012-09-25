use Plib;
sub all {
    mkdir ( catdir ('..','public','misc'));
    redir('>',catfile('..','public','index.html'), '<html><body>'); 
    sh('pandoc -f markdown -t html ' . catfile('txt','index.txt') . ' >> ' . catdir('..','public','index.html'));
    sh('plib mknews.pl >> ../public/index.html');
	redir('>>' , '../public/index.html','</body></html> ');

    
    sh("plib mksrcindex.pl ");
    sh("plib mktxtindex.pl ");

    $hm = tostr(sh('printf $HOME'));
	rmdir('../public/misc/technotes');
	cpdir("$hm/work/out/streams/technotes.org", '../public/misc/technotes');

	rmdir('../public/misc/bookmarks');
	cpdir("$hm/work/out/streams/bookmarks.org", '../public/misc/bookmarks');

	rmdir('../public/misc/cheatsheets');
	cpdir("$hm/work/out/streams/cheatsheets.org",'../public/misc/cheatsheets');
}
all();
