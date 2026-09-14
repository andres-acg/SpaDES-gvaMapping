# ============================================================
# INSTRUTIONS
# ============================================================

## Before running this script:
## * Please use R version 4.5 or higher -- older versions have not been tested
## * Install RTools to enable package installation from 'source' -- go to https://cran.r-project.org/bin/windows/Rtools/ and choose the appropriate version for you R version

## The instructions that follow assume that RStudio is being used.

## 1. Copy this script to an R script and save it anywhere.
##    It doesn't matter where it is saved or the name, but I suggest `global.R` for the name.
## 2. Run the script. It may take a while to install all packages the first time
##    and RStudio will automatically restart and open the new project. The R script will be copied into the
##    the project folder and all packages will be instalyled into a project-specific library.
## 3. Re-run the script after the automatic restart. The original R script can now be deleted (from Step 1).
## 4. For future runs, use the SpaDES-gvaMapping/global.R, and to avoid the automatic restart,
##    make sure the RStudio project is open.

# ============================================================
# SETUP ENVIRONMENT
# ============================================================
if (getRversion() < "4.5.0") {
  stop("This script requires R >= 4.5 (older versions have not been tested). ",
       "You are running R ", getRversion(), ". Please install a newer R and retry.")
}

options(repos = c(getOption("repos"), PE = "https://predictiveecology.r-universe.dev/"))
if (!require("pak")) install.packages("pak")
## reproducible@development and SpaDES.tools@development are installed
## explicitly here (not just left to be pulled in transitively) because
## SpaDES.core@development requires both specifically -- see its own
## Remotes: field. Leaving this to transitive resolution is what caused
## "object 'padYears' is not exported by 'namespace:reproducible'" for a
## reviewer whose machine already had an older/CRAN reproducible installed:
## padYears() only exists on reproducible's development branch.
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
  paths = list(projectPath = file.path(projLocation, "SpaDES-gvaMapping")),
  ## Pinned to a specific commit, not a floating branch: neither this repo nor
  ## gvaMapping has any tags/releases, so "main" means "whatever the latest
  ## commit happens to be when you run this" -- not reproducible for a
  ## reviewer running it after further development happens. This SHA is the
  ## commit tested for review; update it deliberately (and re-test) if you
  ## need a newer version of the module, rather than removing the pin.
  modules = "andres-acg/gvaMapping@ebdae7a094e019f3723a39b77ad3c4965b96c62a",
  times = list(start = 1, end = 1),
  Restart = TRUE,
  useGit = FALSE,
  # ------------------------------------------------------------
  # PLOT DATASETS
  # ------------------------------------------------------------
  # No dataset_list is supplied here on purpose. The raw field plot data this
  # project's own analysis draws on (datasets 1-5; see the loaders in
  # gvaMapping/R/preprocessing.R) has mixed accessibility -- some private,
  # some hosted elsewhere with their own access terms -- and none of it is
  # committed to either repo, so this public script cannot point at a
  # preformatted CSV that doesn't exist for a fresh reviewer. Leaving
  # dataset_list unset lets gvaMapping's own Init() step auto-fetch its public
  # default instead: dataset1 (Deninu Kue First Nation et al. 2026, Zenodo
  # doi:10.5281/zenodo.20054559). That keeps this script runnable end-to-end
  # on public data alone. See gvaMapping's README, "Running with no inputs",
  # for details.
  #
  # If you have your own preformatted plot dataset(s), point dataset_list at
  # them here instead, e.g.:
  # dataset_list = list(
  #   dataset1 = "path/or/url/to/your_formatted_dataset1.csv"
  #   #dataset2 = "...local path or url..."
  # ),
  # ------------------------------------------------------------
  # STUDY AREA
  # ------------------------------------------------------------
  study_area_path = "https://zenodo.org/records/20492584/files/Wekeezhii_SouthernNWT_boreal_caribou_planning_range_regions.zip?download=1",
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
  disturbances_path = "https://cwfis.cfs.nrcan.gc.ca/downloads/nfdb/fire_poly/current_version/NFDB_poly_large_fires.zip",
  # ------------------------------------------------------------
  # PARAMETERS
  # ------------------------------------------------------------
  params = list(
    gvaMapping = list(
      
      # ------------------------------------------------------------
      # Measurement characteristics
      # ------------------------------------------------------------
      measure_class = "intensive", #must be intensive or extensive
      measure_name  = "Biomass",
      unit          = "kg ha⁻¹",
      
      # ------------------------------------------------------------
      # Sampling size(s)
      # ------------------------------------------------------------
      sampling_size_m2 = c(
        
        dataset1 = 0.25
      ),
      
      # ------------------------------------------------------------
      # Target GVA
      # ------------------------------------------------------------
      target_gva = c(
        "mitis", "Cladmit", "MIT", "CLMI","arbuscula", "Cladarb", "ARB",
        "rangiferina", "Cladran", "RAN", "CLRA", "stygia", "Cladsty", "STY",
        "stellaris", "Cladste", "STE", "CLST", "uncialis", "Cladunc", "unc",
        "CLADUNC", "amaurocrea", "Cladama", "AMA", "spp."
      ),
      
      # ------------------------------------------------------------
      # Land cover product(s)
      # ------------------------------------------------------------
      list_of_land_cover_names = c(
        
        land_cover1 = "LCC10",
        land_cover2 = "NTEMS"
      ),
      
      # ------------------------------------------------------------
      # Land cover product(s) reference year
      # ------------------------------------------------------------
      land_cover_year = 2010,
      
      # ------------------------------------------------------------
      # Inapplicable classes (may include water classes)
      # ------------------------------------------------------------
      inapplicable_classes_list = list(
        
        land_cover1 = c(17, 18),
        land_cover2 = c(20, 31)
      ),
      
      # ------------------------------------------------------------
      # Water classes (for water backgroun on maps)
      # ------------------------------------------------------------
      water_classes_list = list(
        
        land_cover1 = 18,
        land_cover2 = 20
      ),
      
      # ------------------------------------------------------------
      # Abbreviations for graphs
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
      # Seed for reproducibility
      # ------------------------------------------------------------
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