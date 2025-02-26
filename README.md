# Visualizing multiscale socio-ecological interactions using Flickr data

## Description

This interactive web application has been designed to provide an easy-to-use 
interface for visualizing socio-ecological interactions at different scales in 16 
case studies across Europe. It was developed as part of a research project 
funded by the [ALTER-Net](http://www.alter-net.info/) network through the 
[AHIA](http://www.alter-net.info/ahia) funding instrument. In this project, 
we define a socio-ecological interaction as the presence of an individual in a 
given zone of a site during a given hour. Socio-ecological interactions have 
been extracted from a Flickr database containing more than 150,000 photographs 
taken by about 2,000 users between 2000 and 2017 in the 16 case study sites. 
A script (in R) showing how to get the list of public photos for a list of 
Flickr users is available from [here](https://github.com/maximelenormand/Flickr). 
Each photograph has been manually validated and classified in order to 
identify different types of interactions (landscape, recreational activity, etc.). 
In practice, I divided every site into zones using square grid cells with a side 
length of 500 meters. I also identified the place of residence of every user 
based on their Flickr timeline using 100 x 100 km² grid cells. Flickr 
users have been separated into two groups (locals & visitors) according to the 
distance between their place of residence and the sites. At the end of the 
process, we obtained a multiscale socio-ecological network composed of 7,354 
socio-ecological interactions from 365 distinct places of residence around 
the world to 3,418 grid cells located in 16 study sites.

This interactive application focuses on the visualization of several 
characteristics of the network at different scales: spatial interactions 
(global scale), spatial and temporal distributions of interactions 
(local scale), and the distribution of interactions according to the type of 
interaction (local scale).

## Interactive web application

This repository contains all the material (R scripts, Rdata, and www data folder) 
needed to run [the app](https://ahia.sk8.inrae.fr).

## Reference and citation

If you use this code, please cite the following reference:

Lenormand M *et al.* (2018) [Multiscale socio-ecological networks in the age of information.](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0206672) 
*PLOS ONE* 13, e0206672.

If you need help, find a bug, want to give me advice or feedback, please contact me!

## Repository mirrors

This repository is mirrored on both GitLab and GitHub. You can access it via the following links:

- **GitLab**: [https://gitlab.com/maximelenormand/AHIA](https://gitlab.com/maximelenormand/AHIA)  
- **GitHub**: [https://github.com/maximelenormand/AHIA](https://github.com/maximelenormand/AHIA)  

The repository is archived in Software Heritage:

[![SWH](https://archive.softwareheritage.org/badge/origin/https://github.com/maximelenormand/AHIA/)](https://archive.softwareheritage.org/browse/origin/?origin_url=https://github.com/maximelenormand/AHIA)

