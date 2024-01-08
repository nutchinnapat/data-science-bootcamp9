# Check if not install packages yet
if (!require(tidyverse)) {
  install.packages("tidyverse")
}

if (!require(dplyr)) {
  install.packages("dplyr")
}

if (!require(nycflights13)) {
  install.packages("nycflights13")
}

# call for packages
library(tidyverse)
library(dplyr)
library(nycflights13)

# data set
data("airlines")
data("airports")
data("flights")
data("planes")
data("weather")



## Q1. Average delay time for each airline?
# join dataset [airline <-> flights]
q1_joined_data <- flights %>% 
  left_join(airlines, by = "carrier")

#cal avg arrival delay and group data
avg_delay_each_airline <- q1_joined_data %>% 
  group_by(name) %>%
  mutate(arr_delay = replace_na(arr_delay, 0)) %>% 
  summarize(avg_delay = mean(arr_delay)) %>% 
  arrange(desc(avg_delay)) %>% 
  head(15)

print(avg_delay_each_airline)



## Q2. Frequency & number of flights vary across different seasons?
# Filter the data to include only rows with non-NA values for 'origin', 'dest', and 'month'

data("flights")

flights <- flights %>%
  filter(!is.na(origin) & !is.na(dest) & !is.na(month))

# Define the 'season' variable based on 'month'
flights_grouped <- flights %>%
  mutate(season = case_when(
    month %in% c(12, 1, 2) ~ "Winter",
    month %in% c(3, 4, 5) ~ "Spring",
    month %in% c(6, 7, 8) ~ "Summer",
    month %in% c(9, 10, 11) ~ "Fall"
  ))

# Group flights by origin, destination, and season
flights_grouped <- flights_grouped %>%
  group_by(origin, dest, season) %>% 
  summarize(Total_flights = n())

# Convert the 'season' column into separate columns
flights_grouped <- flights_grouped %>%
  spread(season, Total_flights, fill = 0)

# Sum for each origin and dest
flights_grouped <- flights_grouped %>% 
  group_by(origin, dest) %>% 
  summarize(
    Fall = sum(Fall),
    Spring = sum(Spring),
    Summer = sum(Summer),
    Winter = sum(Winter),
    Total_flights = sum(Fall, Spring, Summer, Winter)
    )
# Reorder the columns to match the desired order
flights_grouped <- flights_grouped %>%
  select(origin, dest, Total_flights, Fall, Spring, Summer, Winter) %>% 
  arrange(desc(Total_flights)) %>% 
  head(10)

# Print the updated data frame
print(flights_grouped)



# Q3. What are the top 15 routes by total number of flights, 
# considering both wide-body and narrow-body aircraft?

data("flights")
data("planes")

# Cal avg number of seats
avg_seats <- mean(planes$seats)
# Categorize into wide or narrow->planes
#assume cutoff point is average of seats
planes$aircrafts_type <- ifelse(planes$seats > avg_seats, "Wide_body", "Narrow_body")

# Calculate the total number of flights for each route + rename()
route_counts <- flights %>%
  left_join(planes, by = "tailnum") %>%
  group_by(origin, dest, aircrafts_type) %>%
  count() %>%
  rename(total_flights = n)

route_counts <- route_counts %>% 
  filter(!is.na(aircrafts_type))

# Calculate the average distance flown for each route
avg_distance_per_route <- flights %>%
  left_join(planes, by = "tailnum") %>%
  group_by(origin, dest, aircrafts_type) %>%
  summarize(avg_distance = mean(distance))

# Join the route counts and average distance data
route_summary <- route_counts %>%
  left_join(avg_distance_per_route, by = c("origin", "dest", "aircrafts_type")) %>% 
  arrange(desc(total_flights))

# Identify the top 15 routes
top_15_routes <- route_summary %>%
  select(origin, dest, avg_distance, total_flights, aircrafts_type) %>% 
  head(15)

# Print the top 15 routes with average distance flown
print(top_15_routes)
# if we use this pattern, we still can report full list by route_summary if needed



### Assuming no weather data is available for comparison, NA=no_weather and no_weather 
### Instead of relying on missing values, a cutoff point should be established to distinguish between with_weather and no_weather categories.
# Q4. How does the average arrival delay differ between flights with and without visibility data?

data("flights")
data("weather")
data("planes")

# Filter for delayed flights
delayed_flights <- flights %>%
  filter(arr_delay > 0)

# Join data frames based on origin, year, month, and day
delayed_flights_with_weather <- delayed_flights %>%
  left_join(weather, by = c("origin", "year", "month", "day"), relationship = "many-to-many") %>%
  select(dep_time, arr_time, arr_delay, dep_delay, visib, precip, wind_speed, tailnum)

# Identify flights with no weather data
delayed_flights_no_weather <- delayed_flights %>%
  left_join(weather, by = c("origin", "year", "month", "day"), relationship = "many-to-many") %>%
  filter(is.na(visib))

# Calculate average arrival delay for both groups by model
avg_delay_with_weather_by_model <- delayed_flights_with_weather %>%
  left_join(planes, by = "tailnum") %>%
  group_by(model) %>%
  summarize(avg_delay_with_weather = mean(arr_delay))

avg_delay_no_weather_by_model <- delayed_flights_no_weather %>%
  left_join(planes, by = "tailnum") %>%
  group_by(model) %>%
  summarize(avg_delay_no_weather = mean(arr_delay))

# Calculate delay difference by model
delay_difference_by_model <- avg_delay_with_weather_by_model$avg_delay_with_weather -
  avg_delay_no_weather_by_model$avg_delay_no_weather

# Calculate average visibility by model
avg_visib_by_model <- delayed_flights_with_weather %>%
  filter(!is.na(visib)) %>% 
  left_join(planes, by = "tailnum") %>%
  group_by(model) %>%
  summarize(avg_visib = mean(visib))

# Combine model and delay difference data into a data frame
summary_table <- data.frame(model = avg_delay_with_weather_by_model$model,
                            delay_difference = delay_difference_by_model,
                            avg_visib = avg_visib_by_model$avg_visib) %>% 
  arrange(desc(delay_difference_by_model)) %>% 
  head(10)
# Print the summary table
print(summary_table)



# Q5. What is the most popular origin airport for flights departing during the summer months?

# Filter flights departing during (June, July, August)
summer_flights <- flights %>%
  filter(month %in% c(6, 7, 8))

# Count the number of flights for each origin airport
origin_count_summer <- summer_flights %>%
  group_by(origin) %>%
  summarise(flight_count = n())

# Sort the results in descending order of flight count
sorted_origin_count_summer <- origin_count_summer %>%
  left_join(airports, by = c("origin" = "faa")) %>%
  select(name, flight_count, tzone, tz, dst) %>% 
  arrange(desc(flight_count))

# Print the most popular origin airport
print(head(sorted_origin_count_summer))
