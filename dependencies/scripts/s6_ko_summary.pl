#!/usr/bin/perl -w
use warnings;

#usage: perl s6_ko_summary.pl <IN shared_id.txt> <IN dir_name> > <ko_summary.tsv>
($shared_id,$dir_name) = @ARGV ;


my$DIR_PATH = "./$dir_name"; #set the dir path here


opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
my@filelist = readdir DIR;
my@table = ();
my$i = 0;

open IN, "$shared_id" or die;
while(<IN>){
	chomp;
	$table[$i] = (split /\s+/,$_)[0];
	$i++;
}
print "Ko_ID";

foreach my$file (@filelist) {
if($file =~ m/.xls/){
	my%hash = ();
	open II, "$DIR_PATH/$file" || die "can not open";
	$file_name = $`;
	$file_name =~ s/.cds.m6out.uniid_num//;
	print "\t$file_name";
	while (<II>) {
		chomp;
		my$id=(split /\s+/,$_)[0]; #<------target 
		my$data=(split /\s+/,$_)[1]; #<------target 
		$hash{$id}=$data;
	}
	close II;
	foreach(@table){
		chomp;
		my$id2=(split /\s+/,$_)[0];
		if(exists($hash{$id2})){
			$_ = "$_\t$hash{$id2}";
		}else{
			$_ = "$_\t0";
		}
	}
	}
}
print "\n";
foreach (@table)
{
	chomp;
	s/\n/\t/;
	print "$_\n";
}




