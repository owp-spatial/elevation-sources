library(jsonlite)
library(usethis)
# library(dplyr)

## code to prepare `catalog_table` dataset goes here

# initial table
catalog_table <- read.csv("./inst/extdata/surface_catalog_table.csv")

# -------------------------------------------------------------------------------------------------
# ----- Add additional list elements to DATA_SOURCES_LIST to add entries to the catalog -----
# - 3DEP 10m DEM
# - 3DEP 30m DEM
# - ehydro
# - nos surveys
# - topobathy
# -------------------------------------------------------------------------------------------------
DATA_SOURCES_LIST <- list(
  list(
    domain = "conus",
    region = "conus",
    source = "3DEP",
    resolution = "10m",
    has_topo = "True",
    has_bathymetry = "False",
    horizontal_crs = "NAD83",
    vertical_datum = "",
    vertical_datum_conversion = "",
    priority = 0,
    source_url = "https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/13/TIFF/USGS_Seamless_DEM_13.vrt",
    asset_urls = jsonlite::toJSON(c("https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/13/TIFF/USGS_Seamless_DEM_13.vrt"))
  ),
  list(
    domain = "conus",
    region = "conus",
    source = "3DEP",
    resolution = "30m",
    has_topo = "True",
    has_bathymetry = "False",
    horizontal_crs = "NAD83",
    vertical_datum = "",
    vertical_datum_conversion = "",
    priority = 0,
    source_url = "https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/1/TIFF/USGS_Seamless_DEM_1.vrt",
    asset_urls = jsonlite::toJSON(c("https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/1/TIFF/USGS_Seamless_DEM_1.vrt"))
  ),
  list(
    domain = "conus",
    region = "conus",
    source = "nws-ehydro",
    resolution = "",
    has_topo = "False",
    has_bathymetry = "False",
    horizontal_crs = "",
    vertical_datum = "",
    vertical_datum_conversion = "",
    priority = 1,
    source_url = "https://spatial-water-noaa.s3.amazonaws.com/surface/nws-ehydro/conus/epydro_BW_03_OLV_20170207_CS_OLD_LOCK_10_AND_11_BAR_sounding_points.tif",
    asset_urls = jsonlite::toJSON(c("https://spatial-water-noaa.s3.amazonaws.com/surface/nws-ehydro/conus/epydro_BW_03_OLV_20170207_CS_OLD_LOCK_10_AND_11_BAR_sounding_points.tif"))
  ),
  list(
    domain = "puerto-rico-virgin-islands",
    region = "puerto-rico-virgin-islands",
    source = "nws-ehydro",
    resolution = "",
    has_topo = "False",
    has_bathymetry = "False",
    horizontal_crs = "",
    vertical_datum = "",
    vertical_datum_conversion = "",
    priority = 1,
    source_url = "https://spatial-water-noaa.s3.amazonaws.com/surface/nws-ehydro/conus/epydro_BW_03_OLV_20170207_CS_OLD_LOCK_10_AND_11_BAR_sounding_points.tif",
    asset_urls = jsonlite::toJSON(c("https://spatial-water-noaa.s3.amazonaws.com/surface/nws-ehydro/conus/epydro_BW_03_OLV_20170207_CS_OLD_LOCK_10_AND_11_BAR_sounding_points.tif"))
  ),
  list(
    domain = "albemarle-sound",
    region = "albemarle-sound",
    source = "nws-nos-surveys",
    resolution = "",
    has_topo = "False",
    has_bathymetry = "False",
    horizontal_crs = "",
    vertical_datum = "",
    vertical_datum_conversion = "",
    priority = 1,
    source_url = "",
    asset_urls = jsonlite::toJSON(c(""))
  ),
  list(
    domain = "chesapeake-bay",
    region = "chesapeake-bay",
    source = "nws-nos-surveys",
    resolution = "",
    has_topo = "False",
    has_bathymetry = "False",
    horizontal_crs = "",
    vertical_datum = "",
    vertical_datum_conversion = "",
    priority = 1,
    source_url = "",
    asset_urls = jsonlite::toJSON(c(""))
  ),
  list(
    domain = "mobile-bay",
    region = "mobile-bay",
    source = "nws-nos-surveys",
    resolution = "",
    has_topo = "False",
    has_bathymetry = "False",
    horizontal_crs = "",
    vertical_datum = "",
    vertical_datum_conversion = "",
    priority = 1,
    source_url = "",
    asset_urls = jsonlite::toJSON(c(""))
  ),
  list(
    domain = "tangier-sound",
    region = "tangier-sound",
    source = "nws-nos-surveys",
    resolution = "",
    has_topo = "False",
    has_bathymetry = "False",
    horizontal_crs = "",
    vertical_datum = "",
    vertical_datum_conversion = "",
    priority = 1,
    source_url = "",
    asset_urls = jsonlite::toJSON(c(""))
  ),
  list(
    domain = "alaska",
    region = "alaska",
    source = "nws-topobathy",
    resolution = "30m",
    has_topo = "False",
    has_bathymetry = "False",
    horizontal_crs = "",
    vertical_datum = "",
    vertical_datum_conversion = "",
    priority = 1,
    source_url = "https://spatial-water-noaa.s3.amazonaws.com/surface/nws-topobathy/alaska/tbdem_alaska_30m.tif",
    asset_urls = jsonlite::toJSON(c("https://spatial-water-noaa.s3.amazonaws.com/surface/nws-topobathy/alaska/tbdem_alaska_30m.tif"))
  ),
  list(
    domain = "conus-atlantic-gulf",
    region = "conus-atlantic-gulf",
    source = "nws-topobathy",
    resolution = "30m",
    has_topo = "False",
    has_bathymetry = "False",
    horizontal_crs = "",
    vertical_datum = "",
    vertical_datum_conversion = "",
    priority = 1,
    source_url = "https://spatial-water-noaa.s3.amazonaws.com/surface/nws-topobathy/conus-atlantic-gulf/tbdem_conus_atlantic_gulf_30m.tif",
    asset_urls = jsonlite::toJSON(c("https://spatial-water-noaa.s3.amazonaws.com/surface/nws-topobathy/conus-atlantic-gulf/tbdem_conus_atlantic_gulf_30m.tif"))
  ),
  list(
    domain = "conus-pacific",
    region = "conus-pacific",
    source = "nws-topobathy",
    resolution = "30m",
    has_topo = "False",
    has_bathymetry = "False",
    horizontal_crs = "",
    vertical_datum = "",
    vertical_datum_conversion = "",
    priority = 1,
    source_url = "https://spatial-water-noaa.s3.amazonaws.com/surface/nws-topobathy/conus-pacific/tbdem_conus_pacific_30m.tif",
    asset_urls = jsonlite::toJSON(c("https://spatial-water-noaa.s3.amazonaws.com/surface/nws-topobathy/conus-pacific/tbdem_conus_pacific_30m.tif"))
  ),
  list(
    domain = "great-lakes",
    region = "great-lakes",
    source = "nws-topobathy",
    resolution = "",
    has_topo = "False",
    has_bathymetry = "False",
    horizontal_crs = "",
    vertical_datum = "",
    vertical_datum_conversion = "",
    priority = 1,
    source_url = "",
    asset_urls = jsonlite::toJSON(c(""))
  ),
  list(
    domain = "hawaii",
    region = "hawaii",
    source = "nws-topobathy",
    resolution = "30m",
    has_topo = "False",
    has_bathymetry = "False",
    horizontal_crs = "",
    vertical_datum = "",
    vertical_datum_conversion = "",
    priority = 1,
    source_url = "https://spatial-water-noaa.s3.amazonaws.com/surface/nws-topobathy/hawaii/tbdem_hawaii_30m.tif",
    asset_urls = jsonlite::toJSON(c("https://spatial-water-noaa.s3.amazonaws.com/surface/nws-topobathy/hawaii/tbdem_hawaii_30m.tif"))
  ),
  list(
    domain = "puerto-rico-virgin-islands",
    region = "puerto-rico-virgin-islands",
    source = "nws-topobathy",
    resolution = "30m",
    has_topo = "False",
    has_bathymetry = "False",
    horizontal_crs = "",
    vertical_datum = "",
    vertical_datum_conversion = "",
    priority = 1,
    source_url = "https://spatial-water-noaa.s3.amazonaws.com/surface/nws-topobathy/puerto-rico-virgin-islands/tbdem_pr_usvi_30m.tif",
    asset_urls = jsonlite::toJSON(c("https://spatial-water-noaa.s3.amazonaws.com/surface/nws-topobathy/puerto-rico-virgin-islands/tbdem_pr_usvi_30m.tif"))
  )
)

# Add DATA_SOURCES_LIST rows to rest of catalog
DATA_SOURCES <- do.call(rbind, lapply(DATA_SOURCES_LIST, as.data.frame))
catalog_table <- rbind(catalog_table, DATA_SOURCES)

usethis::use_data(catalog_table, overwrite = TRUE)

