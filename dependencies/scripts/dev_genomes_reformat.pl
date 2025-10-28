#!usr/bin/perl
use warnings;
#usage: perl s1_fa_reformat.pl <IN original.fa> > <OU reformated.fa>

open IN, "$ARGV[0]";
open OU1, ">./tem.reformated";
while(<IN>){
	s/\r//g;
	chomp;
	if(m/>/){
	s/>//;
	my$ID = (split /\s+/,$_)[0];
	print OU1 ">$ID";
	print OU1 "cjwfengecjw\n";
	}else{
	s/ //g;
	print OU1 "$_\n";
	}
}
close IN;
close OU1;

open IN, "./tem.reformated";
$/=">";<IN>;
while (<IN>) {
	chomp;
	s/\n//g;
	$id=(split /cjwfengecjw/,$_)[0];
	$seq=(split /cjwfengecjw/,$_)[1]; #<------adjust to get seq
	$seq=~s/\*$//;
	print ">$id\n$seq\n";
}
unlink './tem.reformated';
close IN;

