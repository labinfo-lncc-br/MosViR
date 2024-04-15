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

The pipeline receives viral contigs as input, obtained by assembling reads from metatranscriptomic sequencing of environmental samples or tissues from the vertebrate host or mosquito vectors. 

![](https://github.com/aandradebio/MosViR/blob/main/Fig3.png)
