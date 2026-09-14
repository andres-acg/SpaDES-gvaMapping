# SpaDES-gvaMapping

The project-level driver script for [`gvaMapping`](https://github.com/andres-acg/gvaMapping), a [SpaDES](https://spades.predictiveecology.org/) module that estimates mean ground vegetation attribute (GVA) values — in this project, reindeer lichen (*Cladonia* spp.) biomass — per land cover class, from field plot data and a land cover product.

This repository does not contain any analysis code itself: `globalscript.R` sets up a self-contained SpaDES project, fetches the `gvaMapping` module from GitHub, configures its inputs and parameters, and runs it. It is part of a backcasting/forecasting workflow for lichen biomass and caribou habitat in the Wek'èezhìi region, Northwest Territories, developed for Andres Caseiro Guilhem's PhD thesis (Université Laval).

Two versions of the script are provided:

- `globalscript.R` — fully commented, walking through each section.
- `globalscriptCondensed.R` — the same configuration with the explanatory comments trimmed out.

Both do the same thing and can be run interchangeably.

## What this script does

1. Installs [`pak`](https://pak.r-lib.org/), then the development versions of [`Require`](https://github.com/PredictiveEcology/Require) and [`SpaDES.project`](https://github.com/PredictiveEcology/SpaDES.project) — the tooling `setupProject()` needs.
2. Calls `setupProject()`, which:
   - creates a self-contained project folder (with its own package library, so nothing is installed into your regular R library),
   - downloads the `gvaMapping` module from this GitHub account,
   - installs every package the module declares as a dependency,
   - and sets up the study area, land cover, and disturbance inputs and the `gvaMapping` parameters (see below).
3. Runs the module with `SpaDES.core::simInitAndSpades2()`.

## Requirements

- **R 4.5 or newer.** Older versions haven't been tested.
- **RStudio.** The setup/restart flow described below (and the "the RStudio project will reopen automatically" step) assumes RStudio is being used, not a plain `Rscript` run.
- **RTools** (Windows), so packages can be installed from source. Get the version matching your R install from <https://cran.r-project.org/bin/windows/Rtools/>.
- **Internet access**, and some patience — see "What gets downloaded" below.

## How to run it

1. Copy the contents of `globalscript.R` (or `globalscriptCondensed.R`) into a new R script and save it anywhere — the name and location don't matter, but `global.R` is a reasonable choice.
2. Open that script in RStudio and run it. The first run installs every required package into a project-specific library, which can take a while, and RStudio will automatically restart and reopen in the new project.
3. Re-run the script after the restart. You can now delete the copy from step 1 — the same script has been copied into the project folder.
4. For subsequent runs, open the project's own copy directly (`<projLocation>/SpaDES-gvaMapping/global.R`, where `projLocation` is whatever you set in the script — `~/Projects` by default) with its RStudio project (`.Rproj`) open, so the restart step is skipped.

Everything the script builds — the project folder, downloaded inputs, and computed outputs — is written under `projLocation`, **outside** this repository, and is not tracked by git (see `.gitignore`).

## What gets downloaded, and how long it takes

By default this script's `land_cover_paths` point at two full, national-scale land cover rasters (Canada-wide 2010 land cover, and the NTEMS/VLCE2 product), plus a national fire-disturbance polygon layer and the Wek'èezhìi study area boundary. These are downloaded in full before being cropped to the study area, so the first run downloads several gigabytes of data and can take anywhere from tens of minutes to a few hours depending on your connection — this is expected, not a sign that something has failed. Every expensive step is cached, so a second run against the same output directory reuses what's already been computed rather than redoing it.

If you'd rather run something lighter, unset `land_cover_paths` (and `study_area_path`) the same way `dataset_list` is left unset below — `gvaMapping`'s own `Init()` step will auto-fetch a smaller, study-area-cropped public land cover default (SCANFI) instead. See `gvaMapping`'s [README, "Running with no inputs"](https://github.com/andres-acg/gvaMapping#running-with-no-inputs-public-data-only-defaults).

## Plot data

This project's own analysis draws on several field plot datasets (`dataset_list`, referred to as `dataset1`–`dataset5` in `gvaMapping/R/preprocessing.R`). Their accessibility varies — some are private field data, others are hosted on repositories with their own access terms — but only one, dataset1 (Deninu Kué First Nation et al. 2026), is currently wired into this script and the `gvaMapping` module as a public, automatically downloaded default, via Zenodo ([doi:10.5281/zenodo.20054559](https://doi.org/10.5281/zenodo.20054559)).

Accordingly, `dataset_list` is deliberately left **unset** in this script. With no `dataset_list` supplied, `gvaMapping`'s `Init()` step fetches that Zenodo default automatically, so the script still runs to completion, end to end, on public data alone, producing a real result from real (if more limited) data rather than a placeholder. The other datasets aren't auto-fetched here regardless of where they're hosted; if you have access to them, the script shows, commented out, where to point `dataset_list` at your own preformatted data instead.

## Outputs

The module writes its results (the class-mean GVA table, GVA maps, an ensemble map and cross-validation map when more than one land cover product is supplied, and diagnostic plots) to disk rather than returning them as in-memory objects — see the `outputs` folder inside the project directory (`projLocation/SpaDES-gvaMapping/outputs/gvaMapping/` by default) after a run, and `gvaMapping`'s own [README, "Outputs"](https://github.com/andres-acg/gvaMapping#outputs) for what each file is.

## Related

- [`gvaMapping`](https://github.com/andres-acg/gvaMapping) — the module this script runs.
- [`WB_LichenBiomass`](https://github.com/andres-acg/WB_LichenBiomass) — consumes `gvaMapping`'s class-mean table and applies it across the full landscape raster.

## Author

Andres Caseiro Guilhem (andres.caseiro-guilhem.1@ulaval.ca), Université Laval.
