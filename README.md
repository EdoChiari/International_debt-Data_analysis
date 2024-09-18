# International_debt-Data_analysis
## Dataset Description

The dataset used in this analysis is stored in a CSV file and contains the following columns:

- Country Name: The name of the country.

- Country Code: A three-character code representing each country.

- Indicator Name: The name of the debt indicator (e.g., external debt, total debt service).

- Indicator Code: A unique code representing each indicator.

- Debt: The total debt amount for the respective country and indicator.

## SQL Code Explanation

The SQL code provided carries out various steps to analyze the international debt data. It starts by setting up the environment to store and process the data, followed by running queries that offer insights into the dataset.

First, the table international_debt is created to hold the data from the CSV file. The table is structured with columns for country name, country code, debt indicator names and codes, and the debt amount. The table uses appropriate data types to ensure the data is stored in a consistent format.

After creating the table, the next step involves importing the data from a CSV file using the COPY command, which efficiently loads the data into the international_debt table. This step makes sure that the data is available in the database for further analysis.

Once the data is loaded, a simple SELECT * query is executed to verify the success of the import and to ensure that all records are present. To further validate the data, a check for missing values is performed on all the columns. This ensures that no crucial information is missing from the dataset, such as country names or debt figures.

The next set of queries focuses on understanding the dataset’s structure and the unique values it contains. For instance, a query is used to find out how many distinct countries are represented in the dataset. Another query identifies the unique debt indicators, helping to understand the various categories of debt measured in the dataset.

Following this, the analysis shifts toward debt calculations. One query calculates the total debt owed by all countries combined, providing an aggregate view of the international debt. To dig deeper, the countries with the highest debt are identified, and a list of the top five countries by total debt is produced. This is followed by a more detailed analysis of debt distribution, using percentile rankings to show how debt is distributed across countries. This ranking helps identify countries with relatively low or high debt compared to others.

The analysis continues by examining the average debt associated with different debt indicators. This allows for a comparison of various types of debt across the dataset. Additionally, outlier detection is conducted by identifying countries whose total debt is significantly higher than the average, highlighting countries with unusually high debt levels.

Finally, the SQL code explores how debt is distributed among the different debt indicators by calculating the proportion of total debt for each indicator. This reveals which types of debt are most prevalent in the dataset. The frequency of each debt indicator is also calculated to identify the most common debt categories. The code concludes with a ranking of the top 10 countries for each debt indicator, offering a more granular view of country-specific performance for different types of debt.

Through these steps, the SQL code provides a thorough analysis of the international debt data, covering multiple dimensions like total debt, debt distribution, and country-specific insights. Each query is designed to answer key questions that contribute to a comprehensive understanding of global debt patterns.
## Badges

Add badges from somewhere like: [shields.io](https://shields.io/)

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)
[![AGPL License](https://img.shields.io/badge/license-AGPL-blue.svg)](http://www.gnu.org/licenses/agpl-3.0)

