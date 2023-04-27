#!/usr/bin/perl -w
use warnings;
#Usage: perl extract_target_contig_from_fa.pl <IN filted_contig_ID> <IN original_fa_file> > <OU filted_fa_file>
#contig_ID cannot have >
#if some fa ID have the same name and matched, all will be extracted

%hash=();
open II, "<$ARGV[0]";
while (<II>) {
	chomp;
	s/\r//;
	$id2=(split /\s+/,$_)[0]; #<------target contig
	$hash{$id2}= 1;
	}
close II;
open IN, "<$ARGV[1]";
$/=">";<IN>;
while (<IN>) {
	chomp;
	s/\r//;
	$id=(split /\s+/,$_)[0];
	$seq=(split /\s+/,$_)[1]; #<------adjust to get seq
	#$id=~s/\>//;
	if ($hash{$id}) {
#	$id1=(split /___/,$id)[0];
	$id1=$id;
	print ">$id1\n$seq\n";
	}
}
close IN;
