while (<>) {
	chomp;
	@odvojeno = split /;/;
	$termin = $odvojeno[3];
	$zakljucano = $odvojeno[4];
	@odvojenot = split / /, $termin;
	@odvojenoz = split / /, $zakljucano;
	$ttermin = $odvojenot[0] . " " . $odvojenot[1];
	$tzakljucano = $odvojenoz[0] . " " . $odvojenoz[1];
	if (&make_time_comparable($tzakljucano) - &make_time_comparable($ttermin) > 10000) {
		print "$odvojeno[0] $odvojeno[1] $odvojeno[2] - PROBLEM: $termin --> $zakljucano\n";
	}
}

sub make_time_comparable {
	($datum_vrijeme) = @_;
	($datum, $vrijeme) = split / /, $datum_vrijeme;
	($godina, $mjesec, $dan) = split /-/, $datum;
	($sat, $minuta, $sekunda) = split /:/, $vrijeme;
	$sekunda ||= '00';
	return "$godina$mjesec$dan$sat$minuta$sekunda";
}