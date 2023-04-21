#!/usr/bin/perl -w
#usage: perl s3_cds_diamond.pl <IN dir_name> <IN path_to_database_dmnd>
#this script needs Diaiden env in whick diamond is available
#dir_name: all cds.fna or cds.faa are in one dir, prodigal output is ok, no need to reformate
#for .faa blastp will be used; for .fna blastx will be used

use warnings;
($dir, $db) = @ARGV ;
open OU2, ">./diamond_com";
print OU2 "mkdir diamond_out\n";

my$DIR_PATH = $dir;
opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
my@filelist = readdir DIR;

foreach my$file (@filelist) {
	if($file =~ /faa/){
	$file_name = $file;
	$file_name =~ s/\.faa//;
	print OU2"diamond blastp --db $db --query $dir\/$file --out ./diamond_out/$file_name.m6out --outfmt 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovhsp scovhsp --sensitive -k 1 -e 1e-100 --id 50 --query-cover 75 --subject-cover 75 -c1\n";
	}
	if($file =~ /fna/){
	$file_name = $file;
	$file_name =~ s/\.fna//;
	print OU2"diamond blastx --db $db --query $dir\/$file --out ./diamond_out/$file_name.m6out --outfmt 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovhsp scovhsp --sensitive -k 1 -e 1e-100 --id 50 --query-cover 75 --subject-cover 75 -c1\n";
	}
}
system ("sh diamond_com");
unlink './diamond_com';
