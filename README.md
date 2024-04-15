# MosViR - Classification of mosquito viruses in R

The MosViR package offers an easy way to accurately identify complex discriminatory patterns in viral contigs and predict their potential host range The package enhances our ability to capture the diverse genomic landscape of mosquito-associated viruses, Other viruses, Mosquito-specific viruses, and Arboviruses.

The MosViR pipeline demonstrates versatility in classifying mosquito-associated viral sequences, offering several applications:

1) **Exploring the Discriminatory Patterns:** Use MosViR's alignment-free complex discriminatory patterns to explore host-range associations by classifying previously described viruses from various taxonomic organizations and comparing the frequency of specific (1,2)-mers.

2) **Monitoring Host Shifts:** Classify previously described mosquito-associated viruses to monitor potential host shifts, such as transitions from Mosquito-specific viruses to Arboviruses, or even shifts from non-mosquito viruses (e.g., plant viruses) to mosquito-associated viruses.

3) **Classifying Novel Viruses:** Employ the MosViR pipeline to classify unknown viral sequences, providing unique insights into novel viruses and facilitating their classification.

MosViR serves as a groundbreaking tool for researchers, enabling the classification of unknown contigs through host-based classification of previously unexplored sequences. This has practical implications, including the identification of novel pathogens, detection of potential host shifts, and guidance for conducting wet lab experiments.

For detailed methodological insights, performance comparisons, and biological applications, please refer to Andrade et al., 2024 (in press).

![](https://github.com/aandradebio/MosViR/blob/main/GraphicalAbstract1.jpg)

# About the MosViR pipeline 

The MosViR pipeline is released as an R package available at https://doi.org/10.5281/zenodo.10950999. It requires R v. 4 and a previous installation of Biostrings (https://bioconductor.org/packages/Biostrings) and mnmer (https://github.com/labinfo-lncc/mnmer) packages.

The pipeline receives viral contigs as input, obtained by assembling reads from metatranscriptomic sequencing of environmental samples or tissues from the vertebrate host or mosquito vectors. The viral contigs present a minimum size of 500 bp and varying percentages of non-ACTG bases. The pipeline conducts individual analysis for each contig, starting with quality control. This ensures that the occurrence of these bases does not exceed an acceptable threshold, default set at 2%. 

Feature extraction and subset selection are applied to high-quality contigs, with the choice of the classification fragment (500 bp, 1000 bp, 3000 bp, 5000 bp, or 10000 bp) contingent on the length of the input contig. The subset of contigs is influenced by the proximity of sequence length to the specified fragment. 

After the classification, the pipeline produces an output file with probability scores for each input contig. The scores obtained through soft voting indicate the likelihood of the predictive models being right when assigning a contig to its predicted class. These values range from 0.00 to 1.00 and represent the aggregated predicted probabilities across multiple models. The decision-making process for predicting classes relies on these scores, with a standard threshold set at 0.50. The MosViR pipeline uses the 0.50 threshold as default. However, the user can modify this value to adjust the classification stringency or meet specific requirements.

![](https://github.com/aandradebio/MosViR/blob/main/Fig3.png)

# Instalation

The user should install the package from the Zenodo repository. 

```
wget https://zenodo.org/records/10950999/files/MosViR_0.99.1.tar.gz
dentro do R: install.packages (“MosViR_0.99.1.tar.gz”)

OR

library(devtools)
devtools::install_url ("https://zenodo.org/records/10950999/files/MosViR_0.99.1.tar.gz")
```

## The predict_sequences function

The main function of our pipeline, predict_sequences, is designed to handle a FASTA file containing viral contigs. It anticipates the prior usage of Biostrings for importing FASTA files into the R environment. This function divides the sequences from the DNAStringSet object into segments of varying nucleotide lengths. Subsequently, it utilizes the mnmer package to generate feature matrices for testing against previously trained predictive models.

Key Features:

Customization: Users can tailor the function by specifying the number of sequences to load, choosing sequences randomly, and setting a probability score cutoff.

The parameters are:

`seqs` = DNAStringObject. 

`cutoff` = Adjust the probability score threshold. Higher cutoff values can result in accurate positive classifications (Mosquito-associated viruses and Arboviruses) while inflating the False Negative results. Default 0.50 

`all.data` = Select sequences randomly or not. Set TRUE or FALSE

The $predict\_sequences$ function returns a data frame containing the classification outputs, as well as the probability scores for all sequences. 
