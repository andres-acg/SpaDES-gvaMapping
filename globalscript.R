## Instructions (assuming you are using RStudio):
## 1. Copy this script to an R script and save it anywhere.
##    It doesn't matter where it is saved or the name, but I suggest `global.R` for the name.
## 2. Run the script. It may take a while to install all packages the first time
##    and RStudio will automatically restart and open the new project. The R script will be copied into the
##    the project folder and all packages will be installed into a project-specific library.
## 3. Re-run the script after the automatic restart. The original R script can now be deleted (from Step 1).
## 4. For future runs, use the project/global.R, and to avoid the automatic restart,
##    make sure the RStudio project is open.


# ============================================================
# SETUP ENVIRONMENT
# ============================================================

options(repos = c(getOption("repos"), PE = "https://predictiveecology.r-universe.dev/"))

if (!require("pak")) install.packages("pak")
pak::pak(c("PredictiveEcology/Require@usePak",
           "PredictiveEcology/SpaDES.project@development"),
         lib = .libPaths(), ask = FALSE)

Require::Require("SpaDES.project", install = FALSE)


# ------------------------------------------------------------
# PROJECT LOCATION
# ------------------------------------------------------------

## please choose where you want the project directory to be placed in your machine.
projLocation <- "C:/Users/ANCAG6/Documents"


# ============================================================
# TEMP PROJECT INITIALIZATION
# ============================================================

setupProject(
  name = "SpaDES-gvaMapping",
  paths = list(projectPath = file.path(projLocation, "SpaDES-gvaMapping")),
  modules = "andres-acg/gvaMapping",
  times = list(start = 1, end = 1),
  Restart = TRUE,
  useGit = FALSE
)

# ============================================================
# PREPROCESSING
# ============================================================

preprocess <- TRUE # if you don't need to preprocess datasets, put FALSE

if (preprocess) {
  source(file.path(getOption("spades.modulePath"), "gvaMapping", "R", "preprocessing.R"))
}


# ------------------------------------------------------------
# INPUTS
# ------------------------------------------------------------

inputs <- list(
  
  # ------------------------------------------------------------
  # PLOT DATASETS
  # ------------------------------------------------------------
  
  dataset_list = list(
    
    dataset1 = file.path(getOption("spades.inputPath"), "datasets" ,"dataset1", "dataset1_formatted.csv")  # "...path or url..."
    #dataset2 =  # "...path or url..."
    
  ),
  
  # ------------------------------------------------------------
  # STUDY AREA
  # ------------------------------------------------------------
  
  #study_area_path = "https://www.maps.geomatics.gov.nt.ca/Geocortex/Essentials/REST/TempFiles/Export.zip?guid=f3f773d8-443f-4715-9144-b2f2ed465eb1&contentType=application%2Fzip",
  study_area_path = "https://zenodo.org/records/20492584/files/Wekeezhii_SouthernNWT_boreal_caribou_planning_range_regions.zip?download=1" ,
  
  # ------------------------------------------------------------
  # LAND COVER PRODUCTS
  # ------------------------------------------------------------
  
  land_cover_paths = list(
    
    land_cover1 = "https://datacube-prod-data-public.s3.ca-central-1.amazonaws.com/store/land/landcover/landcover-2010-classification.tif",
    land_cover2 = "https://opendata.nfis.org/downloads/forest_change/CA_forest_VLCE2_2010.zip"
  ),
  
  # ------------------------------------------------------------
  # DISTURBANCE DATA (OPTIONAL)
  # ------------------------------------------------------------
  #disturbances_path = "https://cwfis.cfs.nrcan.gc.ca/downloads/nfdb/fire_poly/current_version/NFDB_poly.zip" #if no disturbance, put NA
  disturbances_path = "https://cwfis.cfs.nrcan.gc.ca/downloads/nfdb/fire_poly/current_version/NFDB_poly_large_fires.zip"
)



# ------------------------------------------------------------
# PARAMETERS
# ------------------------------------------------------------
params <- list(
  gvaMapping = list(
    
    # ------------------------------------------------------------
    # Measurement
    # ------------------------------------------------------------
    measure_class = "intensive", #must be intensive or extensive
    measure_name  = "Biomass",
    unit          = "kg ha⁻¹",
    
    # ------------------------------------------------------------
    # Sampling sizes
    # ------------------------------------------------------------
    sampling_size_m2 = c(
      
      dataset1 = 0.25
      
    ),
    
    # ------------------------------------------------------------
    # Target GVA (same as before)
    # ------------------------------------------------------------
    target_gva = c(
      "mitis", "Cladmit", "MIT", "CLMI","arbuscula", "Cladarb", "ARB",
      "rangiferina", "Cladran", "RAN", "CLRA", "stygia", "Cladsty", "STY",
      "stellaris", "Cladste", "STE", "CLST", "uncialis", "Cladunc", "unc", 
      "CLADUNC", "amaurocrea", "Cladama", "AMA", "spp."
    ),
    
    # ------------------------------------------------------------
    # Land cover products (REPLACES name_land_cover1..4)
    # ------------------------------------------------------------
    list_of_land_cover_names = c(
      
      land_cover1 = "LCC10", 
      land_cover2 = "NTEMS"    
    ),
    
    land_cover_year = 2010,
    
    # ------------------------------------------------------------
    # Inapplicable classes
    # ------------------------------------------------------------
    inapplicable_classes_list = list(
      
      land_cover1 = c(17, 18),
      land_cover2 = c(20, 31)
    ),
    
    # ------------------------------------------------------------
    # Water classes
    # ------------------------------------------------------------
    water_classes_list = list(
      
      land_cover1 = 18,
      land_cover2 = 20
    ),
    
    # ------------------------------------------------------------
    # Abbreviations (REPLACES abbr_land_coverX)
    # ------------------------------------------------------------
    abbrev_list = list(
      
      land_cover1 = c(
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
      
      land_cover2 = c(
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


# ============================================================
# FINAL PROJECT SETUP
# ============================================================

out <- setupProject(
  name = "SpaDES-gvaMapping",
  paths = list(projectPath = file.path(projLocation, "SpaDES-gvaMapping")),
  modules = "andres-acg/gvaMapping",
  times = list(start = 1, end = 1),
  objects = inputs,
  params = params,
  Restart = TRUE,
  useGit = FALSE
)


# ============================================================
# RUN MODULE
# ============================================================

out2 <- SpaDES.core::simInitAndSpades2(out)

