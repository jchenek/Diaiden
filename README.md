Diaiden (diazotroph identifier)
=======

Diaiden is a pipeline to identify potential `diazotrophs` and their `nifh` sequences from a group of prokaryotic genomes or metagenome-assembled genomes (MAGs). It defines a genome as a potential diazotroph based on two criteria:

- `Criteria 1`: The genome carries a gene (or genes) that encodes the nitrogenase nifH.
- `Criteria 2`: The genome carries genes that encode at least `-c number` of the three catalytic genes (nifH, nifD, nifK) and at least `-b number` of the three biosynthetic genes (nifE, nifN, nifB) for nitrogen fixation.

In brief, Diaiden will predict coding sequences (CDS) using prodigal v2.6.3. Then, CDS will be annotated using diamond v2.1.6 with parameters "--sensitive -k 1 -e 1e-100 --id 50 --query-cover 75 --subject-cover 75" based on nifs sequences downloaded from the KEGG database (2024/03/14 updated). Lastly, annotation results will be summarized using R software, and potential diazotrophs will be extracted.

Installation
---------------

### Step 1. Create a conda environment
```sh
conda config --add channels defaults
conda config --add channels conda-forge
conda config --add channels bioconda
conda config --add channels ursky
conda config --set channel_priority flexible
conda create -n diaiden -y
conda activate diaiden

#mamba is recommend
mamba install r-base=4.4.0 r-dplyr=1.1.4 prodigal=2.6.3 diamond=2.1.6 -y
#or
#conda install r-base=4.4.0 r-dplyr=1.1.4 prodigal=2.6.3 diamond=2.1.6 -y
```

### Step 2. Download or clone Diaiden repository
```sh
git clone https://github.com/jchenek/Diaiden.git
```

Usage
-----

```sh
perl /PATH/TO/Diaiden.pl -i /PATH/TO/YOUR/genomes_dir -p /PATH/TO/Diaiden_dir -c 2 -b 2
```

Make sure perl is available in your system.
- `-i`: the path to your directory where genomes or MAGs were stored
- `-p`: the ABSOLUTE path to Diaiden repository
- `-c`: potential diazotroph must carry genes that encode at least `-c number` of the three catalytic genes (nifH, nifD, nifK)
- `-b`: potential diazotroph must carry genes that encode at least `-b number` of the three biosynthetic genes (nifE, nifN, nifB)

Results
-----

- `nif_anno_full_info.tsv`: annotations of all provided genomes
- `diazo_nifh.tsv`: potential diazotrophs based on 'Criteria 1'
- `diazo_nifs.tsv`: potential diazotrophs based on 'Criteria 2'
- `diazo_nifh_nifs.tsv`: potential diazotrophs based on either 'Criteria 1' or 'Criteria 2'
- `diazo_nifh_genomes`: extracted genomes based on 'Criteria 1'
- `diazo_nifs_genomes`: extracted genomes based on 'Criteria 2'
- `diazo_nifh_nifs_genomes`: extracted genomes based on either 'Criteria 1' or 'Criteria 2'
- `nifh.fna`: extracted nifh nucleotide sequences
- `nifh.faa`: extracted nifh amino acid sequences

Examples
-----

We provided an example directory for testing.

You can open a new terminal in the Diaiden repository, run the following commands, and see how Diaiden works.

Results from Diaiden will be output at the same path as MAGs directory.

```sh
#activate the diaiden environment
conda activate diaiden
#get the absolute path of Diaiden repository
Diaiden_PATH="$(pwd)" 
perl Diaiden.pl -i ./example/MAGs -p $Diaiden_PATH -c 2 -b 2
```

Citing Diaiden
------------
If you use Diaiden in your research, please cite the following papers:

Chen J, Deng L, Wang X, Zhong C, Xia X, Liu H. 2024. Chemosynthetic alphaproteobacterial diazotrophs reside in deep-sea cold-seep bottom waters. mSystems e00176-24.
DOI: [http://dx.doi.org/10.1128/msystems.00176-24](http://dx.doi.org/10.1128/msystems.00176-24)

Hyatt D, Chen G-L, LoCascio PF, Land ML, Larimer FW, Hauser LJ. 2010. Prodigal: prokaryotic gene recognition and translation initiation site identification. BMC Bioinformatics 11:119.

Buchfink B, Xie C, Huson DH. 2015. Fast and sensitive protein alignment using DIAMOND. Nat Methods 12:59–60.


Customized nifH database
-----
- The nifH gene has been commonly used as a marker to assess the distribution and community of diazotrophs (Bonnet et al., 2023; Delmont et al., 2022; Shiozaki et al., 2018). However, recent work by Mise et al. (2021) has shown that approximately 20% of genomes that contain the nifH gene lack the nifDK genes, which encode essential subunits of nitrogenases (Mise et al., 2021). This suggests that nifH alone is not necessarily to be an indicator of diazotrophs. To address this issue, we only considered a genome that contains the three genes encoding catalytic proteins (nifHDK) essential for N fixation as a potential diazotroph genome. 
- Using the Diaiden pipeline, we identified 3,316 potential diazotroph genomes from the Genome Taxonomy Database (GTDB) release R214. In addition, we compiled the 48 diazotroph MAGs recently recovered from the worldwide sunlit ocean (Delmont et al., 2022), resulting in a comprehensive diazotroph database comprising 3,364 genomes. We retrieved nifH gene sequences from these potential diazotroph genomes to create a customized nifH gene database.
- This database can be found in the directory `Customized nifH database`.

- References
```sh
Bonnet, S., Benavides, M., Le Moigne, F. A. C., Camps, M., Torremocha, A., Grosso, O., Dimier, C., Spungin, D., Berman-Frank, I., Garczarek, L., & Cornejo-Castillo, F. M. (2023). Diazotrophs are overlooked contributors to carbon and nitrogen export to the deep ocean. The ISME Journal, 17(1), 47–58. https://doi.org/10.1038/s41396-022-01319-3
Delmont, T. O., Pierella Karlusich, J. J., Veseli, I., Fuessel, J., Eren, A. M., Foster, R. A., Bowler, C., Wincker, P., & Pelletier, E. (2022). Heterotrophic bacterial diazotrophs are more abundant than their cyanobacterial counterparts in metagenomes covering most of the sunlit ocean. The ISME Journal, 16(4), 927–936. https://doi.org/10.1038/s41396-021-01135-1
Mise, K., Masuda, Y., Senoo, K., & Itoh, H. (2021). Undervalued Pseudo- nifH Sequences in Public Databases Distort Metagenomic Insights into Biological Nitrogen Fixers. mSphere, 6(6), e00785-21. https://doi.org/10.1128/msphere.00785-21
