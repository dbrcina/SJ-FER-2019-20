#!/usr/bin/perl -w

use strict;
use warnings;

use feature "say";

if (@ARGV != 1) {
	die "Program očekuje putanju do datoteke.\n";
}
my $file = $ARGV[0];

open FILE, '<', $file or die "Greška kod otvaranja '$file' datoteke.\n";

my @percentages;
my %statistics;
my $longest_key;
my $first = 1;
while (defined(my $line = <FILE>)) {
	chomp $line;
	# skip comments
	if ($line =~ /^#./) {
		next;
	}
	# percentages...
	if ($first) {
		$first = 0;
		@percentages = split /;/, $line;
		next;
	}
	my ($jmbag, $prezime, $ime, @rezultati) = split /;/, $line;
	my $key = "$prezime, $ime ($jmbag)";
	$longest_key = &max($longest_key, length $key);
	my $value = &calculate_results(@rezultati);
	$statistics{$key} = $value;
}

my $counter = 1;
say "Lista po rangu:";
say "-----------------";
foreach my $key (sort { $statistics{$b} <=> $statistics{$a} } keys %statistics) {
	my $spaces = $longest_key - length($key) + 1;
	printf("%3d. %s%s: %.2f\n", $counter++, $key, " " x $spaces, $statistics{$key});
}

close FILE or die "Greška kod zatvaranja '$file' datoteke.\n";

sub calculate_results {
	my (@results) = @_;
	my $sum = 0;
	for (my $i = 0; $i < @results; $i++) {
		my $result = $results[$i];
		if ($result eq "-") {
			$result = 0;
		}
		$sum += $result * $percentages[$i];
	}
	return $sum;
}

sub max {
	my ($a, $b) = @_;
	if (!defined($a) && !defined($b)) {
		return undef;
	} elsif (!defined($a)) {
		return $b;
	} elsif (!defined($b)) {
		return $a;
	} else {
		return $a > $b ? $a : $b;
	}
}
