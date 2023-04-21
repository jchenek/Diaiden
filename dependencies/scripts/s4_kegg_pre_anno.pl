#!/usr/bin/perl -w
#put all .m6out files in a dir
#mkdir one dir called $out_dir_0
#usage: perl s3_kegg_pre_anno.pl <IN anno.txt> <IN dir_name> <IN out_dir_name>

use warnings;
($anno,$dir,$out_dir) = @ARGV ;

$out_dir =~ s/\///;
mkdir("$out_dir\_0");

open IN, "$anno";
	while (<IN>) {
		chomp;
		$ID_db = (split/\s+/,$_)[0];
		$hash{$ID_db}= (split/\s+/,$_)[1];
	}
close IN;

my$DIR_PATH = $dir;
opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
my@filelist = readdir DIR;

foreach my$file (@filelist) {
	if($file =~ m/m6out/){
	open II, "$DIR_PATH/$file" || die "can not open";
	open OU, ">./$out_dir\_0/$file";
	while (<II>) {
		chomp;
		$ID1 = (split /\t/,$_)[0];
		$ID2 = (split /\t/,$_)[1];
		if (exists $hash{$ID2}) {
			print OU "$ID1\t$hash{$ID2}\n";
		}
	}
}
	close II;
	close OU;
}
#print "run kegg_m6out_dir_anno using _0 dir\n";

