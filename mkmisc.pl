use Plib;

if ( not args() ){ die("ERR: give label")}

$label = argv(1);

$sector = '';
$access = '';

$f = ("$label" . '.in');
if (not isfile($f)) { die "ERR: input file $f not exist" }

$o = ("$label" . '.out');
@labels = redir('<', $f);

# ##aux:org
# shlep
for $t (@labels){
    if (matches($t,'^##')){
        $title = tostr(extract($t, '^(##\w+)\:\w+'));
        $sector = tostr(extract($t, '^##(\w+)\:\w+'));
        $access = tostr(extract($t, '^##\w+\:(\w+)'));

        redir('>', $o , $title);
        redir('>', $o , '');
    } else {
        $pkg = $t;
        $from = catdir( '..', 'out', $label, ($sector . '.' . $access), $pkg);
        $path= catdir( 'misc', $sector,$pkg);
        $todir = catdir ('..', 'public', 'misc', $sector);
        if ( isdir($from) ){
            if (not isdir ( $todir )) { mkdir $todir ;}
            cpdir ($from , catdir($todir, $pkg));
            redir('>>', $o, "[$pkg](../$path/${pkg}.html)" );
        }else{
            die("ERR: no source directory in $from");
        }

    }
}


