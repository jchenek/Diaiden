#!/usr/bin/perl -w
use warnings;
use Getopt::Std;
use vars qw($opt_i $opt_p $opt_h);
getopts('i:p:h');

if($opt_h || !defined($opt_i) || !defined($opt_p)){
#usage
print "Usage:\nMake sure you are in diaiden conda environment.\nCommand:\n";
print "perl /PATH/TO/Diaiden.pl -i /PATH/TO/YOUR/genomes_dir -p /PATH/TO/Diaiden_dir\n";
}else{
#define variables
$current_path = $ENV{'PWD'};
$genomes_path = $opt_i;
$Diaiden_PATH = $opt_p;
#print "$genomes_path\n$current_path\n$Diaiden_PATH\n";

#output pipeline
open OU2, ">./Diaiden_com";
print OU2 "cd $genomes_path\n";
print OU2 "export user_genome_PATH=\"\$\(pwd\)\"\n";
print OU2 "cd \.\.\/\n";
print OU2 "export Diaiden_user_PATH=\"\$\(pwd\)\"\n";
print OU2 "perl $Diaiden_PATH\/dependencies/scripts/s1_genomes_in_dir_reformate.pl \$user_genome_PATH $Diaiden_PATH\n";
print OU2 "perl $Diaiden_PATH\/dependencies/scripts/s2_genomes_prodigal.pl reformated/ \n";
print OU2 "perl $Diaiden_PATH\/dependencies/scripts/s3_cds_diamond.pl prodigal/cds_faa/ $Diaiden_PATH\/dependencies/core_Nifs_db/core_nifs_db.dmnd\n";
print OU2 "find . -wholename \"\./diamond_out/\*\" -type f -size 0c | xargs -n 1 rm -f\n";
print OU2 "perl $Diaiden_PATH\/dependencies/scripts/s4_kegg_pre_anno.pl $Diaiden_PATH\/dependencies/core_Nifs_db/core_nifs_annotation.txt diamond_out/ diamond_out/\n";
print OU2 "perl $Diaiden_PATH\/dependencies/scripts/s5_kegg_anno.pl $Diaiden_PATH\/dependencies/core_Nifs_db/core_nifs_annotation.txt diamond_out_0/ diamond_out/\n";
print OU2 "perl $Diaiden_PATH\/dependencies/scripts/s6_ko_summary.pl $Diaiden_PATH\/dependencies/core_Nifs_db/core_nifs_ko_list.txt diamond_out_2/ > nif_summary_tmp.tsv\n";
print OU2 "perl $Diaiden_PATH\/dependencies/scripts/s7_simple_anno.pl $Diaiden_PATH\/dependencies/core_Nifs_db/core_nifs_ko_list.txt nif_summary_tmp.tsv > nif_anno_full_info.tsv\n";
print OU2 "rm nif_summary_tmp.tsv\n";
print OU2 "Rscript $Diaiden_PATH\/dependencies/scripts/s8_diazotroph_identify.R \$Diaiden_user_PATH\n";
print OU2 "mkdir diazo_nifh_genomes\nsh diazo_cp1_com.txt\nmkdir diazo_nifs_genomes\nsh diazo_cp2_com.txt\nmkdir diazo_nifh_nifs_genomes\nsh diazo_cp3_com.txt\n";
print OU2 "mkdir workfiles\nmv diamond_out* workfiles/\nmv reformated/ workfiles/\nmv prodigal/ workfiles/\nmv *com.txt workfiles/\ncd $current_path\n";
system("sh Diaiden_com");
system("rm ./Diaiden_com");
print "###############################################################################\n";
print "###############################################################################\n";
print "###### Diaiden pipeline is finished!\n###### nif_anno_full_info.tsv showed full annotation results\n###### diazo_\*.tsv files were potential diazotrophs based on differernt criteria\n###### potential diazotroph genomes were put in diazo_\*_genomes dirs\n";
print "###############################################################################\n";
print "###############################################################################\n";
}
