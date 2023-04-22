#!/usr/bin/perl -w
#usage: perl .pl <IN dir_name> <IN path_to_diaiden>
#make sure dev_fa_reformat_v2.pl existed

use warnings;
($dir,$path) = @ARGV ;
$dir =~ s/\/$//;
$path =~ s/\/$//;


mkdir("reformated");
open OU2, ">./reformate_com";

my$DIR_PATH = $dir;
opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
my@filelist = readdir DIR;

foreach my$file (@filelist) {
	if($file =~ /fna/){
	print OU2 "perl $path\/dependencies/scripts/dev_genomes_reformat.pl $dir\/$file > reformated/$file\n"; 
}
	if($file =~ /fa/){
	print OU2 "perl $path\/dependencies/scripts/dev_genomes_reformat.pl $dir\/$file > reformated/$file\n"; 
}
}
close OU2;
#print "sh reformate_com\n";
system ("sh reformate_com");
unlink './reformate_com';

