# ============================================================
# INSTRUTIONS
# ============================================================

## Before running this script:
## * Please use R version 4.5 or higher -- older versions have not been tested
## * Install RTools to enable package installation from 'source' -- go to https://cran.r-project.org/bin/windows/Rtools/ and choose the appropriate version for you R version

## This script works the same way in any R IDE (RStudio, Positron, VS Code's R
## extension, a plain R console, or `Rscript`) -- setupProject()'s Restart =
## TRUE below only takes effect in RStudio or Positron; every other IDE
## silently skips it and keeps running in the current session, so a single
## run does everything.

## In RStudio or Positron:
## 1. Copy this script to an R script and save it anywhere.
##    It doesn't matter where it is saved or the name, but I suggest `global.R` for the name.
## 2. Run the script. It may take a while to install all packages the first time,
##    and the IDE will automatically restart and open the new project. The R script will be copied into
##    the project folder and all packages will be installed into a project-specific library.
## 3. Re-run the script after the automatic restart. The original R script can now be deleted (from Step 1).
## 4. For future runs, use the SpaDES-gvaMapping/global.R, and to avoid the automatic restart,
##    make sure the RStudio/Positron project is open.

## In any other IDE (VS Code, a plain R console, `Rscript`):
## 1. Copy this script to an R script and save it anywhere, then run it (or
##    `Rscript global.R` from a terminal). It may take a while to install all
##    packages the first time.
## 2. That's it -- there's no restart step, so one run does everything. Best
##    run from a fresh R session (a new terminal or a freshly started R
##    console), since there's no automatic restart to fall back on if
##    packages already loaded in an older session conflict with the versions
##    this script installs.
## 3. For future runs, use the copy at SpaDES-gvaMapping/global.R inside
##    projLocation (set below).

# ============================================================
# SETUP ENVIRONMENT
# ============================================================
if (getRversion() < "4.5.0") {
  stop("This script requires R >= 4.5 (older versions have not been tested). ",
       "You are running R ", getRversion(), ". Please install a newer R and retry.")
}

options(repos = c(getOption("repos"), PE = "https://predictiveecology.r-universe.dev/"))
if (!require("pak")) install.packages("pak")
# Installs the specific package versions this script depends on -- see
# globalscript.R for why these come from GitHub development branches.
pak::pak(c("PredictiveEcology/Require@development",
           "PredictiveEcology/reproducible@development",
           "PredictiveEcology/SpaDES.tools@development",
           "PredictiveEcology/SpaDES.project@development"),
         lib = .libPaths(), ask = FALSE)
Require::Require("SpaDES.project", install = FALSE)

# ------------------------------------------------------------
# PROJECT LOCATION
# ------------------------------------------------------------
## please choose where you want the project directory to be placed in your machine.
projLocation <- "~/Projects"

# ============================================================
# PROJECT INITIALIZATION
# ============================================================
out <- setupProject(
  name = "SpaDES-gvaMapping",
  # outputPath is set explicitly -- otherwise setupProject() can inherit a
  # stale, session-only temp-directory value for the `spades.outputPath`
  # option instead of a folder inside the project.
  paths = list(
    projectPath = file.path(projLocation, "SpaDES-gvaMapping"),
    outputPath  = file.path(projLocation, "SpaDES-gvaMapping", "outputs")
  ),
  modules = "andres-acg/gvaMapping",
  times = list(start = 1, end = 1),
  Restart = TRUE,
  useGit = FALSE,
  # INPUTS
  # dataset_list is one self-contained block (not a `sideEffects` block
  # feeding a separate `dataset_list` argument) -- setupProject() evaluates
  # `sideEffects` in its own private scope, so anything it assigns (like
  # dataset1) never becomes visible to another argument. See globalscript.R.
  dataset_list = {
    # Supply raw data (raw_dataset1, raw_dataset2, ... + preprocess <- TRUE,
    # using a loader from preprocessing.R) or already-formatted data
    # (point the final list() below at it + preprocess <- FALSE).
    raw_dataset1 <- paste0("https://zenodo.org/records/20054559/files/EA3922%20Lichen%20",
                           "Plot%20Data_ALL%20YEARS_SUMMARY%20BIOMASS%20three%20ways.xlsx",
                           "?download=1")
    #raw_dataset2 <- "...path or url to your own raw dataset..."

    preprocess <- TRUE
    if (preprocess) {
      source(file.path(paths$modulePath, "gvaMapping", "R", "preprocessing.R"))
      dataset1 <- loadAndPrepRawDataset1(raw_dataset1)
      #dataset2 <- someOtherLoader(raw_dataset2)
    } else {
      dataset1 <- file.path(paths$inputPath, "datasets", "dataset1", "dataset1_formatted.csv")
    }

    list(
      dataset1 = dataset1
      #dataset2 = dataset2
    )
  },
  study_area_path = "https://zenodo.org/records/20492584/files/Wekeezhii_SouthernNWT_boreal_caribou_planning_range_regions.zip?download=1",
  land_cover_paths = list(
    land_cover1 = "https://datacube-prod-data-public.s3.ca-central-1.amazonaws.com/store/land/landcover/landcover-2010-classification.tif",
    land_cover2 = "https://opendata.nfis.org/downloads/forest_change/CA_forest_VLCE2_2010.zip"
  ),
  disturbances_path = "https://cwfis.cfs.nrcan.gc.ca/downloads/nfdb/fire_poly/current_version/NFDB_poly_large_fires.zip",
  # PARAMETERS
  params = list(
    gvaMapping = list(
      # Measurement characteristics
      measure_class = "intensive", #must be intensive or extensive
      measure_name  = "Biomass",
      unit          = "kg ha⁻¹",
      # Sampling size(s)
      sampling_size_m2 = c(
        dataset1 = 0.25
      ),
      # Target GVA
      target_gva = c(
        "mitis", "Cladmit", "MIT", "CLMI","arbuscula", "Cladarb", "ARB",
        "rangiferina", "Cladran", "RAN", "CLRA", "stygia", "Cladsty", "STY",
        "stellaris", "Cladste", "STE", "CLST", "uncialis", "Cladunc", "unc",
        "CLADUNC", "amaurocrea", "Cladama", "AMA", "spp."
      ),
      # Land cover product(s)
      list_of_land_cover_names = c(
        land_cover1 = "LCC10",
        land_cover2 = "NTEMS"
      ),
      # Land cover product(s) reference year
      land_cover_year = 2010,
      # Inapplicable classes (may include water classes)
      inapplicable_classes_list = list(
        land_cover1 = c(17, 18),
        land_cover2 = c(20, 31)
      ),
      # Water classes (for water backgroun on maps)
      water_classes_list = list(
        land_cover1 = 18,
        land_cover2 = 20
      ),
      # Abbreviations for graphs
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
      # Number of folds for k-fold cross-validation (per-product GVA raster
      # CV, and the ensemble map CV when more than one product is supplied)
      n_folds = 10,
      # Seed for reproducibility
      seed = 81
    )
  )
)

# ============================================================
# RUN MODULE
# ============================================================
out2 <- SpaDES.core::simInitAndSpades2(out)

# ============================================================
# INSPECT/PLOT RESULTS
# ============================================================

## TBC
