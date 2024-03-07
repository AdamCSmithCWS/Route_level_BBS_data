## route-level BBS data extraction for species



library(bbsBayes2)
library(tidyverse)

# run to download recent data
#fetch_bbs_data()

all_bbs_data <- load_bbs_data()

#extract a species list to support the species loop below
sps_bbs <- all_bbs_data$species %>% 
  filter(unid_combined == TRUE) %>% 
  mutate(latin = paste0(genus,species)) %>% 
  arrange(seq)

route_latlongs <- all_bbs_data$routes %>% 
  select(country_num,
         state_num,
         route,
         latitude,
         longitude) %>% 
  distinct() %>% 
  rowwise() %>% 
  mutate(route = paste(state_num,route,sep = "-"))

stratification <- "bbs_usgs" #using this stratifcation appends BCR and Country, Province/State inforemation. 
all_data <- NULL # empty object filled with species-specific data
for(i in 1:nrow(sps_bbs)){
  
  sp_numeric <- sps_bbs[i,"aou"] #unique numeric id for "species" taxonomic unit in BBS dtabase
  sp_eng <- sps_bbs[i,"english"] #english name
   sp_latin <- paste(sps_bbs[i,"latin"]) #latin name Check-list of North American Birds (up to and including the 63rd Supplement: Ornithology, Volume 139, Issue 3, https://doi.org/10.1093/ornithology/ukac020)

   sp_data <- try(stratify(by = stratification,
                       species = sp_eng) %>% 
     prepare_data(.,
                  min_n_routes = 1,
                  min_max_route_years = 2), silent = TRUE)# try is to catch errors when species has insufficient data
   
   
if(class(sp_data) == "try-error"){ 
  rm(list = c("sp_data"))
  next}
   sp_df <- sp_data[["raw_data"]] %>% 
     left_join(., route_latlongs,
               by = c("country_num","state_num","route")) %>% 
     mutate(english = sp_eng,
            aou = sp_numeric,
            latin = sp_latin)

  all_data <- bind_rows(all_data,
                        sp_df)
  
  rm(list = c("sp_df","sp_data"))
}

if(any(is.na(sp_df$latitude))){
  stop("At least one route is missing latitude data")
}



saveRDS(all_data,"all_data_with_zeros.RDS")




