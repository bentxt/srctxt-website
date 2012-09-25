use Plib;

#if ( not args() ){ die("ERR: give label")}
#$label = argv(1);

$label = 'txt';

$sector = '';
$access = '';

$f = ("$label" . '.in');
if (not isfile($f)) { die "ERR: input file $f not exist" }

$o = ("$label" . '.out');
@lines = redir('<', $f);

# ##aux:org
# shlep
for $t (@lines){
        $title = tostr(extract($t, '^(\w+)\.\w+'));
        $access = tostr(extract($t, '^\w+\.(\w+)\:.*'));
        $desc = tostr(extract($t, '^w+\.\w+\:(.+)'));

        redir('>>', $o , $title . "\n");
        redir('>>', $o , "\n");

        $from = catdir( '..', 'out', $label, $access, $title);
        $todir = catdir ('..', 'public', 'misc', 'txt' );
        $path=catdir('txt', $title);
        $tofile = catfile($path, ( "index.html"));
        if ( isdir($from) ){
            if (not isdir ( $todir )) { mkdir $todir ;}
            cpdir ($from , catdir($todir, $title));
            redir('>>', $o, "- [$title]($tofile)\n" );
            redir('>>', $o, "\n" );
        }else{
            die("ERR: no source directory in $from");
        }
}

$ifile = catfile(catdir('..','public','misc'), ($label . ".html"));
sh( " pandoc -s $o >| $ifile" );
sh("open $ifile");


