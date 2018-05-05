# BIF705
# Lab 5
# 14 February 2018
# This lab can be done in groups of 2-3. Include a comment below this header listing the names of the students who contributed. Each of you need to submit a copy of this lab via MySeneca.

# ----------------------------------------------------------------------
# PART ONE: GENETIC ASSOCIATION TESTS
# ----------------------------------------------------------------------
########################################################################
# Question 1: Comment on the association between sex and disease status.
########################################################################

#Comment: P-value < 0.05 (X-squared = 80.14, df = 1, p-value < 2.2e-16) therefore, some factors other than chance is operating for the deviation.
#This means the there is an association between the sex and the disease status.


########################################################################
# Question 2: Test for HWE in all four SNPs and conclude.
########################################################################


#Comment: P-value > 0.05 for all genotypes, therefore, accept the null hypothesis and that
#the observed and expected values are not significantly different, and that the population is within the Hardy Weinberg equilibrium.


#HWE.chisq(genotype(A)) = X-squared = 0.34488, df = NA, p-value = 0.5906
#HWE.chisq(genotype(B)) = X-squared = 0.56038, df = NA, p-value = 0.4849
#HWE.chisq(genotype(C)) = X-squared = 2.0354, df = NA, p-value = 0.1656
#HWE.chisq(genotype(D)) = X-squared = 1.2348, df = NA, p-value = 0.2634


########################################################################
# Question 3: Repeat this analysis for the four SNPs and conclude.
#######################################################################

#Comment: P-values < 0.05, therefore, some other factors than chance is operating
#This means, there is an association between the disease status and the genetic variants.

#t1<-table(A, affected) 
#chisq.test(t1) = X-squared = 23.738, df = 2, p-value = 7.003e-06


#t2<-table(B, affected) 
#chisq.test(t2) = X-squared = 15.063, df = 2, p-value = 0.0005358

#t3<-table(C, affected) 
#chisq.test(t3) = X-squared = 30.678, df = 2, p-value = 2.18e-07

#t4<-table(D, affected) 
#chisq.test(t4) = X-squared = 30.549, df = 2, p-value = 2.325e-07



########################################################################
# Question 4: Repeat this analysis for the four SNPs and conclude.
########################################################################


#Comment: P-values < 0.05, therefore, some other factors than chance is operating
#This means, there is an association between the allele frequencies for cases and controls.


#data:t1A = X-squared = 23.688, df = 1, p-value = 1.133e-06

#data: t2A = X-squared = 14.484, df = 1, p-value = 0.0001413

#data:t3A = X-squared = 31.316, df = 1, p-value = 2.193e-08

#data:t4A = X-squared = 28.922, df = 1, p-value = 7.537e-08



# ----------------------------------------------------------------------
# PART TWO: GWAS
# ----------------------------------------------------------------------

# Add comments to the below R script explaining what the commands are doing and the usefulness of the commands.
# Refer to the GenABEL tutorial, Chapter 5 on GWAS

#install "GenABEL" package
install.packages("GenABEL")
#load GenABEL package
library(GenABEL)
#load the data
data(ge03d2ex)
#name the data "gwastut"
gwastut<-ge03d2ex

#create oject of the class gwaa.data
class(gwastut)
#check names of variables in the phenotype data frame
names(phdata(gwastut))
#attach the data frame to the R search path
attach(phdata(gwastut))

# DATA DESCRIPTIVES, FIRST ROUND GWA ANALYSIS

#describe which traits are present in the loaded data
descriptives.trait(gwastut)
#produce a summary for type 2 diabetes cases and contorls and separately and compare distrubutions of the trait
descriptives.trait(gwastut,by=dm2)
#product grand GW descriptives of the marker
descriptives.marker(gwastut)
#test the GW marker characteristics in contorls
descriptives.marker(gwastut,ids=(dm2==0))
#report the distribution of cases and report only table two
descriptives.marker(gwastut,ids=(dm2==1))[2]
#report the distribution of controls and report only table two
descriptives.marker(gwastut,ids=(dm2==0))[2]



#Compute summary SNP statistics
s1<-summary(gtdata(gwastut[(dm2==1),]))
#observe first 5 rows of the summary above
s1[1:5,]
#select Pexact value from the summary(which containts p-values) and assign it to pexcas
pexcas<-s1[,"Pexact"]
#characterize dummulative distribution
catable(pexcas,c(0.001,0.01,0.05,0.1,0.5),cumulative=T)
#fast score test for association, type2 diabetes
an0<-qtscore(dm2,gwastut,trait="binomial")
#display the information
an0
#observe to see if there is evidence for the information of the test statistics; obtain lambda
lambda(an0)
# estimation of lambda and production of the x^2 - x^2 plot
estlambda(an0[,"P1df"],plot=T)
#plot "Manhatten plot" (consistis of SNP genomic position on x-axis and log10 of the P-value on y-axis)
plot(an0)
#add corrected P-values to the plot
add.plot(an0,df="Pc1df",col=c("lightblue","lightgreen"))
#product descriptive table for the Top p-value results
descriptives.scan(an0)
#Compute empiricial GW significance
an0.e<-qtscore(dm2,gwastut,times=200,trait="binomial")
#produce the summary of the above results
descriptives.scan(an0.e,sort="Pc1df")

# GENETIC DATA QC

#Set the HWE P-value selection threshold to zero
qc1<-check.marker(gwastut,p.level=0)
#produce the summary of the qc1
summary(qc1)
#the object returned by check.markers()
names(qc1)
#Product a new data set which consists of people and markers
data1<-gwastut[qc1$idok,qc1$snpok]
# fix residual sporadic X-errors (male heterozygosity)
data1<-Xfix(data1)
#detach the data "gwastut"
detach(phdata(gwastut))
#attach new data, "data1"
attach(phdata(data1))

#explained in above lines
descriptives.marker(data1)[2]
descriptives.marker(data1[dm2==1,])[2]
descriptives.marker(data1[dm2==0,])[2]

# GENETIC SUBSTRUCTURE

#Compute a matrix of genomic kinship between all pairs of individuals by using only autosomal markers
data1.gkin<-ibs(data1[,autosomal(data1)],weight="freq")
# View only the upper left matrix
data1.gkin[1:5,1:5]
#transform the above matrix into distance matrix
data1.dist<-as.dist(0.5-data1.gkin)
#perform Classical MUltidimensional Scaling
data1.mds<-cmdscale(data1.dist)
# Plot the result
plot(data1.mds)
#Identify the potins that belong to clusters with the following commands:
km<-kmeans(data1.mds,centers=2,nstart=1000)
cl1<-names(which(km$cluster==1))
cl2<-names(which(km$cluster==2))
if(length(cl1)>length(cl2)){
    x<-cl2
    cl2<-cl1
    cl1<-x
}
cl1
cl2
#from a data set using only with people from the larger cluster; ignore outliners
data2<-data1[cl2,]
# repeat QC
qc2<-check.marker(data2,hweids=(phdata(data2)$dm2==0),fdr=0.2)
#diplay the summary
summary(qc2)
#drop a few markers since some markers do not pass QC
data2<-data2[qc2$idok,qc2$snpok]
#detach the data1
detach(phdata(data1))
#attach the data2
attach(phdata(data2))

#CHekc if QC improved the fit of genetic data to HWE
descriptives.marker(data2)[2]
descriptives.marker(data2[phdata(data2)$dm2==0,])[2]

# GWA ASSOCIATION ANALYSIS

#Produce the descriptive table of the phenotypic and marker data
descriptives.trait(data2,by=dm2)
#Check the descriptive of markers
descriptives.marker(data2)[2]
# Run the socre test
data2.qt<-qtscore(dm2,data2,trait="binomial")
# check lambda
lambda(data2.qt)
#produce association anlaysis plot
plot(data2.qt,df="Pc1df")
#produce the scan summary
descriptives.scan(data2.qt,sort="Pc1df")
#compare with the top10 from the scan prior to QC
data2.qte<-qtscore(dm2,data2,times=200,trait="binomial")
descriptives.scan(data2.qte,sort="Pc1df")
# Adjust for sex and age
data2.qtae<-qtscore(dm2~sex+age,data2,times=200,trait="binomial")
descriptives.scan(data2.qtae)
#perform BMI anlaysis
data2.qtse<-qtscore(dm2~sex+age,data2,ids=((bmi>30 & dm2==1)|dm2==0),times=200,trait="binomial")
descriptives.scan(data2.qtse)
