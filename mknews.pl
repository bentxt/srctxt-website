use Plib;
 
$newsdir='news';
if ( not ( isdir($newsdir))){ dir("ERR: no dir $newsdir");}

@news = ();

@newsfiles = (tree($newsdir));

for $i (reverse(sort(@newsfiles))){
    if ( not (isfile($i))){ next; };
    $fbase=basename($i);
    $fname=filename($fbase);
    $htmlfile = ($fname . '.html');

    $dir=dirname($i);
    @dirs = splitdir($dir);

    $topic = nth(0, @dirs );
    $year = nth(1, @dirs );

    @date = extract($fname, '^(\d\d)-(\d\d)_(.*)$');
    $m = nth(0,@date);
    $d = nth(1,@date);
    $t = nth(2,@date);
    $title = replace('-', ' ', $t);
    $title = replace('_', ' ', $title);
    
    @header = list(
        ("topic: " . $year . "/" . $m . "/" . $d),
        ("                 **$title**           "),
        ("  "),
        ("  "),
    );
    push(@news, @header);
    push(@news, tostr(redir('<', $i)));
    push(@news, '<hr>');
}

$nws = tostr(@news);
@htmlnews = sh("echo '$nws' | pandoc -s -f markdown -t html");
print(@htmlnews);
