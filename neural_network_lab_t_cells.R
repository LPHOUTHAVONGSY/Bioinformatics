# Larry Phouthavongsy
# Lab 10

source("http://www.bioconductor.org/biocLite.R")
# biocLite()
biocLite("ALL")
biocLite("hgu95av2.db")

library(ALL)
?ALL
data(ALL)
library(hgu95av2.db)
ALLB123 <- ALL[,ALL$BT %in% c("T1","T2","T3")]
pano <- apply(exprs(ALLB123), 1, function(x) anova(lm(x ~ ALLB123$BT))$Pr[1])
names <- featureNames(ALL)[pano<0.000001]
symb <- mget(names, env = hgu95av2SYMBOL)
ALLBTnames <- ALLB123[names, ]
probedat <- as.matrix(exprs(ALLBTnames))
row.names(probedat)<-unlist(symb)

Y <- factor(ALLBTnames$BT)
X <- t(probedat)

i=1
j=2
count=0
while(i < length(names)){
	print(paste("i=",i))
	while (j <=length(names)){
		plot(X[,i],X[,j],xlab=symb[[i]],ylab=symb[[j]],pch=19,col=Y)
		print(paste("j=",j))
		j<-j+1
		count=count+1
	}
	i=i+1
	j=i+1
}
print(paste("count=",count))

library(nnet)

df <- data.frame(Y = Y, X = X[, sample(ncol(X), 1)])
nnest <- nnet(Y ~ .,data = df, size = 5, maxit = 500, decay = 0.01, MaxNWts = 5000)
pred <- predict(nnest, type = "class")
table(pred, Y)

i <- sample(1:78, 39, replace=FALSE)
noti <- setdiff(1:78,i)
nnest.t <- nnet(Y ~ ., data = df,subset=i, size = 5,decay = 0.01, maxit=500)
prednnt <- predict(nnest.t, df[i,], type = "class")
table(prednnt,Ytrain=Y[i])
prednnv <- predict(nnest.t, df[noti,], type = "class")
table(prednnv, Yval= Y[noti])

