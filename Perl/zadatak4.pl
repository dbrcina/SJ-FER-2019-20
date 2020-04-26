#!/usr/bin/perl -w

use strict;
use warnings;

use feature "say";

while (defined(my $line = <>)) {
	chomp $line;
	my ($jmbag, $prezime, $ime, $termin, $zakljucano) = split(';', $line);
	my @temp = split('\s+', $termin);
	my $termin_pocetak = join(' ', @temp[0, 1]);
	my $termin_pocetak_sat = $temp[1];
	my $zakljucano_sat = (split(' ', $zakljucano))[1];
	if (&to_comparable_time($zakljucano) - &to_comparable_time($termin_pocetak) > 1_00_00) { #H_MM_SS
		say "$jmbag $prezime $ime - PROBLEM: $termin_pocetak --> $zakljucano"
	}
}

sub to_comparable_time {
	my ($date_time) = @_; # yyyy-mm-dd HH:MM:SS
	my ($date, $time) = split(' ', $date_time); 
	my ($year, $month, $day) = split('-', $date);
	my ($hour, $minute, $second) = split(':', $time);
	$second ||= '00';
	return "$year$month$day$hour$minute$second";
}