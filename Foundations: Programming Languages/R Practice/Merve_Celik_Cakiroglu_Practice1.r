# Change the working directory
print(getwd())
# script.dir <- dirname(sys.frame(1)$ofile)
# setwd(script.dir)

# Question 1
# Read the file comptagevelo2017.csv as a dataframe.
my_df <- read.csv("comptagevelo2017.csv", header = TRUE, sep = ",", check.names=FALSE, na.strings = "")
# print(head(my_df))

# Question 2
# Remove column 2 from the dataframe.
my_df <- my_df[,-2]
print(head(my_df))

# Question 3
# Identify which variables are contained in the dataframe.
print(str(my_df))

# Transform that dataframe so that each column represents a single variable.


# Question 4
# Create three new variables in the dataframe that contain the information of the day, month and year respectively (keeping the Date column).
library(lubridate)

my_df$Day <- day(my_df$Date)
my_df$Month <- month(my_df$Date)
my_df$Year <- year(my_df$Date)

# Question 5
# Convert the Date column to date type.
my_df$Date <- as.Date(my_df$Date, format = "%d/%m/%Y")

my_df$Day <- format(my_df$Date, "%d")
my_df$Month <- format(my_df$Date, "%m")
my_df$Year <- format(my_df$Date, "%Y")

print(head(my_df))

# Question 6
# Modify column the districts to remove the spaces around the "/".
# Remove the spaces around the "/" in the districts column.

colnames(my_df) <- gsub(" / ", "/", colnames(my_df))
print(colnames(my_df))


# Question 7
# Calculate the percentage of days with missing data for each of the districts.

missing_percentage <- colMeans(is.na(my_df)) * 100
print(missing_percentage)

## print(sum(!complete.cases(my_df[,7])))

# Question 8
# Calculate the total number of cyclists passing through each of the districts over the entire year.

total_cyclists <- colSums(my_df[,2:20], na.rm = TRUE)
print(total_cyclists)

# Question 9
# Which are the five districts with the highest number of cyclists?

top_5 <- sort(total_cyclists, decreasing = TRUE)[1:5]
print(top_5)

# Question 10
# Make a horizontal bar graph where the x-axis represents the total number of cyclists and the y-axis represents the districts.
par(mar = c(5, 10, 1, 3))
# Write all the districts in the y-axis.
barplot(total_cyclists, horiz = TRUE, las = 1, cex.names = 0.6, col = "blue", xlab = "Total number of cyclists")


# Question 11
# Make a line graph with the monthly evolution of cyclists for each district. The graph should show one line per district.
# Create a dataframe with the monthly evolution of cyclists for each district.
monthly_evolution <- aggregate(my_df[,2:20], by = list(my_df$Month), FUN = sum, na.rm = TRUE)
print(monthly_evolution)
par(mar = c(4, 5, 1, 3))
# Plot the monthly evolution of cyclists for each district.
matplot(monthly_evolution[,2:20], type = "l", lty = 1, lwd = 2, col = 1:19, xlab = "Month", ylab = "Number of cyclists", las = 0, main = "Monthly evolution of cyclists for each district")

# Add legend
legend("topleft", legend = colnames(monthly_evolution[,2:20]), col = 1:19, lty = 1, lwd = 2, cex = 0.6)

# Question 12
# Order the bars in the graph of point 10 from highest (top) to lowest (bottom) according to the number of cyclists.
# Order the districts according to the number of cyclists.
sort_total_cyclists <- sort(total_cyclists, decreasing = TRUE)
par(mar = c(5, 9, 1, 2))
barplot(sort_total_cyclists, horiz = TRUE, las = 1, cex.names = 0.6, col = "blue", xlab = "Total number of cyclists in order")

# Question 13
# Add on the graph of Question 11 a blue line, wider than the rest, with the average number of cyclists per month.
# Calculate the average of each rows in monthly_evolution
monthly_evolution$Average <- apply(monthly_evolution[,2:20], 1, mean)
par(mar = c(5, 7, 1, 3))
matplot(monthly_evolution[,2:20], type = "l", lty = 1, lwd = 2, col = 1:19,
        xlab = "Month", ylab = "Number of cyclists", las = 0,
        main = "Monthly evolution of cyclists for each district")
lines(monthly_evolution$Average, lwd = 4, col = "blue")
# Add a legend to the graph with Average label as a blue line
legend("topleft", legend = c(colnames(monthly_evolution[,2:20]), "Average"),
       col = c(1:19, "blue"), lty = 1, lwd = 2, cex = 0.6)
print(monthly_evolution)
print(monthly_evolution$Average)

# Question 14
# Make a bar chart of the number of cyclists for each day of the week in each of the five districts with the most cyclists (using facets).
library(ggplot2)
my_df$Weekday <- weekdays(my_df$Date)

# Create a dataframe by aggregate via weekdays
weekday_df <- aggregate(my_df[,2:20], by = list(my_df$Weekday), FUN = sum, na.rm = TRUE)

# Find most 5 districts with the highest number of cyclists in each day of the week
top_5_weekday <- weekday_df[,c(1, which(names(weekday_df) %in% names(top_5)))]
print(top_5_weekday)

# Melt the data
library(reshape2)
top_5_wday_melt <- melt(top_5_weekday, id.vars = "Group.1")


# Plot data into a single bar plot. Variable column has different districts
# Each district has different color in bar plot
ggplot(data=top_5_wday_melt, aes(x=Group.1, y=value, fill=variable)) + geom_col(position = 'stack')

# Plot data into a single bar plot. Variable column has different districts 
t_top_5_weekday <- t(top_5_weekday[,2:6])
colnames(t_top_5_weekday) <- top_5_weekday[,1]

print(t_top_5_weekday)
barplot(as.matrix(t_top_5_weekday), las = 0, cex.names = 0.7, col = 3:8, xlab = "Day of the week", ylab = "Number of cyclists",
        legend = rownames(t_top_5_weekday), args.legend = list(x = "topright", cex = 0.7, bty = "n"))
# Question 15
# Complete the missing values of the column representing the number of cyclists with the average of the rest of the data for that variable but grouped by district and month.
# Replace missing values of the column with mean() of that column and grouped by district and month
library(dplyr)
my_df[,2:20] <- lapply(my_df[,2:20], function(x) replace(x, is.na(x), mean(x, na.rm = TRUE)))
print(head(my_df))

# Group by district and month
grouped_df <- my_df[,2:22][-20] %>% group_by(Month) %>% summarise_all(mean)
print(grouped_df)


# Question 16
# Read the file localisationcompteursvelo2015.csv. Important: the file encoding is not UTF-8 but ISO-8859-1.
# Read the file localisationcompteursvelo2015.csv
mynew_df <- read.csv("localisationcompteursvelo2015.csv", header = TRUE, sep = ",", fileEncoding = "ISO-8859-1")
print(head(mynew_df,10))

# Question 17
# Make a dot plot of the columns coord X (x-axis) and coord Y (y-axis), with the color of the dots representing the variable Type and the shape the variable Etat.
# Plot the columns coord X (x-axis) and coord Y (y-axis), with the color of the dots representing the variable Type and the shape the variable Etat.

grps_etat <- as.factor(mynew_df$Etat)
grps_type <- as.factor(mynew_df$Type)

my_cols <- c("blue", "darkgreen", "orange")
my_shape <- c(1, 2)

# Plot the dot chart with colors dependent on Type and shapes dependent on Etat
dotchart(mynew_df$coord_X, mynew_df$coord_Y, xlab = "coordX", ylab = "coordY",
         groups = grps_type, gcolor=my_cols, color = my_cols[grps_type],
         xlim = c(min(mynew_df$coord_X), max(mynew_df$coord_X)),
         ylim = c(min(mynew_df$coord_Y), max(mynew_df$coord_Y)),
         gpch = grps_etat, pch = my_shape[grps_etat], cex = 1, lwd = 1,
         main = "Dot chart of coordX and coordY")
legend("topleft", legend = unique(grps_etat), col = my_cols, pch = my_shape, cex = 1)


# Question 18
# Make a join of the two dataframes by the columns with the district names in the first dataframe and
# "nom comptage" in the second one.
df_total_cyclists <- as.data.frame(total_cyclists)
df_total_cyclists$nom_comptage <- rownames(df_total_cyclists)
rownames(df_total_cyclists) <- 1:length(rownames(df_total_cyclists))
colnames(df_total_cyclists)[1] <- "total_cyclists"
print(df_total_cyclists)

newDF <- merge(mynew_df, df_total_cyclists, by="nom_comptage", all.x=TRUE)
print(newDF)

# Question 19
# See which districts of the first dataframe are not found in the second one?
missing_districts <- setdiff(df_total_cyclists$nom_comptage, mynew_df$nom_comptage)
print(missing_districts)

# Question 20
# Dot plot with the size of the dots represents the total number of cyclists that passed through
# that district over the whole year.
# Remove rows if total_cyclists is NA
newDF <- newDF[complete.cases(newDF$total_cyclists),]
print(newDF)
dotchart(newDF$coord_X, newDF$coord_Y, xlab = "coordX", ylab = "coordY",
         xlim = c(min(newDF$coord_X), max(newDF$coord_X)),
         ylim = c(min(newDF$coord_Y), max(newDF$coord_Y)),
         pt.cex = newDF$total_cyclists/(min(newDF$total_cyclists)/0.5),
         lwd = 1, color = "blue",bg = "blue",
         main = "Dot chart of coordX and coordY")
