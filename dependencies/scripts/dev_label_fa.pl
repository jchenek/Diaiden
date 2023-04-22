#!usr/bin/perl
#perl label_fa.pl <IN label> <IN fa> > <OU labeled_fa>
#label.txt is a txt contains label in the first line
use warnings;

($lab, $fa) = @ARGV;

open IN, "$fa";
while(<IN>){
	chomp;
	if(m/>/){
	s/>//;
	my$ID = $_;
	print ">$lab\___$ID\n";
	}else{
	print "$_\n";
	}
}
close IN;
