#!/usr/bin/perl -w

use strict;
use warnings;

my $current_file = "";
my $date;
my %statistics;

while (defined(my $line = <>)) {
	chomp($line);
	if ($line eq "") {
		next;
	}
	if ($current_file ne $ARGV) {
		if ($current_file ne "" && $current_file ne "-") {
			$date = &extract_date_from_name($current_file);
			&print_statistics($date, %statistics);
		}
		%statistics = &init_statistics();
		$current_file = $ARGV;
	}
	$line =~ /(\d+:\d+:\d+:\d+)/;
	my $hour = (split(':', $1))[1];
	$statistics{$hour}++;
}

if ($current_file ne "-") {
	$date = &extract_date_from_name($current_file);
}
&print_statistics($date, %statistics);

sub extract_date_from_name {
	my ($name) = @_;
	return (split('\.', $name))[1];
}

sub init_statistics {
	my %statistics;
	foreach my $hour ('00'..'23') {
		$statistics{$hour} = 0;
	}
	return %statistics;
}

sub print_statistics {
	my($datum, %statistics) = @_;
	if (defined($datum)) {
		print(" Datum: $datum\n");
	}
	print(" sat : broj bristupa\n");
	print("----------------\n");
	foreach my $sat (sort(keys %statistics)) {
		print("  $sat : $statistics{$sat}\n");
	}
	print("\n");
}
