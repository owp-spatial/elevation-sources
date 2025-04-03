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
    source_url = "https://spatial-water-noaa.s3.amazonaws.com/surface/nws-ehydro/puerto-rico-virgin-islands/AH_01_ARE_20111106_CS_2012_020.tif",
    asset_urls = jsonlite::toJSON(c("https://spatial-water-noaa.s3.amazonaws.com/surface/nws-ehydro/puerto-rico-virgin-islands/AH_01_ARE_20111106_CS_2012_020.tif"))
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
    source_url = "https://spatial-water-noaa.s3.amazonaws.com/surface/nws-ehydro/puerto-rico-virgin-islands/AH_01_ARE_20130420_CS_2013_042.tif",
    asset_urls = jsonlite::toJSON(c("https://spatial-water-noaa.s3.amazonaws.com/surface/nws-ehydro/puerto-rico-virgin-islands/AH_01_ARE_20130420_CS_2013_042.tif"))
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
    source_url = "https://spatial-water-noaa.s3.amazonaws.com/surface/nws-nos-surveys/tangier-sound/Tangier_Sound_NOS_NCEI-002.tif",
    asset_urls = jsonlite::toJSON(c("https://spatial-water-noaa.s3.amazonaws.com/surface/nws-nos-surveys/tangier-sound/Tangier_Sound_NOS_NCEI-002.tif"))
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
    source_url = "https://spatial-water-noaa.s3.amazonaws.com/surface/nws-topobathy/great-lakes/tbdem_great_lakes_30m.tif",
    asset_urls = jsonlite::toJSON(c("https://spatial-water-noaa.s3.amazonaws.com/surface/nws-topobathy/great-lakes/tbdem_great_lakes_30m.tif"))
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
  ),
  list(domain = "alaska",
    region = "alaska",
    source = "usgs_insar",
    resolution = "5m",
    has_topo = "True",
    has_bathymetry = "False",
    horizontal_crs = "",
    vertical_datum = "NAVD88",
    vertical_datum_conversion = "",
    priority = 1,
    source_url = "https://www.usgs.gov/ngp-user-engagement-office/alaska-mapping-initiative",
    asset_urls = jsonlite::toJSON(c("https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/2/TIFF/USGS_Seamless_DEM_2.vrt"))
  ),
  list(domain = "alaska",
    region = "alaska",
    source = "gebco_2024",
    resolution = "365m",
    has_topo = "True",
    has_bathymetry = "True",
    horizontal_crs = "WGS84",
    vertical_datum = "NAVD88",
    vertical_datum_conversion = "",
    priority = 2,
    source_url = "https://download.gebco.net/",
    asset_urls = jsonlite::toJSON(c("https://s3.us-west-2.amazonaws.com/us-west-2.opendata.source.coop/alexgleith/gebco-2024/GEBCO_2024.tif"))
  ), 
  list(domain = "alaska",
    region = "alaska",
    source = "pgc_articdem",
    resolution = "2m",
    has_topo = "True",
    has_bathymetry = "True",
    horizontal_crs = "WGS 1984 NSIDC Sea Ice Polar Stereographic North",
    vertical_datum = "WGS84 Ellipsoid",
    vertical_datum_conversion = "NAVD88 = WGS84 - 10.8355",
    priority = 3,
    source_url = "https://www.pgc.umn.edu/data/arcticdem/",
    asset_urls = jsonlite::toJSON(c("https://pgc-opendata-dems.s3.us-west-2.amazonaws.com/arcticdem/mosaics/v4.1/2m/46_08/46_08_1_1_2m_v4.1_dem.tif"))
  ), 
  list(domain = "alaska",
    region = "alaska",
    source = "pgc_articdem",
    resolution = "2m",
    has_topo = "True",
    has_bathymetry = "True",
    horizontal_crs = "WGS 1984 NSIDC Sea Ice Polar Stereographic North",
    vertical_datum = "WGS84 Ellipsoid",
    vertical_datum_conversion = "NAVD88 = WGS84 - 12.9273",
    source_url = "https://www.pgc.umn.edu/data/arcticdem/",
    asset_urls = jsonlite::toJSON(c("https://pgc-opendata-dems.s3.us-west-2.amazonaws.com/arcticdem/mosaics/v4.1/2m/46_08/46_08_1_2_2m_v4.1_dem.tif"))
  ), 
  list(domain = "alaska",
    region = "alaska",
    source = "pgc_articdem",
    resolution = "2m",
    has_topo = "True",
    has_bathymetry = "True",
    horizontal_crs = "WGS 1984 NSIDC Sea Ice Polar Stereographic North",
    vertical_datum = "WGS84 Ellipsoid",
    vertical_datum_conversion = "NAVD88 = WGS84 - 12.6722",
    priority = 3,
    source_url = "https://www.pgc.umn.edu/data/arcticdem/",
    asset_urls = jsonlite::toJSON(c("https://pgc-opendata-dems.s3.us-west-2.amazonaws.com/arcticdem/mosaics/v4.1/2m/46_08/46_08_2_2_2m_v4.1_dem.tif"))
  ), 
  list(domain = "alaska",
    region = "alaska",
    source = "pgc_articdem",
    resolution = "2m",
    has_topo = "True",
    has_bathymetry = "True",
    horizontal_crs = "WGS 1984 NSIDC Sea Ice Polar Stereographic North",
    vertical_datum = "WGS84 Ellipsoid",
    vertical_datum_conversion = "NAVD88 = WGS84 - 11.997",
    priority = 3,
    source_url = "https://www.pgc.umn.edu/data/arcticdem/",
    asset_urls = jsonlite::toJSON(c("https://pgc-opendata-dems.s3.us-west-2.amazonaws.com/arcticdem/mosaics/v4.1/2m/47_08/47_08_1_2_2m_v4.1_dem.tif"))
  )
)

# Add DATA_SOURCES_LIST rows to rest of catalog
DATA_SOURCES <- do.call(rbind, lapply(DATA_SOURCES_LIST, as.data.frame))
catalog_table <- rbind(catalog_table, DATA_SOURCES)

usethis::use_data(catalog_table, overwrite = TRUE)

