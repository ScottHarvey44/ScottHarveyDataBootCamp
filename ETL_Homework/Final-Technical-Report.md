Final Report for ETL Project by Scott Harvey

* **E**xtract: your original data sources and how the data was formatted (CSV, JSON, MySQL, etc).

My original data sources were a kaggle csv which included a list of NBA player names a yes/no flag indicating whether the player had a tattoo or not. The other source was scrapped from basketball-reference.com as a csv. This data included statistics for every player from the 2017-2018 NBA season.

* **T**ransform: what data cleaning or transformation was required.

For tattoo data, I needed to rename the columns for easier identification in Pandas. For NBA stats, I needed to drop excess statistics and reformat the name column to exclude the identifier after a \. This allowed the name data to match from both the data sets so that I could join based on this data.

* **L**oad: the final database, tables/collections, and why this was chosen.

I loaded all of the data into SQL using SQL alchemy. Each data source was given it's own table and then the tables were joined using player name for final anlysis. This was chosen because SQL allowed for easy and efficient querying of the data.