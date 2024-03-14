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
mamba install -c bioconda prodigal=2.6.3 diamond=2.1.6 -y
#or
#conda install -c bioconda prodigal=2.6.3 diamond=2.1.6 -y

mamba install r-base r-dplyr=1.1.2 -y
#or
#conda install r-base r-dplyr=1.1.2 -y
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

Publications
------------

Chemosynthetic Alphaproteobacterial diazotrophs reside in deep-sea cold-seep bottom waters. 2024. under review.
