#!/usr/bin/perl

use GetOpt::Std;

our $n = 4;
my $pi = 4*atan2(1,1);
my $l = 768;
my $r = $l/2;
my $R2;

$n = shift(@ARGV);
if(!($n>0)) { $n=1; }

svg_begin();
for(my $i=-$n; $i <= $n ; $i++) {
    if($i>=0) {
        my $psi = $i/$n * $pi;
        my $c = 1/2 * cos($psi);
        my $s = 1/2 * sin($psi);
        my $c2 = 1/2 - $c;
        my $r2 = sqrt($c2*$c2+$s*$s);
        my $cr = $r2 * $r;
        print qq{<circle class="m" r="$cr"/>\n};
    }
    
    if($i==0) {
        next;
    }

    
    my $phi = $i/$n * $pi / 2;
    my $R = 1 / ( 2 * sin($phi)) * $r;
    my $cx = $R;
    my $cxr = abs($R);

    if($i==1) { $R2 = 2*$R; }

    print qq{<circle class="e" cx="$cx" r="$cxr"/>\n};
    #    print qq{<circle r="$R"> $phi\n};
}

print qq{<line class="e" x1="0" y1="$R2" x2="0" y2="-$R2"/>\n};
print qq{<circle class="shell" r="$R2"/>\n};

svg_end();
exit;

sub svg_begin {
    print <<"END";
<?xml version="1.0" standalone="no"?>
<?xml-stylesheet href="style.css" type="text/css"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1"
    width="$l" height="$l" viewBox="0 0 $l $l">
<defs>
<g id="g$n">
END
}

sub svg_end {
    my $R2r = $r/$R2;
    my $t  = "translate($r,$r)";
    my $ts = "scale($R2r)";
    my $r2 = $r/2;
    print <<"END";
<circle class="unit" r="$r"/>
<circle class="unit" cx="$r2"  r="$r2"/>
<circle class="unit" cx="-$r2" r="$r2"/>
</g>
</defs>
<g id="g" transform="$t">
    <use xlink:href="#g$n" transform="$ts"/>
<!--    <use xlink:href="#g$n"/> -->
</g>
</svg>
END
}
