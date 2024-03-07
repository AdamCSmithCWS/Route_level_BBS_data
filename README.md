# Using bbsBayes2 to extract and zero-fill route-level BBS counts

A simple script to extract the route-level BBS counts and zero-fill all surveys conducted on routes on which the species has been observed at some point since 1966. Following the approach taken in most previous analyses of BBS data (e.g., [Sauer and Link 2011](http://doi.org/10.1525/auk.2010.09220) and [Smith et al. 2023](https://doi.org/10.1093/ornithapp/duad056)), routes on which the species has never been observed are dropped from the dataset for that species. The main BBS database consists of two primary data tables: 1) the counts (number of individual birds) of each species observed during any BBS survey; and 2) the date, time, location, and other pertinent information for every BBS survey conducted. The appropriate zero-values are added by combining information from these two tables, adding zeros for all surveys for which there is no count information, but on routes where the species has been observed at some point.

The approach here downloads and manipulates the data using the package [bbsBayes2](https://bbsbayes.github.io/bbsBayes2). This route-level extraction is only useful for custom summaries or modeling of the BBS data, outside of the `bbsBayes2` package. 

This script loops through all species/taxonomic-units in the BBS database and pulls data from all routes in the United States and Canada. Post-hoc filtering can be accomplished based on the Bird Conservation Region, political jurisdiction, latitude, longitude, or other factors that are appended to the route-level counts.

