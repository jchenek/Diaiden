Diaiden (diazotroph identifier)
=======

Diaiden is a pipeline to extract potential diazotrophs from a group of prokaryotic genomes or metagenome-assembled genomes (MAGs). It defines a genome as potential diazotroph based on two criteria:

1. The genome carries a gene (or genes) that encode the nitrogenase (nifH) for nitrogen fixation.
2. The genome carries a gene (or genes) that encode at least two of the three catalytic genes (nifH, nifD, nifK) and at least two of the three biosynthetic genes (nifE, nifN, nifB) for nitrogen fixation.

The only input for this pipeline is a directory of genomes or MAGs.

In brief, Diaiden will predict coding sequences (CDS) using prodigal v2.6.3. Then, CDS will be annotated using diamond v2.1.6 based on nifs sequences downloaded from the KEGG database. Lastly, annotation results will be summarized using R software, and potential diazotrophs will be extracted.

Installation
---------------

### Step 1. Create a conda environment
```sh
conda config --add channels defaults
conda config --add channels conda-forge
conda config --add channels bioconda
conda config --add channels ursky
conda create -n diaiden -y
conda activate diaiden

#mamba is recommend
mamba install -c bioconda prodigal=2.6.3 diamond=2.1.6 -y
#or
conda install -c bioconda prodigal=2.6.3 diamond=2.1.6 -y

#mamba is recommend
mamba install r-base=4.2.3 r-dplyr -y
#or
conda install r-base=4.2.3 r-dplyr -y
```

### Step 2. Download or clone Diaiden ripository
```sh
git clone https://github.com/jchenek/Diaiden.git
```

Usage
-----

```sh
conda activate diaiden
perl /PATH/TO/Diaiden.pl -i /PATH/TO/YOUR/genomes_dir -p /PATH/TO/Diaiden_dir
```

Diaiden is writen using perl. Make sure perl is available.
- `-i`: input the path to your directory where genomes or MAGs were stored
- `-p`: input the ABSOLUTE path to Diaiden ripository

### Examples

There is an example in Diaiden ripository, in which a directory named 'MAGs' was provided.

You can open a new terminal in the Diaiden directory, run the following commands, and see how Diaiden works.

Results from Diaiden will be output at the same path with MAGs directory.

```sh
conda activate diaiden #activate a conda environment
Diaiden_PATH="$(pwd)" #to get the absolute path of Diaiden ripository, you don't need to do this when you are running your data
perl Diaiden.pl -i ./example/MAGs -p $Diaiden_PATH
```

Publications
------------

Not yet
