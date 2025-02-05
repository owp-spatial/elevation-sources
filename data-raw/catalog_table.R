## code to prepare `catalog_table` dataset goes here
collapse_vector_to_list <- function(vector) {
  if(is.null(vector)) {
    return("[]")
  }

  return(paste0("[", paste0("'", vector, "'", collapse = ", "), "]"))
}

# Initial table
catalog_table <- read.csv("./inst/extdata/surface_catalog_table.csv")

# 3DEP data
conus_dem_list <- list(
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

# Add 3DEP rows to rest of catalog
conus_dem     <- do.call(rbind, lapply(conus_dem_list, as.data.frame))
catalog_table <- rbind(catalog_table, conus_dem)

usethis::use_data(catalog_table, overwrite = TRUE)

