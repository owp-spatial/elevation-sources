import argparse
import os
import json
import re

import pandas as pd
import numpy as np 
import requests
from bs4 import BeautifulSoup

from table_processor.constants import OUTPUT_CATALOG_TABLE_DIR, OUTPUT_CATALOG_TABLE_PATH
from table_processor.utils import clean_catalog_table

def process_catalog(base_dir):
    if not os.path.exists(base_dir):
        print(f"Error: The specified base directory '{base_dir}' does not exist.")
        return
    
    OUTPUT_CATALOG_TABLE_DIR  = f"{base_dir}/output/"
    OUTPUT_CATALOG_TABLE_PATH = f"{OUTPUT_CATALOG_TABLE_DIR}stac_catalog_table.csv"
    # Get paths to catalogs
    catalog_table_paths = [os.path.join(base_dir, i) for i in os.listdir(base_dir) if not i.startswith(".")]
    
    # Read in Raw CSV tables
    catalog_df = pd.concat([pd.read_csv(i) for i in catalog_table_paths])
    catalog_df = clean_catalog_table(catalog_df)
    
    # Check if OUTPUT_CATALOG_TABLE_DIR exists
    if not os.path.exists(OUTPUT_CATALOG_TABLE_DIR):
        os.mkdir(OUTPUT_CATALOG_TABLE_DIR)
    
    catalog_df.to_csv(OUTPUT_CATALOG_TABLE_PATH, index=False)
    print(f"Processed catalog saved to {OUTPUT_CATALOG_TABLE_PATH}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process catalog tables from a given base directory.")
    parser.add_argument("base_dir", type=str, help="Path to the base directory containing catalog tables.")
    
    args = parser.parse_args()
    process_catalog(args.base_dir)
