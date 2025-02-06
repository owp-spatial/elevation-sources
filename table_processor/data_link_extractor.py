import requests
from bs4 import BeautifulSoup

from abc import ABC, abstractmethod
from urllib.parse import urljoin
import re
from typing import List

class HTMLFetcher:
    """Fetches HTML content from a given URL."""
    
    @staticmethod
    def get_html(url: str):
        # if url.endswith(".html") or url.endswith(".htm"):
        response = requests.get(url)
        return response

class HTMLParser:
    """Parses HTML content and extracts anchor (`a`) tags."""
    
    @staticmethod
    def get_soup(response):
        return BeautifulSoup(response.content, 'html.parser') if response else None

class BaseLinkFilter(ABC):
    """Abstract base class for filtering links with different logic."""
    
    def __init__(self, suffix_patterns: List[str], contains: List[str]):
        self.suffix_patterns = suffix_patterns
        self.contains = contains

    @abstractmethod
    def build_regex(self) -> str:
        """Each subclass must implement its own filtering pattern."""
        pass
    
    @staticmethod
    def join_suffix_patterns(suffix_list: List[str]) -> str:
        return "|".join([f"{re.escape(suffix)}$" for suffix in suffix_list])

    @staticmethod
    def join_contains_patterns(contains_list: List[str]) -> str:
        return "|".join([re.escape(pattern) for pattern in contains_list])

class DefaultLinkFilter(BaseLinkFilter):
    """Default implementation of link filtering."""

    def build_regex(self) -> str:
        return "|".join([
            self.join_contains_patterns(self.contains), 
            self.join_suffix_patterns(self.suffix_patterns)
        ])

# EXample, in case websites need special filtering 
class CustomLinkFilter(BaseLinkFilter):
    """Custom filtering logic for a specific website."""

    def build_regex(self) -> str:
        return "|".join([
            self.join_contains_patterns(self.contains), 
            self.join_suffix_patterns(self.suffix_patterns), 
            # NOTE: add site specific REGEX here
            r"special_case_\d+\.json"  # website specific custom pattern filtering  
        ])


class DataLinkExtractor:
    """Main class that coordinates fetching, parsing, and filtering."""
    
    def __init__(self, url: str, filter_strategy: BaseLinkFilter):
        self.url = url
        self.filter_strategy = filter_strategy  # Uses an instance of a LinkFilter subclass

    def extract_links(self) -> List[str]:
        response = HTMLFetcher.get_html(self.url)
        soup = HTMLParser.get_soup(response)

        if not soup:
            return []

        # Get regex pattern from the chosen filter strategy
        link_regex = self.filter_strategy.build_regex()
        links = soup.find_all("a", href=re.compile(link_regex))

        # Convert relative URLs to absolute URLs
        return [urljoin(self.url, link["href"]) if not link["href"].startswith("http") else link["href"] for link in links]


# url = "https://noaa-nos-coastal-lidar-pds.s3.amazonaws.com/dem/NCEI_ninth_Topobathy_Hawaii_9428/index.html"

# # Use the default link filter
# default_filter = DefaultLinkFilter(suffix_patterns=[".vrt", ".nc"], contains=["catalog.json"])
# extractor = DataLinkExtractor(url, filter_strategy=default_filter)
# links = extractor.extract_links()

# print("Default Filter Links:", links)

# # Use a custom filter for a specific website
# custom_filter = CustomLinkFilter(suffix_patterns=[".zip"], contains=["special_catalog.json"])
# custom_extractor = DataLinkExtractor(url, filter_strategy=custom_filter)
# custom_links = custom_extractor.extract_links()

# print("Custom Filter Links:", custom_links)