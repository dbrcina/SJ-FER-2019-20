#!/usr/bin/perl -w

$znakovni_niz = &unesi_znakovni_niz();
$broj_ponavljanja = &unesi_nenegativan_broj();
$index = 1;

while($broj_ponavljanja > 0) {
	printf("%3d. %s\n", $index, $znakovni_niz);
	$broj_ponavljanja--;
	$index++;
}

sub unesi_znakovni_niz {
	my $znakovni_niz;
	do {
    	print("Unesite znakovni niz: ");
    	my $niz = <STDIN>;
    	if (defined($niz)) {
        	chomp($niz);
        	$znakovni_niz = $niz;
    	} else {
    		print("\n");
    	}
	} while($znakovni_niz eq "");
	return $znakovni_niz;
}

sub unesi_nenegativan_broj {
	my $broj_ponavljanja = -1;
	do {
		print("Unesite nenegativan broj ponavljanja: ");
		my $broj = <STDIN>;
		if (defined($broj)) {
			chomp($broj);
			if ($broj =~ /\d/) {
				if ($broj >= 0) {
					$broj_ponavljanja = $broj;
				}
			}
		} else {
			print("\n");
		}
	} while($broj_ponavljanja < 0);
	return $broj_ponavljanja;
}
