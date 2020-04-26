#!/usr/bin/perl -w

use strict;
use warnings;
use locale;
use open ':locale';

use feature "say";

if (@ARGV < 1) {
	die "Program ocekuje barem jedan argument, duljinu prefiksa.\n"
}

my $duljina_prefiksa = pop @ARGV;
if ($duljina_prefiksa =~ /\D/ || $duljina_prefiksa < 1) {
	die "Posljedni argument mora biti prirodan broj, a '$duljina_prefiksa' nije prirodan broj.\n";
}

my %rijeci_sa_prefiksom;
while (defined(my $line = <>)) {
	chomp $line;
	# skip empty lines
	if ($line =~ /^\s+$/) {
		next;
	}
	# to lower case
	$line = lc $line;
	# remove punctuations
	$line =~ s/[.,;]//g;
	my @rijeci = split /\s+/, $line;
	foreach my $rijec (@rijeci) {
		if (length $rijec < $duljina_prefiksa) {
			next;
		}
		$rijeci_sa_prefiksom{substr $rijec, 0, $duljina_prefiksa}++;
	}
}

if (%rijeci_sa_prefiksom == 0) {
	say "Nema rijeci sa prefiksom duljine $duljina_prefiksa.";
} else {
	foreach my $rijec (sort keys %rijeci_sa_prefiksom) {
		say "$rijec : $rijeci_sa_prefiksom{$rijec}";
	}
}
