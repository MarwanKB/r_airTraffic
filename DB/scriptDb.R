# Install the necessary packages
install.packages("DBI")
install.packages("RMySQL")

# Load the packages
library(DBI)
library(RMySQL)

# Define connection parameters
host <- "mysql-traffic-aerien.alwaysdata.net"
port <- 3306
dbname <- "traffic-aerien_projet"
user <- ""
password <- ""

# Establish the connection
con <- dbConnect(
  RMySQL::MySQL(),
  host = host,
  port = port,
  dbname = dbname,
  user = user,
  password = password
)

# Check the connection
print(con)

# Don't forget to disconnect when you're done
# dbDisconnect(con)