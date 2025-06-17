#!/usr/bin/perl -w
use warnings;
use Getopt::Std;
use vars qw($opt_i $opt_p $opt_c $opt_b $opt_h);
getopts('i:p:c:b:h');

if($opt_h || !defined($opt_i) || !defined($opt_p) || !defined($opt_c) || !defined($opt_b)){
#usage
print "Usage:\nMake sure you are in diaiden conda environment.\nCommand:\n";
print "perl /PATH/TO/Diaiden.pl -i /PATH/TO/YOUR/genomes_dir -p /PATH/TO/Diaiden_dir -c 2 -b 2\nCriteria 2: The genome carries genes that encode at least (-c number) of the three catalytic genes (nifH, nifD, nifK) and at least (-b number) of the three biosynthetic genes (nifE, nifN, nifB) for nitrogen fixation.\n";
}else{
#define variables
$current_path = $ENV{'PWD'};
$genomes_path = $opt_i;
$Diaiden_PATH = $opt_p;
$Criteria_cg = $opt_c;
$Criteria_bg = $opt_b;
#print "$genomes_path\n$current_path\n$Diaiden_PATH\n";

#output pipeline
open OU2, ">./Diaiden_com";
print OU2 "cd $genomes_path\n";
print OU2 "export user_genome_PATH=\"\$\(pwd\)\"\n";
print OU2 "cd \.\.\/\n";
print OU2 "export Diaiden_user_PATH=\"\$\(pwd\)\"\n";
print OU2 "perl $Diaiden_PATH\/dependencies/scripts/s1.1_genomes_in_dir_label.pl \$user_genome_PATH $Diaiden_PATH\n";
print OU2 "perl $Diaiden_PATH\/dependencies/scripts/s1.2_genomes_in_dir_reformate.pl label $Diaiden_PATH\n";
print OU2 "perl $Diaiden_PATH\/dependencies/scripts/s2_genomes_prodigal.pl reformated/ \n";
print OU2 "perl $Diaiden_PATH\/dependencies/scripts/s3_cds_diamond.pl prodigal/cds_faa/ $Diaiden_PATH\/dependencies/core_Nifs_db/core_nifs_db.dmnd\n";
print OU2 "find . -wholename \"\./diamond_out/\*\" -type f -size 0c | xargs -n 1 rm -f\n";
print OU2 "perl $Diaiden_PATH\/dependencies/scripts/s4_kegg_pre_anno.pl $Diaiden_PATH\/dependencies/core_Nifs_db/core_nifs_annotation.txt diamond_out/ diamond_out/\n";
print OU2 "perl $Diaiden_PATH\/dependencies/scripts/s5_kegg_anno.pl $Diaiden_PATH\/dependencies/core_Nifs_db/core_nifs_annotation.txt diamond_out_0/ diamond_out/\n";
print OU2 "perl $Diaiden_PATH\/dependencies/scripts/s6_ko_summary.pl $Diaiden_PATH\/dependencies/core_Nifs_db/core_nifs_ko_list.txt diamond_out_2/ > nif_summary_tmp.tsv\n";
print OU2 "perl $Diaiden_PATH\/dependencies/scripts/s7_simple_anno.pl $Diaiden_PATH\/dependencies/core_Nifs_db/core_nifs_ko_list.txt nif_summary_tmp.tsv > nif_anno_full_info.tsv\n";
print OU2 "rm nif_summary_tmp.tsv\n";
print OU2 "Rscript $Diaiden_PATH\/dependencies/scripts/s8_diazotroph_identify.r \$Diaiden_user_PATH \$user_genome_PATH $Criteria_cg $Criteria_bg\n";
print OU2 "mkdir diazo_nifh_genomes\nsh diazo_cp1_com.txt\nmkdir diazo_nifs_genomes\nsh diazo_cp2_com.txt\nmkdir diazo_nifh_nifs_genomes\nsh diazo_cp3_com.txt\n";
print OU2 "perl $Diaiden_PATH\/dependencies/scripts/s9_nif_gene_extract.pl K02588 diamond_out_1/ prodigal/cds_fna/ $Diaiden_PATH nifh.fna \n";
print OU2 "perl $Diaiden_PATH\/dependencies/scripts/s9_nif_gene_extract.pl K02588 diamond_out_1/ prodigal/cds_faa/ $Diaiden_PATH nifh.faa \n";
print OU2 "perl $Diaiden_PATH\/dependencies/scripts/s9_nif_gene_extract.pl K02586 diamond_out_1/ prodigal/cds_fna/ $Diaiden_PATH nifd.fna \n";
print OU2 "perl $Diaiden_PATH\/dependencies/scripts/s9_nif_gene_extract.pl K02586 diamond_out_1/ prodigal/cds_faa/ $Diaiden_PATH nifd.faa \n";
print OU2 "perl $Diaiden_PATH\/dependencies/scripts/s9_nif_gene_extract.pl K02591 diamond_out_1/ prodigal/cds_fna/ $Diaiden_PATH nifk.fna \n";
print OU2 "perl $Diaiden_PATH\/dependencies/scripts/s9_nif_gene_extract.pl K02591 diamond_out_1/ prodigal/cds_faa/ $Diaiden_PATH nifk.faa \n";
print OU2 "mkdir workfiles\nmv diamond_out* workfiles/\nmv label/ workfiles/\nmv reformated/ workfiles/\nmv prodigal/ workfiles/\nmv *com.txt workfiles/\ncd $current_path\n";
system("sh Diaiden_com");
system("rm ./Diaiden_com");
print "###############################################################################\n";
print "###############################################################################\n";
print "###### Diaiden pipeline is finished!\n###### 'nif_anno_full_info.tsv' showes full annotation results.\n###### 'diazo_\*.tsv' files show potential diazotrophs based on differernt criteria.\n###### 'nifh.f*a' files show nifh sequences extracted from genomes.\n###### Potential diazotroph genomes are put in 'diazo_\*_genomes' dirs.\n";
print "###### If no diazotroph is detected, you will see error info:\"sh: diazo_cp*_com.txt: \.\.\.\"\n";
print "###############################################################################\n";
print "###############################################################################\n";
}
