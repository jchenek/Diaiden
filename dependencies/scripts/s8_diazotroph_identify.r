library(dplyr)

#PATH input
all_path <- commandArgs(trailingOnly = TRUE)
my_path <- all_path[1]
my_genome <- all_path[2]
Criteria_cg <- all_path[3]
Criteria_bg <- all_path[4]
#my_path = "/media/cjw/Work_station_2/seepwater_column/whole_gtdb_diazo_scan/example"

#input ko_summary.xls
ko_summary <- 
  read.delim(paste(my_path,"/nif_anno_full_info.tsv",sep=""), 
             row.names = 1, sep = '\t', stringsAsFactors = FALSE, check.names = FALSE) 
ko_summary <- ko_summary %>%
  select(-Ko_ID)

#add an empty col
cjw <- data.frame(c(0,0,0,0,0,0))
ko_summary <- cbind(ko_summary,cjw)

#store data
ko_summary_map <- ko_summary
#exist or not
ko_summary[ko_summary >= 1 ] <- 1

#nifh criteria
nifh_summary <- ko_summary[3,]
diazo_nifh <- nifh_summary[colSums(nifh_summary) >= 1]
diazo_nifh_col <- colnames(diazo_nifh)
diazo_c1 <- ko_summary_map %>%
  select(all_of(diazo_nifh_col))

#non-nifh criteria
non_nifh_summary <- ko_summary
diazo_non_nifh1 <- non_nifh_summary[colSums(non_nifh_summary[1:3,]) >= Criteria_cg]
diazo_non_nifh1_col <- colnames(diazo_non_nifh1)
diazo_non_nifh2 <- non_nifh_summary[colSums(non_nifh_summary[4:6,]) >= Criteria_bg]
diazo_non_nifh2_col <- colnames(diazo_non_nifh2)
diazo_non_nifh_col <- intersect(diazo_non_nifh1_col,diazo_non_nifh2_col)
diazo_c2 <- ko_summary_map %>%
  select(all_of(diazo_non_nifh_col))

#diazo
diazo_col <- union(diazo_nifh_col,diazo_non_nifh_col)
diazo_c3 <- ko_summary_map %>%
  select(all_of(diazo_col))

#output diazo table
write.table(diazo_c1,paste(my_path,"/diazo_nifh.tsv",sep=""),sep="\t",col.names = NA, quote = F)
write.table(diazo_c2,paste(my_path,"/diazo_nifs.tsv",sep=""),sep="\t",col.names = NA, quote = F)
write.table(diazo_c3,paste(my_path,"/diazo_nifh_nifs.tsv",sep=""),sep="\t",col.names = NA, quote = F)

#output commond to extract diazo
diazo_cp1 <- as.data.frame(diazo_nifh_col)
diazo_cp1 <- diazo_cp1 %>%
  mutate(com <- paste("cp ",my_genome,"/",diazo_nifh_col,".* ./diazo_nifh_genomes",sep = ""))
names(diazo_cp1) = c("diazo_genome","com")
diazo_cp1 <- diazo_cp1 %>%
  select(com)

diazo_cp2 <- as.data.frame(diazo_non_nifh_col)
diazo_cp2 <- diazo_cp2 %>%
  mutate(com <- paste("cp ",my_genome,"/",diazo_non_nifh_col,".* ./diazo_nifs_genomes",sep = ""))
names(diazo_cp2) = c("diazo_genome","com")
diazo_cp2 <- diazo_cp2 %>%
  select(com)

diazo_cp3 <- as.data.frame(diazo_col)
diazo_cp3 <- diazo_cp3 %>%
  mutate(com <- paste("cp ",my_genome,"/",diazo_col,".* ./diazo_nifh_nifs_genomes",sep = ""))
names(diazo_cp3) = c("diazo_genome","com")
diazo_cp3 <- diazo_cp3 %>%
  select(com)

write.table(diazo_cp1,paste(my_path,"/diazo_cp1_com.txt",sep=""),sep="\t",row.names = F,col.names = F,quote = F)
write.table(diazo_cp2,paste(my_path,"/diazo_cp2_com.txt",sep=""),sep="\t",row.names = F,col.names = F,quote = F)
write.table(diazo_cp3,paste(my_path,"/diazo_cp3_com.txt",sep=""),sep="\t",row.names = F,col.names = F,quote = F)


