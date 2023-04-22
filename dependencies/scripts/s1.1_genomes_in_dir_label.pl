#!/usr/bin/perl -w
#put all .fa/fna/faa files in a dir
#usage: perl .pl <IN dir_name> <IN path_to_diaiden>
#make sure dev_label_fa.pl existed

use warnings;
($dir,$path) = @ARGV ;
$dir =~ s/\/$//;
$path =~ s/\/$//;


mkdir("label");
open OU2, ">./s1_label_com";

my$DIR_PATH = $dir;
opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
my@filelist = readdir DIR;

foreach my$file (@filelist) {
	if($file =~ /fna$/){
	$label = $file;
	$label =~ s/\.fna//;
	print OU2 "perl $path\/dependencies/scripts/dev_label_fa.pl $label $dir\/$file > label/$file\n"; 
}
	if($file =~ /faa$/){
	$label = $file;
	$label =~ s/\.faa//;
	print OU2 "perl $path\/dependencies/scripts/dev_label_fa.pl $label $dir\/$file > label/$file\n"; 
}
	if($file =~ /fa$/){
	$label = $file;
	$label =~ s/\.fa//;
	print OU2 "perl $path\/dependencies/scripts/dev_label_fa.pl $label $dir\/$file > label/$file\n"; 
}
}
#print "sh s1_label_com\n";
close OU2;
system ("sh s1_label_com");
system ("rm s1_label_com")

