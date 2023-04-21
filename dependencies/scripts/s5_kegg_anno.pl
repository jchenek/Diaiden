#!/usr/bin/perl -w
#put all .m6out files in a dir
#mkdir two dir called $out_dir_1, $out_dir_2
#usage: perl s4_kegg_anno.pl <IN anno.txt> <IN dir_name> <IN out_dir_name>

use warnings;
($anno,$dir,$out_dir) = @ARGV ;

$out_dir =~ s/\///;

mkdir("$out_dir\_1");
mkdir("$out_dir\_2");

open IN, "$anno";
	while (<IN>) {
		chomp;
		$ID_db = (split/\t/,$_)[1];
		$ID_anno = (split/\t/,$_)[2];
		$hash{$ID_db} = "$ID_anno";
	}
close IN;

my$DIR_PATH = $dir;
opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
my@filelist = readdir DIR;

foreach my$file (@filelist) {
	if($file =~ /m6out/){
	@table1 = ();
	%hash1 = ();
	$i = 0;
	open II, "$DIR_PATH/$file" || die "can not open";
	open OU, ">./$out_dir\_1/$file\.anno.xls";
	open OU2, ">./$out_dir\_2/$file\.uniid_num.xls";
	while (<II>) {
		chomp;
		$ID1 = (split /\t/,$_)[0];
		$ID2 = (split /\t/,$_)[1];
		if (exists $hash{$ID2}) {
			$ID3 = $hash{$ID2};
			$ID3 =~ s/$ID2//;
			print OU "$ID1\t$ID2\t$hash{$ID2}\n";
			$table1[$i] = $ID2;
			$hash1{$ID2} = 0;
			$i++;
		}
	}


foreach(@table1){
	chomp;
	if(exists($hash1{$_})){
		$hash1{$_}++;
	}
}
foreach $_(keys %hash1)
{
	print OU2 "$_\t$hash1{$_}\n";
}

	close II;
	close OU;
	close OU2;
}
}


