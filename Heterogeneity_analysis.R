
# Intracolumnar heterogeneity analysis

library(geomorph)
library(regions)

# Import the landmark data
Landmarks <- readland.Landmarks("Alligator_mississippiensis_landmarks.txt", specID = "ID", readcurves = F, warnmsg = T)
Landmarks <- Landmarks[,c(2:4),] # In my tps files the first column is a set of blank elements so this is just getting rid of that

dim(Landmarks)[3] # how many vertebrae are in this set

Procrustes <- procSym(Landmarks)

# Make an empty matrix to fill in with the data from the loop
Procrustes_distances <- matrix(data = NA, nrow = dim(Landmarks)[3], ncol = dim(Landmarks)[3])

# This loop extracts every procrustes distance for every pair of vertebrae in the sample
for (j in c(1:dim(Landmarks)[3])){
  
  for (i in c(1:dim(Landmarks)[3])){
    PD_VN_VN <- procdist(Procrustes$orpdata[,,j], Procrustes$orpdata[,,i], type = "full", reflect = F)
    
    Procrustes_distances[i,j] <- PD_VN_VN 
  }
} 

# Put it into a vector
Procrustes_distances <- c(Procrustes_distances)

# At this point there are a lot of repeated values in the set
# We have the procdist for V3 and every other element, V4 and every other element (including V3)
# and so on...
# So we need to extract the unique distances
Procrustes_distances <- unique(Procrustes_distances)
# Check the number of values we have
# in case of the very small chance two procdistances are the same so too many have been removed
# This has never happened to me, but it's good to be sure
length(Procrustes_distances)

# Take the mean!
Heterogeneity <- mean(Procrustes_distances)
Heterogeneity <- Heterogeneity/dim(Landmarks)[3] # Weight the heterogeneity by number of vertebrae
# This is the metric for the degree of intracolumnar heterogeneity in the sampled column

###