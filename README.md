# Using bbsBayes2 to extract and zero-fill route-level BBS counts

A simple script to extract the route-level BBS counts and zero-fill all surveys conducted on routes on which the species has been observed at some point since 1966.

Downloads and manipulates the data using the package [bbsBayes2](https://bbsbayes.github.io/bbsBayes2). This route-level extraction is useful for custom summaries or modeling of the BBS data, outside of the `bbsBayes2` package. 

This script loops through all species/taxonomic-units in the BBS database and pulls data from all routes in the United States and Canada. Post-hoc filtering can be accomplished based on the Bird Conservation Region, political jurisdiction, latitude, longitude, or other factors that are appended to the route-level counts.

