# Las librerias
library(tidyverse)
library(ggplot2)
library(readr)
library(dplyr)
library(tidyr)

# Pregunta 1
# Load the csv file seperated by commas
penguins_raw <- read.csv("~/Desktop/penguins_raw.csv", header = TRUE, sep = ",")
# Print the first 6 rows of the data
head(penguins_raw)
str(penguins_raw)
# penguins_raw_int <- read_csv("~/Desktop/penguins_raw.csv", col_types = cols(`Sample Number` = col_integer()))

# Convert Sample Number a integer (but already integer)
penguins_raw$Sample.Number <- as.integer(penguins_raw$Sample.Number)
str(penguins_raw)


# Pregunta 2
# Create a new datadrame where Island is Biscoe and Sex is FEMALE
penguins_raw2 <- penguins_raw %>%
  filter(Island == "Biscoe") %>%
  filter(Sex == "FEMALE")

head(penguins_raw2)

# See the column Island and Sex
print(penguins_raw2$Island)
print(penguins_raw2$Sex)


# Pregunta 3
# Create a new dataframe by removing the columns Comments, studyName y Sample Number
penguins_raw3 <- penguins_raw2 %>%
  select(-Comments, -studyName, -Sample.Number)

head(penguins_raw3)


# Pregunta 4
# str(penguins_raw2)
str(penguins_raw3)

# Change the name of the column with "_" instead of "."
colnames(penguins_raw3) <- gsub("\\.", "_", colnames(penguins_raw3))
colnames(penguins_raw) <- gsub("\\.", "_", colnames(penguins_raw))


# Calculate the mean of the numerics columns in and penguins_raw3
penguins_media <- penguins_raw %>%
  summarise(across(where(is.numeric), mean, na.rm = TRUE))

print(penguins_media)
str(penguins_raw)

head(penguins_raw)


# Pregunta 5
# Make a scatterplot of the columns Culmen Length (mm) and Flipper Length (mm) 
# with the color of the points determined by the column Species
# Remove rows with missing values
penguins_cleaned <- penguins_raw %>%
  filter(!is.na(Culmen_Length__mm_) & !is.na(Flipper_Length__mm_))

# Create the scatterplot
ggplot(penguins_cleaned, aes(x = Culmen_Length__mm_, y = Flipper_Length__mm_, color = Species)) +
  geom_point() +
  labs(title = "Scatterplot of Culmen Length (mm) and Flipper Length (mm)",
       x = "Culmen Length (mm)",
       y = "Flipper Length (mm)")


# Pregunta 6
# Make a barplot that contains 3 bars, one for each Sex. 
#Each of the graphs will represent the number of rows for each Island value with facets
# Remove rows with missing values
penguins_bar <- penguins_raw %>%
  filter(!is.na(Island) & !is.na(Sex))

# Create the barplot
ggplot(penguins_bar, aes(x = Island)) +
  geom_bar() +
  facet_wrap(~Sex) +
  labs(title = "Barplot of the number of rows for each Island value",
       x = "Island",
       y = "Number of rows")



# Pregunta 7
# Separate the Individual ID column into two columns
# one containing the first 2 characters and the other containing the following characters
penguins_raw <- penguins_raw %>%
  separate(Individual_ID, into = c("First_2", "Rest"), sep = 2)

head(penguins_raw)


# Pregunta 8
# Create a new Length column from Flipper Length (mm) that has the values “small”,
# if the value is between 172, 190, “normal”, if between 190, 213 and large, if between 213, 231
penguins_raw <- penguins_raw %>%
  mutate(Length = case_when(
    Flipper_Length__mm_ >= 172 & Flipper_Length__mm_ < 190 ~ "small",
    Flipper_Length__mm_ >= 190 & Flipper_Length__mm_ < 213 ~ "normal",
    Flipper_Length__mm_ >= 213 & Flipper_Length__mm_ <= 231 ~ "large"
  ))

head(penguins_raw)


# Pregunta 9
#Create a new column called studyNumber from studyName containing the numeric part of the study name
penguins_raw <- penguins_raw %>%
  mutate(studyNumber =case_when(
    studyName == "PAL0708" ~ "0708",
    studyName == "PAL0809" ~ "0809",
    studyName == "PAL0910" ~ "0910"
  ))

head(penguins_raw)



# Pregunta 10
# Convert the columns Date Egg and Date to date format
penguins_raw$Date_Egg <- as.Date(penguins_raw$Date_Egg, format = "%Y-%m-%d")

str(penguins_raw)

# Create a new column Year_Egg from Date Egg containing the year
penguins_raw <- penguins_raw %>%
  mutate(Year_Egg = year(Date_Egg))

head(penguins_raw)



# Pregunta 11
# Calculate the mean of the Culmen Length (mm) column for each of the combinations of Island and Clutch Completion
penguins_island_clutch <-penguins_raw %>%
  group_by(Island, Clutch_Completion) %>%
  summarise(mean_Culmen_Length = mean(Culmen_Length__mm_, na.rm = TRUE))

print(penguins_island_clutch)


#Pivot the result to convert it into a dataframe having 3 columns, “Island”, “No” and “Yes” with the data penguins_raw
penguins_island_clutch_pivot <- penguins_raw %>%
  group_by(Island, Clutch_Completion) %>%
  summarise(mean_Culmen_Length = mean(Culmen_Length__mm_, na.rm = TRUE)) %>%
  pivot_wider(names_from = Clutch_Completion, values_from = mean_Culmen_Length)


print(penguins_island_clutch_pivot)


# Pregunta 12
# Create a function, min_max_norm, that given a vector normalizes it to the range 0-1 with the formula: (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
min_max_norm <- function(x) {
  (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
}

# Normalize the numeric columns in penguins_raw by using the function min_max_norm
penguins_norm <- penguins_raw %>%
  mutate(across(where(is.numeric), min_max_norm))

head(penguins_norm)





