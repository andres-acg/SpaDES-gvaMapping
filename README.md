# SpaDES-gvaMapping

The project-level driver script for [`gvaMapping`](https://github.com/andres-acg/gvaMapping), a [SpaDES](https://spades.predictiveecology.org/) module that maps mean ground vegetation attribute (GVA) values per land cover class, from field plot data and one or more land cover products. gvaMapping is a generic tool — it isn't tied to any particular vegetation attribute, species, or region — see below and gvaMapping's own README for how to point it at your own data.

This repository does not contain any analysis code itself: `globalscript.R` sets up a self-contained SpaDES project, fetches the `gvaMapping` module from GitHub, configures its inputs and parameters, and runs it.

## This example: caribou lichen biomass in the Southern NWT and Wek'èezhìı regions

The configuration in this script is one worked example of using gvaMapping. It maps mean caribou lichen (*Cladonia* spp.) biomass per land cover class from field plot data and land cover products covering the Southern NWT and Wek'èezhìı boreal caribou range planning regions, Northwest Territories, as part of a backcasting/forecasting workflow for lichen biomass and caribou habitat developed for Andres Caseiro Guilhem's PhD thesis (Université Laval) — producing the first predictive map of caribou lichen biomass for northwestern North America.

This script's `land_cover_paths` use two of the four land cover products from the manuscript's own analysis (see "About gvaMapping" below): LCC10 and NTEMS. Because gvaMapping only needs a set of land cover rasters and matching parameters, it can equally be pointed at forecasted/projected land cover products to explore lichen biomass and caribou habitat under future climate and forest-change scenarios.

## How to use gvaMapping

Whatever your GVA, species, or region, running gvaMapping only requires supplying:

- **Plot data** (`dataset_list`) — one or more sets of GVA measurements at plot locations, either raw data with a matching loader (see "Plot data" below) or data that's already formatted.
- **Land cover product(s)** (`land_cover_paths`) — one or more rasters classifying the landscape.
- **Study area** (`study_area_path`) — a boundary used to filter plots and crop the land cover product(s).
- **Disturbance data** (`disturbances_path`, optional) — a polygon layer used to exclude disturbed plots.
- **A handful of parameters** describing your GVA and land cover classes: `measure_class`, `measure_name`, `unit`, `sampling_size_m2`, `target_gva`, `list_of_land_cover_names`, `land_cover_year`, `inapplicable_classes_list`, `water_classes_list`, and `abbrev_list` — see gvaMapping's own README, ["Key parameters"](https://github.com/andres-acg/gvaMapping#key-parameters), for what each one means.

Everything else — filtering plots to the study area, extracting land cover classes, computing weighted means, cross-validation, and mapping — is handled by the module itself. This script is one worked example of supplying those inputs and parameters; swap in your own plot data, land cover product(s), study area, and parameters to apply gvaMapping to a different GVA, region, or dataset entirely.

Two versions of the script are provided:

- `globalscript.R` — fully commented, walking through each section.
- `globalscriptCondensed.R` — the same configuration with the explanatory comments trimmed out.

Both do the same thing and can be run interchangeably.

## What this script does

1. Checks the running R version, then installs [`pak`](https://pak.r-lib.org/), followed by the development versions of [`Require`](https://github.com/PredictiveEcology/Require), [`reproducible`](https://github.com/PredictiveEcology/reproducible), [`SpaDES.tools`](https://github.com/PredictiveEcology/SpaDES.tools), and [`SpaDES.project`](https://github.com/PredictiveEcology/SpaDES.project) — the specific package versions `setupProject()` needs, from their GitHub development branches since some of the fixes required aren't on CRAN yet.
2. Calls `setupProject()`, which:
   - creates a self-contained project folder (with its own package library, so nothing is installed into your regular R library),
   - downloads the `gvaMapping` module from a **pinned commit** on this GitHub account (not a floating branch — neither this repo nor `gvaMapping` has tags or releases, so a branch reference alone isn't reproducible),
   - installs every package the module declares as a dependency,
   - and sets up the study area, land cover, and disturbance inputs and the `gvaMapping` parameters (see below).
3. Runs the module with `SpaDES.core::simInitAndSpades2()`.

If you update the pinned `gvaMapping` commit in `globalscript.R`/`globalscriptCondensed.R` (e.g. to pick up further development), re-run the script yourself first — the pin exists so what a reviewer runs matches what you tested, so it should only change deliberately.

## Requirements

- **R 4.5 or newer.** Older versions haven't been tested.
- **Any R IDE** — RStudio, [Positron](https://positron.posit.co/), VS Code with the R extension, or a plain R console/`Rscript`. Nothing in this script or in `gvaMapping` itself is RStudio-specific; see "How to run it" below for how the setup step differs (only cosmetically) between IDEs.
- **RTools** (Windows), so packages can be installed from source. Get the version matching your R install from <https://cran.r-project.org/bin/windows/Rtools/>.
- **Internet access**, and some patience — see "What gets downloaded" below.

## How to run it

`setupProject()`'s `Restart = TRUE` option (used below) automatically restarts and reopens the project in RStudio or Positron, since both let R packages hook into the IDE for that. Every other IDE doesn't support that hook, so `setupProject()` detects this and silently skips the restart, continuing in the current session instead — the pipeline itself runs identically either way.

**In RStudio or Positron:**

1. Copy the contents of `globalscript.R` (or `globalscriptCondensed.R`) into a new R script and save it anywhere — the name and location don't matter, but `global.R` is a reasonable choice.
2. Open that script and run it. The first run installs every required package into a project-specific library, which can take a while, and the IDE will automatically restart and reopen in the new project.
3. Re-run the script after the restart. You can now delete the copy from step 1 — the same script has been copied into the project folder.
4. For subsequent runs, open the project's own copy directly (`<projLocation>/SpaDES-gvaMapping/global.R`, where `projLocation` is whatever you set in the script — `~/Projects` by default) with its project file open, so the restart step is skipped.

**In VS Code, a plain R console, or via `Rscript`:**

1. Copy the contents of `globalscript.R` (or `globalscriptCondensed.R`) into a new R script and save it anywhere.
2. Run it (or `Rscript global.R` from a terminal). The first run installs every required package into a project-specific library, which can take a while. There's no restart step, so this single run does everything — start from a fresh R session (a new terminal, or a freshly opened R console) rather than one that's already loaded a lot of packages, since there's no automatic restart to fall back on if an already-loaded package conflicts with the version this script installs.
3. For subsequent runs, use the project's own copy directly (`<projLocation>/SpaDES-gvaMapping/global.R`).

Everything the script builds — the project folder, downloaded inputs, and computed outputs — is written under `projLocation`, **outside** this repository, and is not tracked by git (see `.gitignore`).

## What gets downloaded, and how long it takes

By default this script's `land_cover_paths` point at two full, national-scale land cover rasters (Canada-wide 2010 land cover, and the NTEMS/VLCE2 product), plus a national fire-disturbance polygon layer and the Southern NWT and Wek'èezhìı boreal caribou range planning regions boundary. These are downloaded in full before being cropped to the study area, so the first run downloads several gigabytes of data and can take anywhere from tens of minutes to a few hours depending on your connection — this is expected, not a sign that something has failed. Every expensive step is cached, so a second run against the same output directory reuses what's already been computed rather than redoing it.

If you'd rather not set `land_cover_paths` (and `study_area_path`) explicitly, leave them unset the same way `dataset_list` is left unset below — `gvaMapping`'s own `Init()` step will auto-fetch the same public LCC10 and NTEMS land cover products used above. This doesn't reduce the download: it's the same two national-scale rasters, just fetched by the module instead of configured in this script. See `gvaMapping`'s [README, "Running with no inputs"](https://github.com/andres-acg/gvaMapping#running-with-no-inputs-public-data-only-defaults).

## Plot data

This project's own analysis draws on several field plot datasets (`dataset_list`, referred to as `dataset1`–`dataset5` in `gvaMapping/R/preprocessing.R`). Their accessibility varies — some are private field data, others are hosted on repositories with their own access terms — but only one, dataset1 (Deninu Kųę́ First Nation et al. 2026), is public, via Zenodo ([doi:10.5281/zenodo.20054559](https://doi.org/10.5281/zenodo.20054559)).

The `sideEffects` block in the script supports either of two ways to supply a dataset:

- **Raw data** — assign its file path or URL to `raw_dataset1` (and `raw_dataset2`, `raw_dataset3`, etc. for additional datasets), and keep `preprocess <- TRUE`. Call the matching loader function for it from `gvaMapping/R/preprocessing.R` (one loader per raw data format); the result feeds into `dataset_list`.
- **Already-formatted data** — set `preprocess <- FALSE` and point `dataset_list` directly at your own formatted file(s).

By default, `raw_dataset1` is set to dataset1's own public Zenodo link, `preprocess` is `TRUE`, and it's loaded with `loadAndPrepRawDataset1()`, so the script builds dataset1 from that link and runs to completion end to end on public data alone, with no data of your own required. That same loader is also what the `gvaMapping` module itself falls back to if `dataset_list` is left out entirely — so the Zenodo link and the conversion logic live in exactly one place, `gvaMapping/R/preprocessing.R`, rather than being duplicated between this script and the module.

## Outputs

The module writes its results (the class-mean GVA table, GVA maps, an ensemble map and cross-validation map when more than one land cover product is supplied, and diagnostic plots) to disk rather than returning them as in-memory objects — see the `outputs` folder inside the project directory (`projLocation/SpaDES-gvaMapping/outputs/gvaMapping/` by default) after a run, and `gvaMapping`'s own [README, "Outputs"](https://github.com/andres-acg/gvaMapping#outputs) for what each file is.

## Related

- [`gvaMapping`](https://github.com/andres-acg/gvaMapping) — the module this script runs.
- [`WB_LichenBiomass`](https://github.com/andres-acg/WB_LichenBiomass) — consumes `gvaMapping`'s class-mean table and applies it across the full landscape raster.

## About gvaMapping

`gvaMapping` is part of a manuscript currently under review at a scientific journal:

> Guilhem, A.C., Barros, C., Degré-Timmons, G.É., Greuel, R.J., Errington, R.C., Baltzer, J.L., McIntire, E.J.B., Johnstone, J.F., & Cumming, S.G. *gvaMapping: a SpaDES module for mapping ground vegetation attributes from plot data and land cover products.*

## Author

Andres Caseiro Guilhem (andres.caseiro-guilhem.1@ulaval.ca), Université Laval.
