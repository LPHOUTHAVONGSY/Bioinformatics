install.packages("plsgenomics")

#call libraries
library(plsgenomics)
library(mclust)

#call data
data(Colon)
dim(Colon$X)
colnames(Colon$X)
attach(Colon)

#creating matrix for colon$X
mat1<-(Colon$X)
dim(mat1)

#transpose variables
tmat1<-t(mat1)
dim(tmat1)

#analysis
mclust_genes<-Mclust(tmat1)
mclust_genesDR<-MclustDR(mclust_genes)
summary(mclust_genesDR)
#cluster 1 = 392 genes
#cluster 2 = 742 genes
#cluster 3 = 866 genes

plot(mclust_genesDR)

#create matrix for cluster
gene_cluster<-matrix(map(mclust_genes$z))

#create matrix for gene names
gene_name<- matrix(Colon$gene.names)

#combine matrix gene names with cluster
gene<-cbind(gene_name,gene_cluster)

#separating out clusters from gene matrix
cluster_1<-gene[which(gene[,2]==1)]
cluster_1
cluster_2<-gene[which(gene[,2]==2)]
cluster_2
cluster_3<-gene[which(gene[,2]==3)]
cluster_3
