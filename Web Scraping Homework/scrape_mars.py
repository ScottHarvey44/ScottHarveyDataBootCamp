from splinter import Browser
from bs4 import BeautifulSoup
import pandas as pd


def init_browser():
    # @NOTE: Replace the path with your actual path to the chromedriver
    executable_path = {"executable_path": "/usr/local/bin/chromedriver"}
    return Browser("chrome", **executable_path, headless=False)


def scrape():
    #grab news title and paragraph
    url = 'https://mars.nasa.gov/news/'
    browser.visit(url)
    html = browser.html
    soup = BeautifulSoup(html, 'html.parser')

    scrape_dict = {'news_title': news_title, 'news_p': news_p, 'featured_image_url': featured_image_url,'mars_weather': mars_weather, }

    results = soup.find_all('li', class_="slide")
    title = results[0].find('div', class_='content_title')
    news_title = title.a.text


    paragraph = results[0].find('div', class_='article_teaser_body')
    news_p = paragraph.text
    
    #Grab image url
    url = "https://www.jpl.nasa.gov/spaceimages/?search=&category=Mars"
    browser.visit(url)
    html = browser.html
    soup = BeautifulSoup(html, 'html.parser')

    results = soup.find_all('img', class_="thumb")
    img = results[0]["src"]
    featured_image_url = 'https://www.jpl.nasa.gov' + img

    #Grab latest tweet
    twitter_url = 'https://twitter.com/marswxreport?lang=en)'
    browser.visit(twitter_url)
    html = browser.html
    soup = BeautifulSoup(html, 'html.parser')

    results = soup.find_all('div', class_="js-tweet-text-container")
    mars_weather = results[0].p.text

    #grab table
    table_url = 'http://space-facts.com/mars/'
    table = pd.read_html(table_url)
    df = table[0]
    df.columns = ['Column1', 'Column2']