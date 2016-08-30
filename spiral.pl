#!/usr/bin/perl

use Math::Trig;

my $r1 = 1.05;
my $r2 = 1/$r1;

my @a;
my @b;

my $R = 128;

for($i=-6;$i<=2;$i++) {
    for($j=0;$j<90;$j++) {
	$ii=($i*90+$j)/90;
	$phi1=2*pi*$ii;
	$s = sin($phi1);
	$c = cos($phi1);
	$r = $R*(2**$ii);
#	print "$i $j $ii $phi1\n";
	push @a,[$r1*$r*$s,-$r1*$r*$c];
	push @b,[$r2*$r*$s,-$r2*$r*$c];
    }
}

my $d="";
for($i=0;$i<=$#a;$i++) {
    $d .= ($i==0?"M":"L").$a[$i]->[0].",".$a[$i]->[1]." ";
}
for($i=$#b;$i>=0;$i--) {
    $d .= "L".$b[$i]->[0].",".$b[$i]->[1]." ";
}
$d .= "z";

print <<"END";
<svg
   xmlns="http://www.w3.org/2000/svg"
   width="1024"
   height="1024"
   id="svg2"
   version="1.1"
>
<g id="layer1" transform="translate(512,512)">
<path 
    style="fill:#000000;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
    id="path2985"
    d="$d"/>
</g>
</svg>
END

