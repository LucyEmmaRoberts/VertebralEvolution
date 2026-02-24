# Data from: Evolution of the reptile spine reveals independent trajectories to axial skeletal complexity in amniotes

## Contents:

##### DATA

1\. Scans
2\. Landmarks
3\. Dated phylogeny

##### CODE

3\. Regions_analysis.R
4\. Heterogeneity_analysis.R
5\. Evolutionary_modelling.R
6\. Ancestral_states.R

## Details: DATA

### 1. Scans

Scan and mesh data for all specimens.
Corresponding specimen information is available in the supplementary information of the paper.

### 2. Landmarks

3D coordinates for each specimen used to quantify regionalization and heterogeneity.
In TPS format. Collected using IDAV Landmark software.

### 3. Dated phylogeny

Time-calibrated phylogenetic supertree used in ancestral state reconstruction and evolutionary modelling.
Dated using *paleotree.*

## Details: CODE (Code.zip)

### 4. Regions_analysis.R

Code written to quantify the number and distribution of regions in a vertebral column. 3D geometric morphometric analysis of a vertebral column, given landmark coordinate data; and for analysis of regionalization.
Modified for 3DGMM from Jones *et al* 2018 following Head and Polly 2015.

### 5. Heterogeneity_analysis.R

Code written to quantify of the total amount of morphological variation in a set of models;
by taking the mean of the pairwise Procrustes distances.
Here for vertebral elements, but would work for quantifying morphological disparity in any data set.

### 6. Evolutionary_modelling.R

Code written to test evolutionary models.

### 7. Ancestral_states.R

Code written to model ancestral states, continuous and discrete; and to plot data on a phylogeny.

## Description of the data and file structure

'Scans_meshes.zip' contains .ply files for all of the vertebral elements.
'Landmarks.zip' contains Landmark coordinate data in TPS formatted .txt files. Data for each specimens is in separate folders.
Nexus formatted phylogeny 'Phylogeny.nex'
'Code' folder contains Regions_analysis.R, Heterogeneity_analysis.R, Evolutionary_modelling.R & Ancestral_states.R

## Additional information: Code/Software

Code is all based in R and is available via [https://github.com/LucyEmmaRoberts/VertebralEvolution](https://github.com/LucyEmmaRoberts/VertebralEvolution)

This code was created and tested using R version 4.3.2 on a PC running Windows 10.

To use this code install R and any required packages listed within the code. Typical install for all packages should take <10 minutes.

All usage instructions are within the code as #comments. Demo using the data included here.

