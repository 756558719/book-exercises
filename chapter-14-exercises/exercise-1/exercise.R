# Exercise 1: reading and querying a web API

# Load the httr and jsonlite libraries for accessing data
# You can also load `dplyr` if you wish to use it
library("httr")
library("jsonlite")
library("dplyr")

# Create a variable base_uri that stores the base URI (as a string) for the 
# Github API (https://api.github.com)
base_url <- "https://api.github.com"

# Under the "Repositories" category of the API documentation, find the endpoint 
# that will list _repos in an organization_. Then create a variable named
# `org_resource` that stores the endpoint for the `programming-for-data-science`
# organization repos (this is the _path_ to the resource of interest).
org_resource <- "/orgs/programming-for-data-science/repos"

# Send a GET request to this endpoint (the `base_uri` followed by the 
# `org_resource` path). Print the response to show that your request worked. 
# (The listed URI will also allow you to inspect the JSON in the browser easily).
uri <- paste0(base_url, org_resource)
GET(uri)

# Extract the content of the response using the `content()` function, saving it
# in a variable.
body_data <- content(GET(uri), "text")

# Convert the content variable from a JSON string into a data frame.
df <- fromJSON(body_data)

# How many (public) repositories does the organization have?
nrow(df)

# Now a second query:
# Create a variable `search_endpoint` that stores the endpoint used to search 
# for repositories. (Hint: look for a "Search" endpoint in the documentation).
search_endpoint <- "/search/repositories"

# Search queries require a query parameter (for what to search for). Create a 
# `query_params` list variable that specifies an appropriate key and value for 
# the search term (you can search for anything you want!)
query_params <- list(q = "informatics")

# Send a GET request to the `search_endpoint`--including your params list as the
# `query`. Print the response to show that your request worked.
query_uri <- paste0(base_url, search_endpoint)
query_result <- GET(query_uri, query = query_params)

# Extract the content of the response and convert it from a JSON string into a
# data frame. 
query_body <- fromJSON(content(query_result, "text"))

# How many search repos did your search find? (Hint: check the list names to 
# find an appropriate value).
num_repo <- query_body$total_count

# What are the full names of the top 5 repos in the search results?
repos <- query_body$items
top_n(repos, 5)
