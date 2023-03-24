#Wrangle that data in R (intro to R 2)
#Mike Jadoo
#Stats seminars DC meetup



#Slide 1-4

# for(varname in seq){
#   statement(s)
#  }


#vectors
for (i in 1:8){
  print(i)
}

#math operation

for (i in 1:10) {
  print(i^3)
}

#using strings

birds <- c('robin', 'woodpecker', 'blue jay', 'sparrow')

for (i in 1:length(birds)){
  print(birds[i])
}



volumes = c(1.6, 3, 8)
for (volume in volumes){
  print(2.65 * volume^0.9)
}




#for loops and dataframes

df <- data.frame(x1 = 1:5,    # Create example data
                 x2 = 6:10,
                 x3 = 11:15)
df            # Print example data

for(i in 1:ncol(df)) {       # for-loop over columns
  df[ , i] <- df[ , i] + 10
}
df     

df <- data.frame(x1 = 1:5,    # Create example data
                 x2 = 6:10,
                 x3 = 11:15)

for(i in 1:nrow(df)) {       # for-loop over rows
  df[i, ] <- df[i, ] - 100
}

df

#slide 5

#nested for loops

num_vector <- c(1,2,3)
alpha_vector <- c('a', 'b', 'c')

for (num in num_vector) { # outer loop 
  print(num)
  for (letter in alpha_vector){ # inner loop
    print(letter)
}
}

#slide 7-9

#While loops
#Create a variable with value 1
begin <- 1

#Create the loop
while (begin <= 10){
  
  #See which we are  
  cat('This is loop number',begin)
  
  #add 1 to the variable begin after each loop
  begin <- begin+1
  print(begin)
}

#with dataframe

value <- c(19,60,82,72,26)
group <- c('A','B','C','D','E')
df<-data.frame(group,value)

cnt <- 1
growth<-.06
while (cnt <= length(df)){
  
  df$new_value<-df$value*(1+growth)
  cnt <- cnt + 1
  print(cnt)
}

df

#more while loops and dataframes

data <- data.frame(x1 = 1:5,    # Create example data
                   x2 = 6:10,
                   x3 = 11:15)
data
i <- 1 

while(i <=2) {                  # Start while-loop
  data[ , i] <- data[ , i] + 100
  i <- i + 1
}

data

#slide 10-15


#apply()
value2 <- c(19,60,82,72,26)
value1 <- c(20,30,40,50,60)
df<-data.frame(value1, value2)

apply(df,2,sum)


#sapply()
## DUPLICATE ##
# value2 <- c(19,60,82,72,26)
# value1 <- c(20,30,40,50,60)
# df<-data.frame(value1, value2)

sapply(df,sum)

#using max
wf<-sapply(df,max)
wf

lapply(df,max)


#slide 17-19
#conditonal statements

x <- 0
if(x > 0){
  print("Positive number")
}

x <- 5
if(x > 0){
  print("Positive number")
} else {
  print("Negative number")
}

#working with data frames
data <- read.table(header=TRUE, text='
YEAR	     DATA
2000  	      45
2001  	      55
2002  	      53
2003	      54
2004	      49
2005	      55
2006	      65
2007	      54
2008	      49
2009	      53
2010	      58
2011	      55
2012	      59
')

data$x4 <- ifelse(data$DATA<50,1,0)

data

#good example
x <- data.frame("Student" = c("Ron","Jake","Ava","Sophia","Mia"),
                "Marks" = c(35,75,45,30,85)) ## MOVED for readability ##
str(x)
head(x)
x$Result <- ifelse(x$Marks>40,"Pass","Fail")
print(x)


matches <- list(c(2,3),c(5,2),c(6,3))
head(matches)

for (match in matches){
  if (match[1] > match[2]){
    print("Win")
    
  } else {
    print("Lose")
  }
}


#Tydiverse

#tidyverse

#dplyr

#mutate() adds new variables that are functions of existing variables

library(dplyr)


head(mtcars)

mutate(mtcars,
       cyl2 = cyl * 2,
       cyl4 = cyl2 * 2
)

#%>%   PIPE operator
  
  mtcars%>%mutate( cyl2 = cyl * 2,
                   cyl4 = cyl2 * 2
  )


#select() picks variables based on their names.

  mtcars %>%dplyr::select(mpg, disp)

#when using  dplyr::
#Error in select(., mpg, disp) : unused arguments (mpg, disp)

#filter() picks cases based on their values.

  dplyr::filter(starwars, species == "Human")




#summarise() reduces multiple values down to a single summary.

# A summary applied to ungrouped tbl returns a single row

  mtcars %>%
  summarise(mean = mean(disp), n = n())


# Usually, you'll want to group first
mtcars %>%
  group_by(cyl) %>%
  summarise(mean = mean(disp), n = n())



#arrange() changes the ordering of the rows.
arrange(mtcars, mpg,cyl)





#tidyr

#gather()
# transposes based on key variables inside the gather function



library(tidyr)

head(mtcars)

head(gather(mtcars, mpg, cyl))

pivot_longer(  )

#library(dplyr)
#library(tidyr)
billboard %>%
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    names_prefix = "wk",
    values_to = "rank",
    values_drop_na = TRUE
  )

#https://tidyr.tidyverse.org/reference/index.html

#pivot_wider( )

fish_encounters

fish_encounters %>%
  pivot_wider(names_from = station, values_from = seen)

#spread()

stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks
stocks %>% spread(year, return)



separate()

tibble(x = c("a,b,c", "d,e,j", "f,g,i")) %>% 
   separate(x, c("one", "two", "three"))


#unite()
mtcars
unite(mtcars, "vsam", c("vs","am"))




#tibble

library(tibble)
head(iris)

z<-as_tibble(iris)

z
tibble(x = 1:5, y = 1, z = x ^ 2 + y)


#create data row by row use tribble


tribble(
  ~x, ~y,  ~z,
  "a", 2,  3.6,
  "b", 1,  8.5
)



#slide 28-
#Combining tables

#combining tables
#using cbind() 

x<-runif(3,1,10)
y<-runif(3,1,10)

df<-data.frame(cbind(x,y))

df

# join two data frames (datasets) vertically- appending


x<-runif(3,1,10)
y<-runif(3,1,10)

df<-data.frame(cbind(x,y))

#create new data
z<-c(1,2)

z

#append using rbind()

total<-rbind(df,z)

#merge tables
buildings <- data.frame(location=c(1, 2, 3),## MOVED for readability ##
                        name=c("building1", "building2", "building3"))

data <- data.frame(survey=c(1,1,1,2,2,2), location=c(1,2,3,2,3,1),
                   efficiency=c(51,64,70,71,80,58))

buildingStats <- merge(buildings, data, by="location")

head(buildingStats)

#joins

#natural join (inner join):

# Create the dataframes to merge:
buildings <- data.frame(location=c(1, 2, 3),## MOVED for readability ##
                        name=c("building1", "building2", "building3"))

data <- data.frame(survey=c(1,1,1,2,2,2,1), location=c(1,2,3,2,3,1,7),
                   efficiency=c(51,64,70,71,80,58,35))

# Solution
inner <- merge(buildings, data)
inner

#full outer join:

outer <- merge(buildings, data, by="location", all=TRUE)

outer
#left outer join:

left <- merge(buildings, data, by="location", all.x=TRUE)

left

#right outer join:
right <- merge(buildings, data, by="location", all.y=TRUE)

right

#SQL

install.packages(c("sqldf","PASWR"))

library(sqldf)

library(PASWR)
library(readxl)

# import data
#set the working directory to where you have your work
#or have your files saved. 

setwd("F:/YOUR DIRECTORY/")
df<-read_excel("mydata.xlsx",sheet ="sheet1")

head(df)
# run sql query collect everything from datatable

TitanicData <- sqldf("select * from df")

head(TitanicData)
#collect only certain variables

TitanicSubset2Cols <- sqldf("select pclass,survived from df")

head(TitanicSubset2Cols)

library(dplyr)
#joins

band_members %>% inner_join(band_instruments, by = "name")


# Use a named `by` if the join variables have different names
band_members %>% full_join(band_instruments2, by = c("name" = "artist"))


band_members %>% inner_join(band_instruments, by = "name")

band_members %>% left_join(band_instruments, by = "name")

band_members %>% right_join(band_instruments, by = "name")

band_members %>% full_join(band_instruments, by = "name")




#missing values
#count missing
#In a vector


vec <- c(3, 1, NA, 3, NA, NA, 4)
vec

sum(is.na(vec))


sum(vec,na.rm=TRUE)


data <- data.frame(x1 = c(NA, 5, 5, NA, 1, 2),
                   x2 = c(1, 2, 3, NA, 5, 6),
                   x3 = 1)
data

colSums(is.na(data))
# x1 x2 x3 
#  2  1  0

sum(is.na(data$x1))
# 2

# some functions will have an option to use na.rm. na.rm =  remove na from data set
x <- c(1, 2, NA, 4)   

mean(x, na.rm = TRUE)

na.omit(x)

x
#remove NA's from the matrix and get count of NA's in vector


library(rgr)
a<-remove.na(x)

library(timeSeries)

c<-removeNA(x)
c

library(dplyr)
df <- tibble(x = c(1, 2, NA), y = c("a", NA, "b"))

df %>% drop_na()

## R

data <- read.table(header=TRUE, text='
YEAR	     DATA
2000  	      45
2001  	      55
2002  	      53
2003	      54
2004	      49
2005	      NA
2006	      65
2007	      54
2008	      49
2009	      53
2010	      58
2011	      NA
2012	      59
')

#https://tidyr.tidyverse.org/reference/fill.html
# `fill()` defaults to replacing missing data from top to bottom

data %>% fill(DATA)

#Here are some options using the timeSeries package:
  
  library(timeSeries)
## Subsitute NA's with Zeros or the column mean or median 
substituteNA(data, type = "zeros")
substituteNA(data, type = "mean")
substituteNA(data, type = "median")

library(Hmisc)
impute(data$DATA, mean)  # replace with mean
impute(data$DATA, median)  # median
impute(data$DATA, 20)  # replace specific 

#permenent replacement

data$DATA<-with(data, impute(data$DATA, mean))


#interprelate in R

## conduct a linear interpolation NA's values
data <- read.table(header=TRUE, text='
YEAR	     DATA
2000  	      45
2001  	      55
2002  	      53
2003	      54
2004	      49
2005	      NA
2006	      65
2007	      54
2008	      49
2009	      53
2010	      58
2011	      NA
2012	      59
')

library(timeSeries)
interpNA(data, method = "linear")

library(imputeTS)
na_interpolation(data, option = "linear")
#na.interpolation(data, option = "splin")


##Replace  value number  in R

data <- read.table(header=TRUE, text='
YEAR	     DATA
2000  	      45
2001  	      55
2002  	      53
2003	      54
2004	      49
2005	    -99999
2006	      65
2007	      54
2008	      49
2009	      53
2010	      58
2011	     -99999
2012	      59
')

data$DATA[data$DATA==-99999] <- 50
