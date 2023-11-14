
# Regions analysis

library(geomorph)
library(regions)

#Read in landmark data in nts format - have to manually edit headers and combine individual vertebral landmarks into 3D array
#To combine into 3D array, can manually cut and past matrices into one file (no need to include headers)
Landmarks <- readland.nts("Landmarks.nts") # Can also use 'readland.tps' if that's the format of your landmark data

#Plot the original landmarks
open3d(); plotAllSpecimens(Landmarks, mean = T, label = F, plot.param = list(pt.cex = 0.5, mean.bg = 2, mean.cex = 1.5))

#Generalized procrustes analysis to superimpose raw coordinate data
Procrustes <- gpagen(Landmarks, Proj=TRUE, ProcD=TRUE, curves=NULL, surfaces=NULL)

#PCA
PCA <- gm.prcomp(Procrustes$coords)
summary(PCA)
plot(PCA, main="PCA", pch=19, type="b", axis1=1, axis2=2)

#Save tiff of PCA plot to folder
tiff(file="PCA.tiff", width=1000, height = 600)
plot(PCA, main="PCA", axis1=1, axis2=2, type="b", pch=19)
dev.off()

#In regions package, set independent variable as vert number, or dimension three in aligned coordinate data 
#Need to convert values in regiondata to numeric
Xvar <- as.numeric(dimnames(Procrustes$coords)[[3]])
nvert <- length(Xvar)
Xvar[1:14]

#In regions package, noregions = maximum number of regions
noregions <- 6 # 6 is the maximum

#Runs segmented regression analysis on pc scores from previous PCA analysis
regiondata <- compileregions(Xvar,PCA$x, noregions)

# Choose the numner of PCs to include, including all data can introduces noise
# But my sensitivity analysis suggest that reduction can have unpredictable efffects on the final result
# So I generally use all PCs
nopcos <- 20

#Select best fit model
models <- modelselect(regiondata, noregions, nopcos)

#Compare hypotheses using AIC scores
support <- model_support(models, nvert, nopcos)

rsq <- multvarrsq(Xvar,as.matrix(PCA$x[,1:nopcos]), support$Model_support)
write.csv(rsq, file="chromidotilapia rsq.csv")

#Plot slopes along AP axis. pcono=PC number to plot against - good to check several
plotsegreg(Xvar,pcono=1, data=PCA$x, modelsupport=support$Model_support)

#Plot region breaks
plot_regions <- regionmodel(name="Region model", Xvar=Xvar, regiondata=support$Model_support)
print(plot_regions)


#Save regression plot to file
tiff(file="SLR.tiff", width=1000, height = 600)
plotsegreg(Xvar,pcono=1, data=PCA$x, modelsupport=support$Model_support)
dev.off()

#Save region model to file
tiff(file="regionmodel.tiff", width=1000, height = 600)
regionmodel(name="chromidotilapia", Xvar=Xvar, regiondata=support$Model_support)
dev.off()

#Save model statistics
write.csv(support$Model_support, file="Support_regionmodel.csv")


##
