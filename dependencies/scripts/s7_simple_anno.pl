#!/usr/bin/perl -w
use warnings;
open IN, "<$ARGV[0]"; #anno
open II, "<$ARGV[1]"; #table

	while (<IN>) {
		chomp;
		s/\r//;
		$ID_db = (split/\t/,$_)[0];
		$ID_db2 = (split/\t/,$_)[1];
		$hash{$ID_db} = "$ID_db2";
	}

	while (<II>) {
		chomp;
		s/\r//;
		$all = $_;
		$check_id = (split/\t/,$_)[0];
		if ($check_id =~ m/^Ko_ID/){print "Gene\t$all\n";}
		if (exists $hash{$check_id}) {
			print "$hash{$check_id}\t$all\n";
		}
	}
