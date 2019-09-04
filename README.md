
Multiscale socio-ecological interactions
========================================================================

## Description

This interactive web application has been designed to provide an easy-to-use interface to visualize socio-ecological interactions at different scales in 16 case studies across Europe. It was developed as part of a research project funded by the [ALTER-Net](http://www.alter-net.info/) network through the [AHIA](http://www.alter-net.info/ahia) funding instrument. In this project, we define a socio-ecological interaction as the presence of an individual in a given zone of a site during a given hour. Socio-ecological interactions have been extracted from a Flickr database containing more than 150,000 photographs taken by about 2,000 users between 2000 and 2017 in the 16 case study sites. A script (in R) showing how to get the list of public photos for a list of Flickr users is available from [here](http://www.maximelenormand.com/Codes). Each photograph has been manually validated and classified in ordrer to identify different types of interactions (landscape, recreational activity...). In practice, I divided every sites in zones using square grid cells with a side length of 500 meters. I also identified the place of residence of every users based on their Flickr timeline using a 100 x 100 km^2 world grid cells. Flickr users have been separated into two groups (locals & visitors) according to the distance between their place of residence and the sites. At the end of the process we obtain a multiscale socio-ecological network composed of 7,354 socio-ecological interactions from 365 distinct places of residence all over the world to 3,418 grid cells located in 16 study sites.

This interactive application focuses on the visualisation of several characteristics of the network at different scales: spatial interactions (global scale), spatial and temporal distributions of interactions (local scale) and distribution of interactions according to the type of interaction (local scale).

## Interactive web application

This repository contains all the material (R scripts, Rdata and WWW data folder) needed to run [the app](https://maximelenormand.shinyapps.io/AHIA/). 

## Citation

If you use this code, please cite:

Lenormand M *et al.* (2018) [Multiscale socio-ecological networks in the age of information](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0206672) *PLoS ONE* 13, e0206672.

If you need help, find a bug, want to give me advice or feedback, please contact me!
You can reach me at maxime.lenormand[at]irstea.fr
