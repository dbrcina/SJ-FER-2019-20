#!/usr/bin/perl -w

print("Unesite proizvoljan broj brojeva, a terminirajte sa ctrl+D\n");

while (1) {
	print("Unesi broj: ");
	my $broj = <STDIN>;
	if (!defined($broj)) {
		print("\nTerminirano.\n");
		last;
	}
	chomp($broj);
	if ($broj =~ /^-?\d+$/) {
		push(@brojevi, $broj);
	} elsif ($broj eq "") {
		next;
	} else {
		print("'$broj' nije validan broj.\n");
	}
}

foreach my $broj (@brojevi) {
	$sum += $broj;
}

$n = scalar(@brojevi);
if ($n == 0) {
	$avg = "ne postoji";
} else {
	$avg = $sum / $n;
}

print("Lista brojeva: (" . join(", ", @brojevi) . ")\n");
print("Aritmetička sredina: $avg\n");
