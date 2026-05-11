## Instructions (assuming you are using RStudio):
## 1. Copy this script to an R script and save it anywhere.
##    It doesn't matter where it is saved or the name, but I suggest `global.R` for the name.
## 2. Run the script. It may take a while to install all packages the first time
##    and RStudio will automatically restart and open the new project. The R script will be copied into the
##    the project folder and all packages will be installed into a project-specific library.
## 3. Re-run the script after the automatic restart. The original R script can now be deleted (from Step 1).
## 4. For future runs, use the project/global.R, and to avoid the automatic restart,
##    make sure the RStudio project is open.

options(repos = c(getOption("repos"), PE = "https://predictiveecology.r-universe.dev/"))

if (!require("pak")) install.packages("pak")
pak::pak(c("PredictiveEcology/Require@usePak",
           "PredictiveEcology/SpaDES.project@working/combined-prs"),
         lib = .libPaths(), ask = FALSE)

Require::Require("SpaDES.project", install = FALSE)

## please choose where you want the project directory to be placed.
projLocation <- "C:/Users/ANCAG6/Documents"

out <- setupProject(name = "SpaDES-gvaMapping",
                    paths = list(projectPath = file.path(projLocation, "SpaDES-gvaMapping")),
                    modules = "andres-acg/gvaMapping",
                    times = list(start = 1, end = 1),
                    Restart = TRUE,
                    useGit = TRUE)

SpaDES.core::simInitAndSpades2(out)



################################################################################
############                   TEST             ################################
################################################################################


options(repos = c(getOption("repos"), PE = "https://predictiveecology.r-universe.dev/"))

if (!require("Require")) install.packages("pak") #I needed to install pak by hand
pak::pak(c("PredictiveEcology/Require@usePak",
           "PredictiveEcology/SpaDES.project@working/combined-prs"),
         lib = .libPaths(), ask = FALSE)

Require::Require("SpaDES.project", install = FALSE)

# ------------------------------------------------------------
# Choose project location
# ------------------------------------------------------------

projLocation <- "C:/Users/ANCAG6/OneDrive - Université Laval/LICHEN_project/paper1/SpaDES_version/"

# ------------------------------------------------------------
# DEFINE PARAMETERS (THIS IS THE KEY PART)
# ------------------------------------------------------------
params <- list(
  gvaMapping = list(
    
    # ------------------------------------------------------------
    # Measurement
    # ------------------------------------------------------------
    measure_class = "intensive",
    measure_name  = "Biomass",
    unit          = "kg ha⁻¹",
    
    # ------------------------------------------------------------
    # Sampling sizes (REPLACES dataset1..dataset5)
    # ------------------------------------------------------------
    sampling_size_m2 = c(
      dataset1 = 1,
      #dataset2 = 1,
      #dataset3 = 100,
      #dataset4 = 2,
      dataset2 = 0.25
    ),
    
    # ------------------------------------------------------------
    # Target GVA (same as before)
    # ------------------------------------------------------------
    target_gva = c(
      "mitis", "Cladmit", "MIT", "CLMI",
      "arbuscula", "Cladarb", "ARB",
      "rangiferina", "Cladran", "RAN", "CLRA",
      "stygia", "Cladsty", "STY",
      "stellaris", "Cladste", "STE", "CLST",
      "uncialis", "Cladunc", "unc", "CLADUNC",
      "amaurocrea", "Cladama", "AMA",
      "spp."
    ),
    
    # ------------------------------------------------------------
    # Land cover products (REPLACES name_land_cover1..4)
    # ------------------------------------------------------------
    list_of_land_cover_names = c(
       "LCC10", "ABoVE", "NTEMS"    #"MVI",
    ),
    
    land_cover_year = 2010,
    
    # ------------------------------------------------------------
    # Inapplicable classes (REPLACES individual parameters)
    # ------------------------------------------------------------
    inapplicable_classes_list = list(
      #c(11, 12, 20, 31, 34),
      c(17, 18),
      c(13, 15),
      c(20, 31)
    ),
    
    # ------------------------------------------------------------
    # Water classes
    # ------------------------------------------------------------
    water_classes_list = list(
     # 20,
      18,
      15,
      20
    ),
    
    # ------------------------------------------------------------
    # Abbreviations (REPLACES abbr_land_coverX)
    # ------------------------------------------------------------
    abbrev_list = list(
      # c(
      #   "11"  = "Shadow",
      #   "12"  = "Cloud",
      #   "20"  = "20-Water",
      #   "31"  = "Snow/\nIce",
      #   "32"  = "Rock/\nRubble",
      #   "33"  = "Exposed \nland",
      #   "34"  = "34-Roads*",
      #   "40"  = "40-Bryoids*",
      #   "51"  = "51-Shrub \ntall*",
      #   "52"  = "52-Shrub \nlow",
      #   "81"  = "81-Wet.-\ntreed",
      #   "82"  = "82-Wet.-\nshrub",
      #   "83"  = "83-Wet.-\nherb*",
      #   "100" = "Herb",
      #   "211" = "211-Conif.\ndense",
      #   "212" = "212-Conif.\nopen",
      #   "213" = "213-Conif.\nsparse",
      #   "221" = "221-Broad.\ndense*",
      #   "222" = "222-Broad.\nopen*",
      #   "223" = "Broad.\nsparse",
      #   "231" = "231-Mixed.\ndense*",
      #   "232" = "232-Mixed.\nopen*",
      #   "233" = "Mixed.\nsparse"
      # ),
      c(
        "1"  = "1-Needle.\nforest",
        "2"  = "2-Taiga \nneedle.\nforest*",
        "5"  = "5-Broad.\ndecid.\nforest*",
        "6"  = "6-Mixed\nforest*",
        "8"  = "8-Shrub.",
        "10" = "10-Grass.*",
        "11" = "Shrubland-\nlichen-moss",
        "12" = "Sub-polar/polar\ngrassland-\nlichen-moss",
        "13" = "Sub-polar/polar\nbarren-\nlichen-moss",
        "14" = "14-Wet.",
        "15" = "Cropland",
        "16" = "16-Barren\nlands*",
        "17" = "17-Urban*",
        "18" = "18-Water",
        "19" = "Snow and\nice"
      ),
      c(
        "1"  = "1-Ever.\nforest",
        "2"  = "2-Decid.\nforest*",
        "3"  = "3-Mixed\nforest*",
        "4"  = "4-Wood.",
        "5"  = "5-Low\nshrub*",
        "6"  = "6-Tall\nshrub",
        "7"  = "7-Open\nshrubs*",
        "8"  = "8-Herb.*",
        "9"  = "Tussock\ntundra",
        "10" = "10-Sparse.\nvegetated",
        "11" = "11-Fen",
        "12" = "12-Bog*",
        "13" = "Shallows/\nLittoral",
        "14" = "14-Barren*",
        "15" = "15-Water"
      ),
      c(
        "20"  = "20-Water",
        "31"  = "31-Snow/Ice*",
        "32"  = "Rock/\nRubble",
        "33"  = "33-Exp.\nbarren\nland*",
        "40"  = "40-Bryoids*",
        "50"  = "50-Shrubs",
        "80"  = "80-Wet.",
        "81"  = "81-Wet.-\ntreed*",
        "100" = "Herbs",
        "210" = "210-Conif.",
        "220" = "220-Broad.*",
        "230" = "230-Mixed.*"
      )
    ),
    
    # ------------------------------------------------------------
    # Seed
    # ------------------------------------------------------------
    seed = 81
  )
)

# ------------------------------------------------------------
# SETUP PROJECT
# ------------------------------------------------------------

out <- setupProject(
  name = "gvaMapping",
  
  paths = list(
    projectPath = file.path(projLocation, "gvaMapping"),
    modulePath  = file.path(projLocation)
  ),
  
  modules = "gvaMapping",
  
  times = list(start = 1, end = 1),
  params = params,
  Restart = TRUE,
  useGit = FALSE
)


# ------------------------------------------------------------
# RUN SIMULATION
# ------------------------------------------------------------
SpaDES.core::simInitAndSpades2(out)






inputs <- list(
  
  # ------------------------------------------------------------
  # PLOT DATASETS
  # ------------------------------------------------------------
  # Named list of formatted plot datasets (data frames).
  #
  # Each element must correspond to one dataset and must be named
  # consistently with the sampling_size_m2 parameter.
  #
  # Example:
  #   names(dataset_list) should match:
  #   names(sampling_size_m2)
  #
  # Each dataset must contain at least:
  # - plot coordinates (latitude, longitude)
  # - plot identifiers (e.g., plotID, quadID if applicable)
  # - vegetation measurements (e.g., biomass_dens_quad or percent cover)
  #
  
  dataset_list = list(
    
    # --------------------------
    # COVER DATASETS
    # --------------------------
    dataset1 = list(
      A = file.path(projLocation, "gvaMapping", "data", "plot_datasets", "cover_datasets",
                    "cover_dataset1 - Baltzer et al",
                    "Chronosequence quadrat covers_2016_2017_2018_2019-02-11.v2.csv"),
      B = file.path(projLocation, "gvaMapping", "data", "plot_datasets", "cover_datasets",
                    "cover_dataset1 - Baltzer et al",
                    "All site info 2019-10-16.csv")
    ),
    
    dataset2 = list(
      A = file.path(projLocation, "gvaMapping", "data", "plot_datasets", "cover_datasets",
                    "cover_dataset2 - Errington et al",
                    "lichen dataset for Andres.xlsx"),
      B = file.path(projLocation,"gvaMapping", "data", "plot_datasets", "cover_datasets",
                    "cover_dataset2 - Errington et al",
                    "lichen dataset for Andres.xlsx")
    ),
    
    dataset3 = list(
      A = file.path(projLocation, "gvaMapping", "data", "plot_datasets", "cover_datasets",
                    "cover_dataset3 - NFI",
                    "all_gp_ecp_species.csv"),
      B = file.path(projLocation,"gvaMapping", "data", "plot_datasets", "cover_datasets",
                    "cover_dataset3 - NFI",
                    "all_gp_site_info_approx_loc.csv")
    ),
    
    # --------------------------
    # BIOMASS DATASETS
    # --------------------------
    dataset4 = list(
      A = file.path(projLocation, "gvaMapping", "data", "plot_datasets", "biomass_datasets",
                    "biomass_dataset1 - Cook et al",
                    "ForageBiomass_NWT_20162019.xlsx"),
      B = file.path(projLocation, "gvaMapping", "data", "plot_datasets", "biomass_datasets",
                    "biomass_dataset1 - Cook et al",
                    "PenCharacteristics_NWTCaribou_Location fixes added_red__FM_for Genev_Mar 2022.xlsx")
    ),
    
    dataset5 = list(
      A = file.path(projLocation, "gvaMapping", "data", "plot_datasets", "biomass_datasets",
                    "biomass_dataset2 - LGL",
                    "EA3922 Lichen Plot Data_ALL YEARS_SUMMARY BIOMASS three ways.xlsx"),
      B = NULL
    )
    
  ),
  
  
  # ------------------------------------------------------------
  # STUDY AREA
  # ------------------------------------------------------------
  # Path to the study area polygon shapefile.
  #
  # Used to:
  # - filter plot datasets spatially
  # - crop land-cover rasters
  # - define the spatial extent of the analysis
  #
  
# https://www.maps.geomatics.gov.nt.ca/Geocortex/Essentials/REST/TempFiles/Export.zip?guid=f3f773d8-443f-4715-9144-b2f2ed465eb1&contentType=application%2Fzip  
# select features (southern NWT and Weeheezhi) and merge them

 study_area_path = file.path(
    projLocation, "gvaMapping", "data", "study_area", "southernNWT_Wekeezhii.shp"
  ),
  
  # ------------------------------------------------------------
  # LAND COVER PRODUCTS
  # ------------------------------------------------------------
  # List of file paths to categorical land-cover rasters (GeoTIFF).
  #
  # Each element corresponds to one land-cover product.
  # The order must match:
  # - list_of_land_cover_names
  # - water_classes_list
  # - inapplicable_classes_list
  # - abbrev_list
  #
  # These rasters are used to:
  # - extract land-cover classes at plot locations
  # - generate wall-to-wall GVA maps
  #

#LCC 10
#https://datacube-prod-data-public.s3.ca-central-1.amazonaws.com/store/land/landcover/landcover-2010-classification.tif

#ABoVE
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh10v10.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh10v10.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh12v09.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh12v09.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh11v08.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh11v08.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh13v08.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh13v08.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh13v11.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh13v11.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh09v11.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh09v11.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh11v10.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh11v10.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh10v09.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh10v09.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh14v09.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh14v09.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh13v10.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh13v10.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh14v11.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh14v11.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh11v12.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh11v12.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh14v10.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh14v10.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh12v11.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh12v11.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh12v12.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh12v12.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh12v08.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh12v08.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh13v09.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh13v09.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh10v12.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh10v12.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh12v10.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh12v10.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh11v11.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh11v11.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh10v11.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh10v11.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh11v09.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh11v09.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh13v12.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh13v12.tif.sha256
# https://data.ornldaac.earthdata.nasa.gov/protected/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh13v13.tif
# https://data.ornldaac.earthdata.nasa.gov/public/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh13v13.tif.sha256


## FREE LINK
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh10v10.tif?A-userid=andres.acg&Expires=1778216987&Signature=ByyVzx3-9yDaBM7gmY4zWcslphykUK7ESXWrdVTTMAfCogRM8Xr72YU1Tg5OX3B4eBTtZCi0ymLEFp8nfXEve7B8Pri~3mnRRRcv29npGcfkgnQNRcYM7m~Lhh9~ruKhsmZcItyJhaFfXWy8JpOmXMKGFroCBqDEadXOvPVWhtfdAWEqtaqUVtRRdagtvo5lVG2HaDgA2jUjmtRP3j49kq8hNHPa2XCuXyv6VkQYKogOybMHc-G5mLL--R1PCamI4yq~dydV--QcBBCnECuGZFPCx9USvZbEB-kK9KvMBbF2CI0jw76Wy0JC8meq4Fdg7j7IQhROdB3wTTwqzfD2Gg__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh12v09.tif?A-userid=andres.acg&Expires=1778217399&Signature=Pu3mSD43Je21w1VudjDWApLRTAqX7eFTuUzKRDf3U1~H5kqR3V84PzIZ5pHZf7oBM3jE78drEjARvDuzszwtpgigQ1dqZao6aemeBl3QMLRXNl-WDSQbLezVPTsxw~HbQQdHF0HoGT6QAPJgg3iMjDlbdSb44F5mlJV6Vk8QUMkLm~hzYussVTCgWeWsuNSclvPKPmwH5VzkXa5~Hnqgpw0y1vyezC9ehHs3wR4xz3VH2J2voUcxTzcapP6MP0C05ZetvosLCi5qQp1M1Smz6Ol-c5A7JL~5zoX3AAoiyq~Xrk~snQydXA7AECRSc-lK1OeRUHw35zi9sqxykMgNsA__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh11v08.tif?A-userid=andres.acg&Expires=1778217792&Signature=ldcqj~j~vpyvSL8H21Us9N94N3dLHCvd4ZLDAzVxhpgwgLn2aS~PHMJm8u5Rn~REyQa4v03O66sqq2LNKiCtEH4NqsHif7X4-Z2SlUT9GYotAW13Wmo8ShmZ~zCcan7k5RN-zZqG1AMeDO9DDOU8P3XAj8I7DXtO4yzZh4rsFhxgQNKfvaXfkihrs16fYpBJObe7WYaSoY-BI9qZNWn5fZVFMASwB2PSrmq0OUC7FeqaAf2b5XrzYv0z8-TavateIEyJ~lVS-ZyjWQqbzp~qVKaRVKwVehp8a58H3vmBVK3WoAv8~shW-FY9Ht5xuiwSLfSkKac9ww5mlEatrIZf~A__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh13v08.tif?A-userid=andres.acg&Expires=1778217841&Signature=IVqwieostI3qL7pmOXgZZpdgMvG0PRFdZ8EMxawtnzCaq39jYiOsOkeVYo~k0-mU5c9IDVTtTCGdVDpq5FFx1YIt4K004O1MrADIe1U8G~XQwbaA2J-je6CT0bg5OqtSYz8t3uJl6hDWosUtLuh4IcylSlVGVDAb1DSYfI4I4KQSubMs15Nk0fTtBH3ijG-Ra3~X~75vtkmQCzcm0ATtw2~mLyl~UabOZJetWks0Sv7veQHWHEuOz1P5Qswba4fVJ-bltvsc9J98RLT5rjLNOYZzzf~aw7NUDIfklV1SfxfxlWCrw0BvVHVffn7P85njAwWoVS8c2mXWAcoAloSsEg__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh13v11.tif?A-userid=andres.acg&Expires=1778217982&Signature=lTgPiHGFi7~7J6za8OyJ~qrAz7loA0qiyH~1uxD5tud8WoC7d4i3f7~eL4kmjVx6VI4ZIvz-H1fkg5k9rtwmNtToDG4cD~xb1YdKAA3GPdgxDNLNWlHjybt8BiJaUR7a56rnAGtoJKCuNHjQ4iNmfypXVgjiDD2TFM8-hd1cWS8j5LUTqBxF1yTqAwbm1to~XLs75PXTgkF9KeeARo3iTxQcRZ8TKw836LuZwd64wXGehGDHkMS9cAAlEivkm2tvFFWUGRN2zyszJ7QDseunCrMZSTmRAaYN8pOFHJFUpdB3Ri58RPWNLy-1QlKR1vOtG0-w-DygOa--Mbq1z8ggHA__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh09v11.tif?A-userid=andres.acg&Expires=1778218099&Signature=BAerp4btk2V-ZO7DaYSZWbsOYXIabgFoc2uFFR0j5EoRdi8YMjMtVCzC-6tXOlkxzIWhUNtK~5~PmaZv0GKZbhbnj5SInh3hnKTM0pkAzFclTMbzeCLB3XKAdH7iSpY-yuXESBjOrNQ~3Tn0YgDu4Tf2loZE3hZeWJ0TUjh8YlO~wFCPh-xuSuwdPAFuGep1fPoVNVCg-BRk~-KnUk98g2lkyK8Ci3fKb5Q4UoPTfDV9iniNT2Hs-O~brjspUEPJ0Ot5Z7VEpTEtV0qAU1ChKR6oJwjF9-rpr3ViNsi3CGyA1CRBw4Q72~6bs4wa8u8nLpnDrvYTfMzEYYORiKlULw__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh11v10.tif?A-userid=andres.acg&Expires=1778218225&Signature=nrZa6CW8kLnjLJtHEW0gNaplNhr~wCo8Oymsc~yD5Y6~SjIjOtDUL22xMx0KM2NqT7fgFal2nhZhgmRqbDLazqm6PF~bUoNCxVXcDfJDhWdjc39t1YR-mhCS8He6i2MxAjIVVMlfMoqD50KWvUlpwfK0fYhIkgYeYqreva-XoSB197UmVtAka9SioVDphqHT197XamVgtK0g4A~NY5dZLjwAIw00EApVFTScnVKMmPkJ9q8dKhww2ACkgmy~nLCd5rcVqsKfFqiKs-XcesJcl1XBo-X~TBK7rbYMMl2NO-GiCQetHPGiNgn0sNwKOfcwPTloeeTsMexmZRRjmYIClQ__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh10v09.tif?A-userid=andres.acg&Expires=1778218332&Signature=USXrmmXwpDMkz97lBcmyAao6fjKeoHpkf67Qat3bbDZVfQNDZrRSg-nvcWM2paS3KxrulBCIOI9GYlhEsr9~PZulAO7Wxe8NYP26JA70tFfUW3o8Wuw9OQ~tzBw6qk~fH9BidRrO3tVXtHTwKgnqxCUpZkRrSuCD6rCv5AzqhSH2lSF2BM620QoIAafwAkjG~hRKdEPXNTq-vFx6aSOC8R7Cl9n8W19kIFjlaAgj4SgacC4eIQYDcctBzM26w760k2StdYlZDOhz1qyaCIqXj8wH9PSwGgCnlzhpQDWOKa5wWLd2TUcyZDAtkQuidpwaRow-n54ygGcvvY9sJs4qAw__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh14v09.tif?A-userid=andres.acg&Expires=1778218406&Signature=gTVGYIxaaaznoRDLvtTvpGTqCQBg2OaOzlBgA7WBJYm7HdBCYlpPf2MueBfcuVoXmcJaYgOKGAIV5KacrEn1XpIV7PsKsigcdIyMt65XeNigtjnST3B7xGd5ItYu34eeczzOLrze2rjjILFYhc0UqHI-ZAABIfBAs-d1Pu9p3YOD4rF8gL6U1SBzqJijyv2lJMkcbRN1e9I9PmJGki3lMsocw~IVoUiRlzx9U5NNyxgNG8eHIClLM6QCxSh~QuZzGS2LSWg1Rw-qoKIeAitWLWPleLo1an6L3yOucLFGxHM3lRbyc17ufw8vTw8orMNvM7WA3RttaalzBYSKIzNQMg__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh13v10.tif?A-userid=andres.acg&Expires=1778218451&Signature=p2jstAvRb9IgDoBpWt75sHzzCLE-RmC6pek-6eY895lL8NlCJiVAnZdwRnqDCjkJaGrppgmqqWJRuZL-OlxqMp95oqaJ4pAP1PchshS68Zt7KtIwTpXCM2ixg0dd~PZ4FRTfp7P85~a395k7KpDppyb-HJZdtkQyrXJ9IqzEKXoaBHhjraKvbXhbGiMM4xqsqbI4yfxrDKh5ne32g1ZMen8v-5iQA4vo5DbuCw7jm7pCxEd41RvNglQinttKciWQn06jViMwBo65ZSeKteIR4XLBHYC5zi~cyGzrRxND4~UXN~7wnB0iT2H9jrN18sqzSYMhHVpSq5oCp1Qpwtta3w__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh14v11.tif?A-userid=andres.acg&Expires=1778218587&Signature=O~tZFYMqRXXH4keiKCmcscqVRrK--89EOwZckvxfRPtF6JOT67A~G~jDkzqtDJK~M7H1NTh0V8P3J8r~rc5mjOgtpdZ8qyIi0-U9gvKzOrrVLl5Rj6R3NydqacHv179eoU2DsKbmlWILU1icmM3ShzhrfRLMKnxVIHkPZFMsl0nKHoirUrGgjasXE2IvpZDkqxRui9A1ywSgGOvOmpSGDfB~qWrdvBtClEzu32xwhbnWaeFIX49P9lxXATTpvVXhMSa07QT-47BVj2lU-PqHWrtN7QzVPmUKQJphJGJb0I4wAQatnXFoXw2iYnLAXPv16PSlmLjx7rJCCxLi5q7TJw__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh11v12.tif?A-userid=andres.acg&Expires=1778218681&Signature=OUPRoivpnsG9Hb3lR1CRRGd3hnQzGLxkA9PPxiK6fP~G79nlXaMT3ewCf9JoVyL4DtRC~V82~HeFVP~GfHtagmdlinkaFq8-Fjc5uyrM0RI46rb-TrHjxcOAdqfUnc5SQCj95UMSgvnXfUI7IfmmumbkCf1Abx3bQ2aW45XP2l847LZv9TPwLdh8WKjiCXciZfINKIZaz8RcrwypdhHXLA3lqQuC1gaKYW484dI05kj5A0r2PKJrTFFuV2nOICqt1I04y~MZOtmhBaC3eHcHyy1pQStPMUvk8FLVwzcCkFzba0o~VJ33TWHjnPUoZGSPTSKsr1Ud61rBACkabC~jkA__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh14v10.tif?A-userid=andres.acg&Expires=1778218776&Signature=Djz8PDmZtJZv1ifUET8rUk8-7bG1OHQzJSOrTcEBeWZmRF6wmDQInJ1pOeqarg4zk4pKP6u5BE1H~Vb2bSzPquvWJTF-F4RCgiwiX27JNGKyFmINNh0TBAZ1HxSJa9vjATMvVOiZhJ0UA1y3halVCHpMn92onR2jJuX-UPTIaYaXZbztf00Udj357c1ynF5FKvgkmQVrt2NkkhRqnXBC-YVWh1i1HJRRUfu2tk-Ve09M1t2z1QUn00ZhjJd-1QSHF5IFykxNXAMCIyWYimydTQutfNTMpBar-k6ax31FaoqT5RV02KnvYKFVfLuiaPNketdIrZHAhyc0nlNHDp6Uvw__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh12v11.tif?A-userid=andres.acg&Expires=1778218847&Signature=IQt1QQ2EUxmnGbFZLnwiGWmZsBv~sYOEnj0N4KnP35QPb6hTjj5QxE7IVpj-E0FgyHL3DrIIbQ90vO2j2AQP8Afixt286FXNJwyX5yOl2cQepYfJidtwS-K6CGym0yipNssmxl9I5O2HP3LowZOeXofre1d1entTCAWM1zsQV6HmitjklCRIbK88JP8svrmCT~Z~bO0d0HXEA24i62VD2G~PiKn70aqSOU3ji-ENDltyaiLhdDiMWmQ41CS7eImfl2dWhijb4C0JAssTfLuACPMlbVSfpEfUq5VsgwL9WRFyt9LeLsxGqSKwvrp29vDvG0aaKTx~Al~VFUrd9se~vA__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh12v12.tif?A-userid=andres.acg&Expires=1778218890&Signature=LhDrNSD~NynKxQBwbc-9J3Scvy8m9D1Zqyvfcdt6exaoI6DGzl4tIVg-5xTNzVwlaY-fBsabpOcQ8QO-EL63UvqXo7x8olMeR6SSFd3xDCiS5Ywv~9e7DMNclEckf6dvaaxoycp8g3s-TT26jMM9KPucEupPwErqe0~4KWRmZqtxSPr66v1cQXGH80HZkMU28H-vFsOUSuWhUTdjRh-A-XibvlrIewQ3UgDEOzu~BT8cg7EOadG2CEW7Ir2RiZY5nOr4xlWvyk2TCffvk-8nUZn9Plr-NnK1OUg6CmqSOp~C68M~48PSTk0c7u4cmn2y5f3BQCSnMhtVivS-aIApnQ__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh12v08.tif?A-userid=andres.acg&Expires=1778218922&Signature=WGr0WWdPxLWOQGA78FlqGkmsA1ABpT8c8JphbsSL7mcesCtawiBJW12phNC7IcDIQDojXZmEl2h23J5CyW86QS6biMIXCKd80DbdZCHlwkd76er8~FVfFMRjawEoxCN1QNOe0K5FYjucUEYVIJroT2l1h8RLOT0ce6OorSyiC1ZdgCIhmlu0eJS1WMr3m4RQ~nSmX0d~o-Nkgli~InKx99DuKcxRZ3wC~pXwRLEHePoVKhy88PAFFxjeqPB~GapJeeURs0L1fNR2cGYWYnNjAU3tf1BS4PWqWJcTRuH7jNBvofk4Mp~47ag5WR9SNj~tF3ASvetYvFRFexakLruAng__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh13v09.tif?A-userid=andres.acg&Expires=1778218964&Signature=eJxEuHmwOBWencUHNn2WqdcgSnWnjhOeodRM0eRxOzKhMpy2fwCkbqTsKN-SIYp4aGSzkFOppqRpuzC694IFmURScRE1jIduLDoksHdT6GrgG2dO706Lz7UHEamuYjzJu4fFtJwIVad4NZ3nxOGvi586F30WWZJ43Wq9vwVQ9NcD37xAClP1lv4jMyuMMmxu~eQYnNPIPhYnAknKLUBZKgXgOS1lYw4iEV9cPh0Yfm2f0r9ZIQtPBfaWO3l9~220KAsXiw9qn7Kk6fj7XZN-wZKmOOd1LSJUNhg-a3Bw96Aa7eeqloEUXE81W8D8BBay~QR~WjygOdCJfkP1~X-QVg__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh10v12.tif?A-userid=andres.acg&Expires=1778219004&Signature=P-~ZVvbSOJvTthUVBZUIFD871eF2RLr8mMh0FHd--zT1lWs2nhulBRAWVEK3JfgM4Nq3GAp18fN3OvRRyLsgkp7ySKo61C193mMkSpuE9pP-GiqsoHlphRPwuqg~5oJsQK9QWA6hv-7uG~1639tyNrAikVjXfJYtDPrVHJxeAqP8vPPt7D4ofheMocCQ3eHiarWvPSWWB~UmzzYQz5e2tSK3pldm8IeBQrKcdbR9C4vZ~F6rBk6GvJLQ~gYEgTUlmJPHYOG32B8m7XdjShj6d5VIr032Jd82VSvYF6dYf7bS-ZvkT5Hm0JTfqvA2neO9KwVdiRl2kAiptxvZSn3Fdw__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh12v10.tif?A-userid=andres.acg&Expires=1778216213&Signature=A8DxylrMQZpzrweTH0Hfsk74s-MrMGH3MFjObQesYZ2NTX-wzwNKhAE6wlDB7IsZYiFFhMeuWgU6IMUknBfZSrF3a9tCDDBqy5hLf8QFDy199pFiIAXg6aC8BRaPgX7-4WIr~xzbNTqsWrzPSiomAABquSlMG7~-KQXJJaUaX0ZOkUh5bOU-VXhiWTGfMXABUzS-cTj2xgsGJotBlo1fGKq65nAE7vxNC6XkuVzGDFBg0LH3yNbBuzxgMnL0Nv31cFlnmYQK0NP50KWNBFbP6Oip9UP6XELQESE9sVvzpcnhaIWwQeJDXZ~lkkrKZdKlnjvraRNGtyjI1Lzgr2h7lA__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh11v11.tif?A-userid=andres.acg&Expires=1778219092&Signature=YgEvjZfeMwhXKgyw1o05zDENdt~lc-ViqBwJs8hHEeqcsC6AMz-VhU2nqjX92ddabIL~iCwgupK4X4~uzHefj7MSTxeNFjX1399BMUln0bed4e1giq9SO1F1JimlDrhQJ9N1YGRfToStfbwxk2zdFY8lG3qH9BeUUQRPxOfumKewXHYWdJYTBbNrkwMn42PEyrokvOntp0ZviiD~Y~IHGW4Xv3QDnhTpY-z9RzZREMw2dEBR0yJ2bSwEGlI05Q1CtSllBq~xSOD2ckWrRfhOiORwO-sTbFgopFYbfXwwZf-mnHGJuKTizZk7D2jd1wjU3q0KUc~O2Ts18qyHAYdOeA__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh10v11.tif?A-userid=andres.acg&Expires=1778219116&Signature=cxFWt~8EOdufwKzJdyczsXtrXW1jykJ0hz9-zdMcriUPSiJDSWrAHQtqT8skwSd8bbXDcLy0n59JsC-WWM6Nf-FMYbmzQB4SlTqxorB2ws95PfMxkSDw8eHoUlntWrLVwTnK3OPpGh9tzvi74QbkG0YaJ4Jwo67OHkmjT7CcXBsF5cYAtnArmOvbToSSp8w9pVhKVg4NdkFtfxJezH~9iX~ZJXy6gQf38VjECexMsKma08DScGPg0GoP96pG1huCEqL4tQ0CNsQTEt~Klwy2FK1qR419W591cg0lpCYrsLoyDsNiYwugQV6BFuLSCwZB6tMKL~sCp-Y1vuv~WAghcg__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh11v09.tif?A-userid=andres.acg&Expires=1778219137&Signature=lFe3qsQpaRtKEblecjkWwuq4QTnLUHYqF5QhyYg2AsU7VLyC58TFpyrNYjx070FYbrawyGViqV4J50Dcocy~oRtoh~CtNlXA7ERD~YYgU~m3CUdtmpQPyYArJ2Cto2WMP-d~PLtcPLCjra41eP9sUOWMR52kOuwJ8kDpFZ7hRuoGu6iZ-frO5xxiTXQDDK-9eJjgd1HHdMt-S9NWvV5u7DWnTtwprdAsIqVoZbWuICXLOjjy30kXzUrSgfd5MJNaXBKUC0jBrDPLxiod1QvaU3c0oAU5noaAfRXXy0eNKZMKzHH5FpT9u1BcR6M02uWryX1rdRfCkEJFwUQ4PL1HTw__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh13v12.tif?A-userid=andres.acg&Expires=1778219163&Signature=pffBGCOBDgFiHazz~iD3mTWwBgkhYgNbLbunqn4tsAwQ4hXIpuXQosnkSZ4j5PmLkeBp7AFs0dFtwFhLOzF6C7wvA7DAkIzUQop2JLgNMIAGKM2ui6~sn~-naa8l9CoEpKTLp5x6kVZiOxVTNoboAK3I9wpfSdrkW4xTnOl8bpJqBhEkwxMrNtCsIRhuqpDdMSLqjU2V~s3V5LhRC7RD9KbYDWijgXKDgdO3RqmA4fDww5efr2F1Au3JPmhqlsBmi96JHNwMKTgfhj-gz-lDzHd-Zp4K3xtFpTXUvBWTxwR40S86okWQKIsv6Bonj8VW197p1HsmDRmZr7zqhI55tA__&Key-Pair-Id=K2GHMOM2YD9MI1
#https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh13v13.tif?A-userid=andres.acg&Expires=1778219191&Signature=I0YKISBY9g9YaRYBhm6BMCn2boes38VZhvXNaL2d05TgjDVB0OQlwBltYnY6PFXn0h6rWHUwuklQ~74d~Zg-LXwLAntW3dtNQbo7iK7q6FKItWyBVyDv8PSnkAI~LG9FzcSQl9DRbL0pyaGh5ThBZhZhCCMd43mP2Ls5UthV4cWMyWfIJBrDxe5EYi70LF0DckLBA1VYvbQbGxWHmtjVkUxYrGCzYFo9JEvtIqCf~aueVoLkSNaSlMEPEjqet9Gl75NH1aJyN03A0GXecHJU-shicZtKMdUGW4KkTJ9j2-GeoG02zRNFbQUZYd3o1xvICsa50IqxRm5nyB4vx9w-Mg__&Key-Pair-Id=K2GHMOM2YD9MI1

linkABoVE <- "https://d3o6w55j8uz1ro.cloudfront.net/s3-d0f68fa49c8cba12794bb586349f2341/ornl-cumulus-prod-protected.s3.us-west-2.amazonaws.com/above/Annual_Landcover_ABoVE/data/ABoVE_LandCover_Bh13v13.tif?A-userid=andres.acg&Expires=1778219191&Signature=I0YKISBY9g9YaRYBhm6BMCn2boes38VZhvXNaL2d05TgjDVB0OQlwBltYnY6PFXn0h6rWHUwuklQ~74d~Zg-LXwLAntW3dtNQbo7iK7q6FKItWyBVyDv8PSnkAI~LG9FzcSQl9DRbL0pyaGh5ThBZhZhCCMd43mP2Ls5UthV4cWMyWfIJBrDxe5EYi70LF0DckLBA1VYvbQbGxWHmtjVkUxYrGCzYFo9JEvtIqCf~aueVoLkSNaSlMEPEjqet9Gl75NH1aJyN03A0GXecHJU-shicZtKMdUGW4KkTJ9j2-GeoG02zRNFbQUZYd3o1xvICsa50IqxRm5nyB4vx9w-Mg__&Key-Pair-Id=K2GHMOM2YD9MI1"

raster <- prepInputs(
  targetFile = "above.tiff",     # simple name (important)
  url = linkABoVE,
  fun = terra::rast
)$above.tiff





#NTEMS
# https://opendata.nfis.org/downloads/forest_change/CA_forest_VLCE2_2010.zip

  land_cover_paths = list(
   # file.path(projLocation, "gvaMapping", "data", "land_cover_products",
   #           "southernNWT_Wekeezhii_mvi.tif"),
    file.path(projLocation, "gvaMapping", "data", "land_cover_products",
              "southernNWT_Wekeezhii_lcc10.tif"),
    file.path(projLocation, "gvaMapping", "data", "land_cover_products",
              "southernNWT_Wekeezhii_ABoVE.tif"),
    file.path(projLocation, "gvaMapping", "data", "land_cover_products",
              "southernNWT_Wekeezhii_ntems.tif")
  ),
  
  
  # ------------------------------------------------------------
  # DISTURBANCE DATA (OPTIONAL)
  # ------------------------------------------------------------
  # Path to a disturbance shapefile (e.g., fire polygons).
  #
  # If provided:
  # - plots overlapping disturbances after the reference year
  #   (defined in land_cover_year) are excluded
  #
  # If the file does not exist:
  # - disturbance filtering is skipped automatically
  #
  
  disturbances_path = file.path(
    projLocation, "gvaMapping", "data", "disturbances_(optional)",
    "NFDB_poly_20210707.shp"
  )
  
)


# ------------------------------------------------------------
# SETUP PROJECT
# ------------------------------------------------------------

out <- setupProject(
  name = "gvaMapping",
  
  paths = list(
    projectPath = file.path(projLocation, "gvaMapping"),
    modulePath  = file.path(projLocation)   # ✅ THIS IS THE KEY LINE
  ),
  
  modules = "gvaMapping",
  
  times = list(start = 1, end = 1),
  params = params,
  objects = inputs,
  Restart = TRUE,
  useGit = FALSE
)


# ------------------------------------------------------------
# RUN SIMULATION
# ------------------------------------------------------------
SpaDES.core::simInitAndSpades2(out)

