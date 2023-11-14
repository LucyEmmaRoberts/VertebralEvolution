
# Ancestral states

library(phytools)
library(paleotree)
library(strap)


# 1 STOCHASTIC CHARACTER MAPPING - anc states for discrete values ####

# Each of these makes 100 stochastic character maps, under different models:
# Equal rates
treesER_2023 <-make.simmap(Region_cal3_March23, Regions_dis_2023, model="ER", nsim=100)
objER_2023 <- summary(treesER_2023,plot=FALSE)
# Symmetrical rates
treesSYM_2023 <-make.simmap(Region_cal3_March23, Regions_dis_2023, model="SYM", nsim=100)
objSYM_2023 <- summary(treesSYM_2023,plot=FALSE)
# All-rates different
treesARD_2023 <-make.simmap(Region_cal3_March23, Regions_dis_2023, model="ARD", nsim=100)
objARD_2023 <- summary(treesARD_2023,plot=TRUE)

# Extract the log likelihoods and degrees of freedom for each
treesER_2023[[1]]$logL
ER_2023_lik <- as.numeric(treesER_2023[[1]]$logL)
ER_df <- 1

treesSYM_2023[[1]]$logL
SYM_2023_lik <- as.numeric(treesSYM_2023[[1]]$logL)
SYM_df <- 3

treesARD_2023[[1]]$logL
ARD_2023_lik <- as.numeric(treesARD_2023[[1]]$logL)
ARD_df <- 6


ER_2023_lik # -105.4668
SYM_2023_lik # -86.84635
ARD_2023_lik # -81.3769

# Compare the log likelihoods for each pair of models
1 - pchisq(2*(ER_2023_lik - SYM_2023_lik), 2)
1 - pchisq(2*(ER_2023_lik - ARD_2023_lik), 5)
1 - pchisq(2*(SYM_2023_lik - ARD_2023_lik), 3)
# I like to do it forwards and backwards for completeness
1 - pchisq(2*(SYM_2023_lik - ER_2023_lik), 2)
1 - pchisq(2*(ARD_2023_lik - ER_2023_lik), 5)
1 - pchisq(2*(ARD_2023_lik - SYM_2023_lik), 3)
# Here the all-rates different model is the best
# So that's what we're going to plot

# 2 PLOTTING ANCESTRAL STATES ####

# Extract the tipstates for regions
Tipstates <- objARD_2023$tips

# Plot of contunous ancestral state estimation
cont_Hetero_update <- contMap(Tree, Heterogeneity, fsize = 0.5,sig=1,
                              legend=1, outline = FALSE, lims = c(min(Heterogeneity),max(Heterogeneity)))


# Plot regions tip states, node anc and heterogenetiy states on one plot:
plot.new()
svg("Region_hetero_anc_results.svg", width=10, height=10, bg = "transparent") # Saves the figure

plotSimmap(cont_Hetero_update_cols$tree,cont_Hetero_update_cols$cols,type="fan",
           ftype = "off", lwd = 2.5, part = 0.92) # plots the tree with hetero states as branch colours

nodelabels(node = as.numeric(rownames(objARD_2023$ace)[c(1:95)]), pie = objARD_2023$ace, 
           piecol = NewRegionCols, cex = 0.5) # Plots ancestral states for regions at nodes

tiplabels(pie = Tipstates, piecol = NewRegionCols, 
          cex = 0.4) # plots region tip states

dev.off()




###
