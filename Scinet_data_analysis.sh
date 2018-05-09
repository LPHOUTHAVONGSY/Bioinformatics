### This script was used to run bioinformatic tools on SciNet for genomic data analysis.

### BUILD DIRECTORY TREE  ##########################################################################
mkdir BIF807
cd BIF807
### mkdir -p allows you to build directories within directories
mkdir -p references/fasta references/bwa
mkdir -p sample1/normal/fastq sample1/normal/fastqc sample1/normal/bwa

####################################################################################################
### SET UP REFERENCE FILES #########################################################################
### copy files
cd references/fasta
cp /scratch/d/danfldhs/mchan/public/inclass/chr22.fa .

### BUILD BWA INDEX ################################################################################
# link file in bw and bulid index. When aligning data you will point to the chr22.fa file located in the same directory as the index files
cd ../bwa
ln -s ../fasta/chr22.fa

module load bwakit
bwa index chr22.fa
# this will create multiple index files. you align you need to point to the chr22.fa file in the same directory as the index files

####################################################################################################
### PROCESS DATA ###################################################################################
cd ../../sample1/normal/fastq
cp /scratch/d/danfldhs/mchan/public/inclass2/normal*gz .

### RUN FASTQC #####################################################################################
cd ../fastqc
# links any gz file in this directory
ln -s ../fastq/*gz .

# run fastqc
module load use.own
module load fastqc
# runs fastqc on all gz files in this directory
fastqc *.gz

### RUN BWA ALIGNMENT ##############################################################################
cd ../bwa

# you may need to load bwakit module if it is not in your session (ie you had created the reference indexes at a different time and now you just want to run the alignment)
# module load bwakit
# @RG is read group information about the sample. alter details per sample
bwa mem -M -R "@RG\tID:SAMPLE1\tSM:SAMPLE1\tPL:Illumina\tPU:Illumina1\tLB:library1" ../../../references/bwa/chr22.fa ../fastq/normal_read1.fastq.gz ../fastq/normal_read2.fastq.gz > S1N.sam

### CONVERT SAM TO BAM FILE ########################################################################
module load java
module load picard-tools
java -jar $SCINET_PICARD_JAR SamFormatConverter I=S1N.sam O=S1N.bam

### COORDINATE SORT BAM ############################################################################
java -jar $SCINET_PICARD_JAR SortSam I=S1N.bam O=S1N_sorted.bam SO=coordinate

### INDEX BAM FILE #################################################################################
# This is for viewing in IGV but not mandatory for downstream analysis
java -jar $SCINET_PICARD_JAR BuildBamIndex I=S1N_sorted.bam

### COLLAPSE DATA ##################################################################################
java -jar $SCINET_PICARD_JAR MarkDuplicates I=S1N_sorted.bam O=S1N_sorted_dedup.bam M=S1N_sorted_dedup.metrics

### INDEX BAM FILE #################################################################################
### THIS STEP is required for next steps
java -jar $SCINET_PICARD_JAR BuildBamIndex I=S1N_sorted_dedup.bam

####################################################################################################
### VARIANT CALLING ################################################################################

### MAKE GATK REFERENCES ###########################################################################
cd ../../../references/
mkdir gatk
cd gatk
ln -s ../fasta/chr22.fa

java -jar $SCINET_PICARD_JAR CreateSequenceDictionary R=chr22.fa O=chr22.dict

module load samtools;
samtools faidx chr22.fa

cp /scratch/d/danfldhs/mchan/public/reference_files/* .

### GATK ###########################################################################################
cd ../../sample1/normal/bwa/
mkdir gatk
cd gatk
module load java
module load GATK

### BASE RECAL ###
# adjust qualities for systematic errors
java -jar $SCINET_GATK_JAR -T BaseRecalibrator -R ../../../../references/gatk/chr22.fa -I ../S1N_sorted_dedup.bam -L chr22 -knownSites ../../../../references/gatk/Mills_and_1000G_gold_standard.indels.chr22.vcf -knownSites ../../../../references/gatk/dbsnp_138.chr22.vcf -o recal_data.table

### PRINT READS ###
java -jar $SCINET_GATK_JAR -T PrintReads -R ../../../../references/gatk/chr22.fa -I ../S1N_sorted_dedup.bam -L chr22 -BQSR recal_data.table -o S1N_sorted_dedup_recal.bam

### HAPLOTYPE CALLER ###
# calls variants
java -jar $SCINET_GATK_JAR -T HaplotypeCaller -R ../../../../references/gatk/chr22.fa -I S1N_sorted_dedup_recal.bam -L chr22 --genotyping_mode DISCOVERY -o S1N_sorted_dedup_recal_raw_variants.vcf

### filters snvs
java -jar $SCINET_GATK_JAR -T SelectVariants -R ../../../../references/gatk/chr22.fa -V S1N_sorted_dedup_recal_raw_variants.vcf -selectType SNP -o S1N_sorted_dedup_recal_raw_variants_SNPs.vcf 

java -jar $SCINET_GATK_JAR -T VariantFiltration -R ../../../../references/gatk/chr22.fa -V S1N_sorted_dedup_recal_raw_variants_SNPs.vcf --filterExpression "QUAL < 100" --filterName "lowqual" -o S1N_sorted_dedup_recal_raw_variants_SNPs_filtered.vcf

# filters indels
java -jar $SCINET_GATK_JAR -T SelectVariants -R ../../../../references/gatk/chr22.fa -V S1N_sorted_dedup_recal_raw_variants.vcf -selectType INDEL -o S1N_sorted_dedup_recal_raw_variants_INDELs.vcf

java -jar $SCINET_GATK_JAR -T VariantFiltration -R ../../../../references/gatk/chr22.fa -V S1N_sorted_dedup_recal_raw_variants_INDELs.vcf --filterExpression "QUAL < 100" --filterName "lowqual" -o S1N_sorted_dedup_recal_raw_variants_INDELs_filtered.vcf


### ANNOVAR #########################################################################################
# make sure you have annovar module in private modules
module load annovar;

table_annovar.pl S1N_sorted_dedup_recal_raw_variants_SNPs_filtered.vcf /scratch/d/danfldhs/mchan/src/annovar/annovar/humandb/  -buildver hg19  -out S1N_sorted_dedup_recal_raw_variants_SNPs_filtered_annotated.vcf -protocol refGene   -operation g -vcfinput


cd ../../../
########################################################################################################
### REPEAT FOR TUMOR ###############################################################################
####################################################################################################
mkdir -p tumor/fastq tumor/fastqc tumor/bwa/gatk

cd tumor/fastq
cp /scratch/d/danfldhs/mchan/public/inclass2/tumor*gz .

### RUN FASTQC #####################################################################################
cd ../fastqc
# links any gz file in this directory
ln -s ../fastq/*gz .

# run fastqc
module load use.own
module load fastqc
# runs fastqc on all gz files in this directory
fastqc *.gz

### RUN BWA ALIGNMENT ##############################################################################
cd ../bwa

# you may need to load bwakit module if it is not in your session (ie you had created the reference indexes at a different time and now you just want to run the alignment)
# module load bwakit
# @RG is read group information about the sample. alter details per sample
bwa mem -M -R "@RG\tID:SAMPLE1T\tSM:SAMPLE1T\tPL:Illumina\tPU:Illumina1\tLB:library1" ../../../references/bwa/chr22.fa ../fastq/tumor_read1.fastq.gz ../fastq/tumor_read2.fastq.gz > S1T.sam

### CONVERT SAM TO BAM FILE ########################################################################
module load java
module load picard-tools
java -jar $SCINET_PICARD_JAR SamFormatConverter I=S1T.sam O=S1T.bam

### COORDINATE SORT BAM ############################################################################
java -jar $SCINET_PICARD_JAR SortSam I=S1T.bam O=S1T_sorted.bam SO=coordinate

### INDEX BAM FILE #################################################################################
# This is for viewing in IGV but not mandatory for downstream analysis
java -jar $SCINET_PICARD_JAR BuildBamIndex I=S1T_sorted.bam

### COLLAPSE DATA ##################################################################################
java -jar $SCINET_PICARD_JAR MarkDuplicates I=S1T_sorted.bam O=S1T_sorted_dedup.bam M=S1T_sorted_dedup.metrics

### INDEX BAM FILE #################################################################################
### THIS STEP is required for next steps
java -jar $SCINET_PICARD_JAR BuildBamIndex I=S1T_sorted_dedup.bam

####################################################################################################
### VARIANT CALLING ################################################################################

### GATK ###########################################################################################
cd gatk
module load java
module load GATK

### BASE RECAL ###
# adjust qualities for systematic errors
java -jar $SCINET_GATK_JAR -T BaseRecalibrator -R ../../../../references/gatk/chr22.fa -I ../S1T_sorted_dedup.bam -L chr22 -knownSites ../../../../references/gatk/Mills_and_1000G_gold_standard.indels.chr22.vcf -knownSites ../../../../references/gatk/dbsnp_138.chr22.vcf -o recal_data.table

### PRINT READS ###
java -jar $SCINET_GATK_JAR -T PrintReads -R ../../../../references/gatk/chr22.fa -I ../S1T_sorted_dedup.bam -L chr22 -BQSR recal_data.table -o S1T_sorted_dedup_recal.bam

### HAPLOTYPE CALLER ###
# calls variants
java -jar $SCINET_GATK_JAR -T HaplotypeCaller -R ../../../../references/gatk/chr22.fa -I S1T_sorted_dedup_recal.bam -L chr22 --genotyping_mode DISCOVERY -o S1T_sorted_dedup_recal_raw_variants.vcf

### filters snvs
java -jar $SCINET_GATK_JAR -T SelectVariants -R ../../../../references/gatk/chr22.fa -V S1T_sorted_dedup_recal_raw_variants.vcf -selectType SNP -o S1T_sorted_dedup_recal_raw_variants_SNPs.vcf 

java -jar $SCINET_GATK_JAR -T VariantFiltration -R ../../../../references/gatk/chr22.fa -V S1T_sorted_dedup_recal_raw_variants_SNPs.vcf --filterExpression "QUAL < 100" --filterName "lowqual" -o S1T_sorted_dedup_recal_raw_variants_SNPs_filtered.vcf

# filters indels
java -jar $SCINET_GATK_JAR -T SelectVariants -R ../../../../references/gatk/chr22.fa -V S1T_sorted_dedup_recal_raw_variants.vcf -selectType INDEL -o S1T_sorted_dedup_recal_raw_variants_INDELs.vcf

java -jar $SCINET_GATK_JAR -T VariantFiltration -R ../../../../references/gatk/chr22.fa -V S1T_sorted_dedup_recal_raw_variants_INDELs.vcf --filterExpression "QUAL < 100" --filterName "lowqual" -o S1T_sorted_dedup_recal_raw_variants_INDELs_filtered.vcf


### ANNOVAR #########################################################################################
# make sure you have annovar module in private modules
module load annovar;

table_annovar.pl S1T_sorted_dedup_recal_raw_variants_SNPs_filtered.vcf /scratch/d/danfldhs/mchan/src/annovar/annovar/humandb/  -buildver hg19  -out S1T_sorted_dedup_recal_raw_variants_SNPs_filtered_annotated.vcf -protocol refGene   -operation g -vcfinput

### MUTECT2 E#######################################################################################
cd ../../../

mkdir mutect2
cd mutect2

java -jar $SCINET_GATK_JAR -T MuTect2 -R ../../references/gatk/chr22.fa --cosmic ../../references/gatk/hg19_cosmic_v54_120711_2.vcf --dbsnp ../../references/gatk/dbsnp_138.chr22.vcf -L chr22 --input_file:normal ../normal/bwa/S1N_sorted_dedup.bam --input_file:tumor ../tumor/bwa/S1T_sorted_dedup.bam -o S1_somatic_variants.vcf

### ANNOVAR ########################################################################################
table_annovar.pl S1_somatic_variants.vcf /scratch/d/danfldhs/mchan/src/annovar/annovar/humandb/  -buildver hg19  -out S1_somatic_variants_annotated.vcf -protocol refGene   -operation g -vcfinput

### DELLY ##########################################################################################
cd ../

mkdir delly;
cd delly;

module load delly;

echo "SAMPLE1T	tumor" > samples;
echo "SAMPLE1	control" >> samples;

delly call -t DEL -o DEL.bcf -g ../../references/fasta/chr22.fa ../tumor/bwa/S1T_sorted_dedup.bam ../normal/bwa/S1N_sorted_dedup.bam
delly filter -t DEL -f somatic -o DEL_somatic_filter.bcf  -s samples DEL.bcf
delly filter -t DEL -f germline -o DEL_germline_filter.bcf  -s samples DEL.bcf

delly call -t DUP -o DUP.bcf -g ../../references/fasta/chr22.fa ../tumor/bwa/S1T_sorted_dedup.bam ../normal/bwa/S1N_sorted_dedup.bam
delly filter -t DUP -f somatic -o DUP_somatic_filter.bcf  -s samples DUP.bcf
delly filter -t DUP -f germline -o DUP_germline_filter.bcf  -s samples DUP.bcf

delly call -t INV -o INV.bcf -g ../../references/fasta/chr22.fa ../tumor/bwa/S1T_sorted_dedup.bam ../normal/bwa/S1N_sorted_dedup.bam
delly filter -t INV -f somatic -o INV_somatic_filter.bcf  -s samples INV.bcf
delly filter -t INV -f germline -o INV_germline_filter.bcf  -s samples INV.bcf

delly call -t TRA -o TRA.bcf -g ../../references/fasta/chr22.fa ../tumor/bwa/S1T_sorted_dedup.bam ../normal/bwa/S1N_sorted_dedup.bam
delly filter -t TRA -f somatic -o TRA_somatic_filter.bcf  -s samples TRA.bcf
delly filter -t TRA -f germline -o TRA_germline_filter.bcf  -s samples TRA.bcf

delly call -t INS -o INS.bcf -g ../../references/fasta/chr22.fa ../tumor/bwa/S1T_sorted_dedup.bam ../normal/bwa/S1N_sorted_dedup.bam
delly filter -t INS -f somatic -o INS_somatic_filter.bcf  -s samples INS.bcf
delly filter -t INS -f germline -o INS_germline_filter.bcf  -s samples INS.bcf

