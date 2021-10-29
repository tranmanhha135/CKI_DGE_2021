#!/bin/bash

#Author: Ha Tran
#Date Created: 16/08/21
#Last Modified:

#Description
#Download the raw count data from NCBI, assession (GSE125743).
#Transform the data matrix from csv to tsv
#Delete all non-relevant columns (everything except CKI, CKI-1 and UT treatments
#Move to .tsv file

#Usage
#Excecute first to obtain the data from NCBI and perform appropreate transformations prior to import into R

#Define raw data directory path
RAW_DATA_DIR=~/CKI_DGE/0_data/raw_data

#Download raw count data from NCBI
wget https://ftp.ncbi.nlm.nih.gov/geo/series/GSE125nnn/GSE125743/suppl/GSE125743_refGenes_raw_count.txt.gz -O ${RAW_DATA_DIR}/GSE125743_raw_count.txt.gz

#Gunzip the raw count
gunzip ${RAW_DATA_DIR}/GSE125743_raw_count.txt.gz

#The coloumn name of the raw count data is  misaligned, sed is used to add a string to realign the coloumn
sed -i '1s/^/"delete" /' ${RAW_DATA_DIR}/GSE125743_raw_count.txt

#The first column of the raw count data contains number row, and thus removed with sed. '^\S* ' specific for the first column
sed -i 's/^\S* //g' ${RAW_DATA_DIR}/GSE125743_raw_count.txt

#substitute white space for tab delim
sed -i 's/ /\t/g' ${RAW_DATA_DIR}/GSE125743_raw_count.txt

#cut all unnecessary columns
cut -f 1-19 ${RAW_DATA_DIR}/GSE125743_raw_count.txt > ${RAW_DATA_DIR}/GSE125743_raw_count.tsv

#remove original .txt file
rm ${RAW_DATA_DIR}/GSE125743_raw_count.txt
