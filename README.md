Diaiden (diazotroph identifier)
=======

Diaiden is a pipeline to extract potential diazotrophs from a group of prokaryotic genomes or metagenome-assembled genomes (MAGs). It defines a genome as potential diazotroph based on two criteria:

- `Criteria 1`: The genome carries a gene (or genes) that encodes the nitrogenase nifH.
- `Criteria 2`: The genome carries genes that encode at least two of the three catalytic genes (nifH, nifD, nifK) and at least two of the three biosynthetic genes (nifE, nifN, nifB) for nitrogen fixation.

The only input for this pipeline is a directory of genomes or MAGs.

In brief, Diaiden will predict coding sequences (CDS) using prodigal v2.6.3. Then, CDS will be annotated using diamond v2.1.6 with parameters "--sensitive -k 1 -e 1e-100 --id 50 --query-cover 75 --subject-cover 75" based on nifs sequences downloaded from the KEGG database. Lastly, annotation results will be summarized using R software, and potential diazotrophs will be extracted.

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

mamba install r-base=4.2.3 r-dplyr=1.1.2 -y
#or
#conda install r-base=4.2.3 r-dplyr=1.1.2 -y
```

### Step 2. Download or clone Diaiden ripository
```sh
git clone https://github.com/jchenek/Diaiden.git
```

Usage
-----

```sh
perl /PATH/TO/Diaiden.pl -i /PATH/TO/YOUR/genomes_dir -p /PATH/TO/Diaiden_dir
```

Make sure perl is available in your system.
- `-i`: the path to your directory where genomes or MAGs were stored
- `-p`: the ABSOLUTE path to Diaiden ripository

Results
-----

- `nif_anno_full_info.tsv`: annotations of all provided genomes
- `diazo_nifh.tsv`: potential diazotrophs based on 'Criteria 1'
- `diazo_nifs.tsv`: potential diazotrophs based on 'Criteria 2'
- `diazo_nifh_nifs.tsv`: potential diazotrophs based on either 'Criteria 1' or 'Criteria 2'
- `diazo_nifh_genomes`: extracted genomes based on 'Criteria 1'
- `diazo_nifs_genomes`: extracted genomes based on 'Criteria 2'
- `diazo_nifh_nifs_genomes`: extracted genomes based on either 'Criteria 1' or 'Criteria 2'

Examples
-----

We provided an example directory for testing.

You can open a new terminal in the Diaiden ripository, run the following commands, and see how Diaiden works.

Results from Diaiden will be output at the same path with MAGs directory.

```sh
#activate the diaiden environment
conda activate diaiden
#get the absolute path of Diaiden ripository (not necessary for your analysis)
Diaiden_PATH="$(pwd)" 
perl Diaiden.pl -i ./example/MAGs -p $Diaiden_PATH
```

Publications
------------

Not yet
