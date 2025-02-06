import json
from urllib.parse import urljoin
import re

import pandas as pd
import numpy as np 
import requests
from bs4 import BeautifulSoup

from table_processor.data_link_extractor import DefaultLinkFilter, DataLinkExtractor
from table_processor.constants import DATA_FILE_EXTENSIONS

def clean_catalog_table(df):
    
    # drop extra columns from data loading
    df = df.drop(columns=["assets_url", "Unnamed: 0"], errors = "ignore")

    # ---- Clean region column ----
    df['region'] = df['region'].fillna("")
    df['region'] = _snake_case_values(df['region'])

    # ---- Clean source column ----
    df['source'] = df['source'].fillna("")
    df['source'] = _snake_case_values(df['source'])
    
    # ---- Clean has_topo ----
    df['has_topo'] = np.where(
        df['has_topo'].isna(), 
        False,
        True
    )

    # ---- Clean has_bathymetry ----
    df['has_bathymetry'] = np.where(
        df['has_bathymetry'].isna(), 
        False,
        True
    )
   
    # ---- Clean horizontal_crs ----
    # ---- Clean vertical_datum ----
    # ---- Clean vertical_datum_conversion ----
    # ---- Clean url columns ---- 
    df['metadata_url'] = df['metadata_url'].fillna("")
    df['vrt_url'] = df['vrt_url'].fillna("")
    df['stac_catalog_url'] = df['stac_catalog_url'].fillna("")
    df['asset_urls'] = df['asset_urls'].fillna("")

    # ---- Clean priority ----
    df['priority'] = df['priority'].fillna(0)
    df['priority'] = df['priority'].astype("int")

    # ---- Get more data URLs by scraping pages that are known to contain certain data links in the HTML ---- 
    df['data_urls'] = df['metadata_url'].apply(lambda x: get_data_links(x) if has_data_links(x) else [x]) 

    # split the URLs into data and non data urls
    df['url_map'] = df.apply(lambda row: split_urls_into_groups(
                                            merge_urls(
                                            row['metadata_url'],
                                            row['asset_urls'].replace("'", "").split(","),
                                            row["vrt_url"],
                                            row["stac_catalog_url"],
                                            row["data_urls"]
                                                )
                                            ), 
                                        axis = 1
                                        )

    # set the final URL columns    
    df['source_urls'] = df['url_map'].apply(lambda x: x.get("metadata_urls"))
    df['source_url']  = df['source_urls'].apply(lambda x: x[0] if x else "")
    df['asset_urls']  = df['url_map'].apply(lambda x: x.get("asset_urls"))

    # drop excess columns
    df = df.drop(columns=["metadata_url", "source_urls", "stac_catalog_url", "vrt_url", "url_map", "data_urls"], errors= 'ignore')
    
    # Add domain column if it doesnt exist and use the region column value as the value if it doesnt exist
    if 'domain' not in df.columns:
        df['domain'] = df['region']

    COLUMN_ORDER = [
        "domain",
        "region",
        "source",
        "resolution", 
        "has_topo",
        "has_bathymetry",
        "horizontal_crs", 
        "vertical_datum",
        "vertical_datum_conversion",
        "priority",
        "source_url",
        "asset_urls"
    ]

    df = df[COLUMN_ORDER]

    return df

def merge_urls(*urls) -> list[str]:

    # print(f"urls: {urls}")

    url_list = []

    for url in urls:
        # print(f"url: \n > '{url}'")
        if url: 
            if isinstance(url, str):
                url_list.append(url.strip())
            elif isinstance(url, list):
                url_list.extend([i.strip() for i in url])
        # print()
                
    url_list = list(set([i for i in url_list if i]))
    return url_list 
    
def split_urls_into_groups(url_list: list[str]) -> dict: 

    urls_map = {
        "metadata_urls" : [],
        "asset_urls" : []
        }

    for url in url_list:
        # print(f"url: {url}")
        isDataURL = False
        for ext in DATA_FILE_EXTENSIONS:
            # print(f"   > ext: {ext}")
            if url.endswith(ext):
                # print(f"   --> Matches data extension {ext}")
                isDataURL = True
        if isDataURL:
            urls_map["asset_urls"].append(url)
        else:
            urls_map["metadata_urls"].append(url)
        
    return urls_map 

def get_data_links(url:str) -> list[str]:

    # [has_data_links(i) for i in df.metadata_url.values.tolist()]
    # urls =     [i for i in df.metadata_url.values.tolist() if has_data_links(i)]

    link_filter = DefaultLinkFilter(suffix_patterns=[".vrt", ".nc"], contains=["catalog.json"])
    link_extractor = DataLinkExtractor(url=url, filter_strategy=link_filter)

    data_links = link_extractor.extract_links()

    return data_links

def has_data_links(url:str) -> bool:

        # check if the url ends with any common data type extensions
        for ext in DATA_FILE_EXTENSIONS:
            if url.endswith(ext):
                return False
        
        ignore_patterns = ["nowcoast.noaa.gov"]
        for pattern in ignore_patterns:
            if pattern in url:
                return False

        # check for url prefixes that have pages that will hold data links
        url_patterns = ["chs", "chs.coast", "ncei.noaa", "noaa-nos", "coast.noaa"]

        for pattern in url_patterns:
            if pattern in url:
                return True
        
        return False

def _snake_case_values(df_column):
    return df_column.str.lower().str.strip().str.replace(",", " ").str.replace(r'\s+', '_', regex=True) 

def get_collection_list_from_catalog_table(df):
    # df = catalog_df.copy()
    # df
    
    collections_list = []

    for index, row  in df.iterrows():
        # print(f"index: {index}\nrow: {row}")
        stac_collection = STACCollectionSource(
            id = row['domain'],
            title = f"{row['domain']} title", 
            description=f"{row['domain']} description"
        )
        collections_list.append(stac_collection)
        # print()

    return collections_list