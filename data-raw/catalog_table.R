## code to prepare `catalog_table` dataset goes here
collapse_vector_to_list <- function(vector) {
  if(is.null(vector)) {
    return("[]")
  }

  return(paste0("[", paste0("'", vector, "'", collapse = ", "), "]"))
}

# initial table
catalog_table <- read.csv("./inst/extdata/surface_catalog_table.csv")

# -------------------------------------------------------------------------------------------------
# ----- Add additional list elements to DATA_SOURCES_LIST to add entries to the catalog -----
# - 3DEP 10m DEM
# - 3DEP 30m DEM
# -------------------------------------------------------------------------------------------------
DATA_SOURCES_LIST <- list(
  list(
    domain = "conus",
    region = "conus",
    source = "3DEP",
    resolution = "10m",
    has_topo = TRUE,
    has_bathymetry = FALSE,
    horizontal_crs = "NAD83",
    vertical_datum = NA,
    vertical_datum_conversion = NA,
    priority = 0,
    source_url = "https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/13/TIFF/USGS_Seamless_DEM_13.vrt",
    asset_urls = collapse_vector_to_list(c("https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/13/TIFF/USGS_Seamless_DEM_13.vrt"))
  ),
  list(
    domain = "conus",
    region = "conus",
    source = "3DEP",
    resolution = "30m",
    has_topo = TRUE,
    has_bathymetry = FALSE,
    horizontal_crs = "NAD83",
    vertical_datum = NA,
    vertical_datum_conversion = NA,
    priority = 0,
    source_url = "https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/1/TIFF/USGS_Seamless_DEM_1.vrt",
    asset_urls = collapse_vector_to_list(c("https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/1/TIFF/USGS_Seamless_DEM_1.vrt"))
  )
)

# Add DATA_SOURCES_LIST rows to rest of catalog
DATA_SOURCES <- do.call(rbind, lapply(DATA_SOURCES_LIST, as.data.frame))
catalog_table <- rbind(catalog_table, DATA_SOURCES)

usethis::use_data(catalog_table, overwrite = TRUE)

