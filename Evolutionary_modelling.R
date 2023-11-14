
# Evolutionary modelling

Brownian_Regions <- mvBM(Region_cal3_March23, Regions_update, model = "BM1")
Brownian_trend_Regions <- mvBM(Region_cal3_March23, Regions_update, model = "BM1", param = list(trend = TRUE))

library(mvMORPH)

mvOU1_Regions <- mvOU(Tree, Regionscores, model = "OU1", param = list(root = TRUE))
mvOU1_Regions$LogLik

# Create a manual partition to test variation in evo between clades
Region_cal3_ARCHregime <- paintSubTree(Tree, node=103, state="group_2", anc.state="group_1", stem=TRUE)
plot(Region_cal3_ARCHregime)
mvOU1_Regions_archshift <- mvOU(Region_cal3_ARCHregime, Regionscores, model = "OUM", param = list(root = TRUE))
mvOU1_Regions_archshift$LogLik
mvOU1_Regions_archshift$alpha

Region_cal3_PSEUDOregime <- paintSubTree(Tree, node=146, state="group_2", anc.state="group_1", stem=TRUE)
Region_cal3_AVEregime <- paintSubTree(Tree, node=107, state="group_2", anc.state="group_1", stem=TRUE)
Region_cal3_PSEUDO_AVEregimes <- paintSubTree(Region_cal3_PSEUDOregime, node=107, state="group_3", stem=TRUE)
Region_cal3_ARCH_LEPID_regimes <- paintSubTree(Region_cal3_ARCHregime, node=161, state="group_3", stem=TRUE)


mvOU1_Regions_PSEUDO_AVEshift <- mvOU(Region_cal3_PSEUDO_AVEregimes, Regionscores, model = "OUM", param = list(root = TRUE))
mvOU1_Regions_PSEUDO_AVEshift$LogLik
mvOU1_Regions_PSEUDO_AVEshift$alpha

mvOU1_Regions_AVEshift <- mvOU(Region_cal3_AVEregime, Regionscores, model = "OUM", param = list(root = TRUE))
mvOU1_Regions_AVEshift$LogLik
mvOU1_Regions_AVEshift$alpha

mvOU1_Regions_PSEUDOshift <- mvOU(Region_cal3_PSEUDOregime, Regionscores, model = "OUM", param = list(root = TRUE))
mvOU1_Regions_PSEUDOshift$LogLik
mvOU1_Regions_PSEUDOshift$alpha

mvOU1_Regions_ARCH_LEPIDshift <- mvOU(Region_cal3_ARCH_LEPID_regimes, Regionscores, model = "OUM", param = list(root = TRUE))
mvOU1_Regions_ARCH_LEPIDshift$LogLik
mvOU1_Regions_ARCH_LEPIDshift$alpha


mvOU1_Regions_LEPIDshift <- mvOU(Region_cal3_LEPID_regimes, Regionscores, model = "OUM", param = list(root = TRUE))
mvOU1_Regions_LEPIDshift$LogLik
mvOU1_Regions_LEPIDshift$alpha


mvRR_Regions_ARCH <- mvSHIFT(Region_cal3_ARCHregime, Regionscores, model = "RR")
mvRR_Regions_ARCH$AICc

all_aics_mv_regions <- c(Brownian_Regions$AICc, Brownian_trend_Regions$AICc, mvOU1_Regions$AICc,
                         mvOU1_Regions_archshift$AICc, mvOU1_Regions_PSEUDO_AVEshift$AICc,
                         mvOU1_Regions_AVEshift$AICc, mvOU1_Regions_PSEUDOshift$AICc, mvOU1_Regions_ARCH_LEPIDshift$AICc,
                         mvOU1_Regions_LEPIDshift$AICc) 

Weights(all_aics_mv_regions)

mvMORPH_models_Regions <- cbind(all_aics_mv_regions,Weights(all_aics_mv_regions))
rownames(mvMORPH_models_Regions) <- c("BM", "BM_trend", "OU1", "OUM_Archosaurs", "OUM_pseudo_ornith", "OUM_ornith",
                                      "OUM_pseudo", "OUM_Archosaurs_Lepidosaurs", "OUM_Lepidosaurs")
colnames(mvMORPH_models_Regions) <- c("AICc", "AIC weights")
mvMORPH_models_Regions <- round(mvMORPH_models_Regions, 5)
mvMORPH_models_Regions

# Comparaitve data for all of the models
write.csv(mvMORPH_models_Regions, file = "~/2023/Writing/N-E-E/March2023/mvMORPH_evomodels_regionsNEW.csv")

# Best fit model is mvOU1_Regions_archshift

mvOU1_Regions_archshift$theta
mvOU1_Regions_archshift$alpha

#