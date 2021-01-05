#----------------------------------------------------------
# ggplot -  Introduction to Graphical Visualization 
#----------------------------------------------------------
#
# 1. Basic Structure and syntax in ggplot2
# 2. Exploration in data structure (dimentsion and variables properties)
#    - Continous vs Discrete ? 
# 3. Aesthetics definition 
# 4. Primitive Plots (Horiontal line vs Vertical line)
# 5. One Varible plot (geom_histogram,geom_bar)
#    5.1 Two varible plot (text, point, jitter, box etc)
# 6. Cases study on Covid19 Data
#

library(ggplot2)

data <- mtcars
#Henderson and Velleman (1981), Building multiple regression models interactively. Biometrics, 37, 391â411.

dim(data)
#32 11

str(data)
#[, 1]	mpg	Miles/(US) gallon
#[, 2]	cyl	Number of cylinders
#[, 3]	disp	Displacement (cu.in.)
#[, 4]	hp	Gross horsepower
#[, 5]	drat	Rear axle ratio
#[, 6]	wt	Weight (1000 lbs)
#[, 7]	qsec	1/4 mile time
#[, 8]	vs	Engine (0 = V-shaped, 1 = straight)
#[, 9]	am	Transmission (0 = automatic, 1 = manual)
#[,10]	gear	Number of forward gears
#[,11]	carb	Number of carburetors

#How ggplot works 
# 1. Define data 
# 2. Define aesthetic aes() 
# 3. Define variables, x= ; y =

############################################################### 
a <- ggplot(data, aes(x=gear,y=mpg)) 
a <- a + geom_blank() + ylim(0,35) + xlim(0,5)
a <- a + geom_hline(yintercept = 25)
a <- a + geom_vline(xintercept = 4)
a <- a + geom_abline(intercept=10,slope=5)
a 

#----------------------------------------------------------
# One Variable
#----------------------------------------------------------
mpg <- mpg 

dim(mpg)
#234 11

str(mpg)
#http://archive.ics.uci.edu/ml/datasets/Auto+MPG
#tibble [234 x 11] (S3: tbl_df/tbl/data.frame)
#$ manufacturer: chr [1:234] "audi" "audi" "audi" "audi" ...
#$ model       : chr [1:234] "a4" "a4" "a4" "a4" ...
#$ displ       : num [1:234] 1.8 1.8 2 2 2.8 2.8 3.1 1.8 1.8 2 ...
#$ year        : int [1:234] 1999 1999 2008 2008 1999 1999 2008 1999 1999 2008 ...
#$ cyl         : int [1:234] 4 4 4 4 6 6 6 4 4 4 ...
#$ trans       : chr [1:234] "auto(l5)" "manual(m5)" "manual(m6)" "auto(av)" ...
#$ drv         : chr [1:234] "f" "f" "f" "f" ...
#$ cty         : int [1:234] 18 21 20 21 16 18 18 18 16 20 ...
#$ hwy         : int [1:234] 29 29 31 30 26 26 27 26 25 28 ...
#$ fl          : chr [1:234] "p" "p" "p" "p" ...
#$ class       : chr [1:234] "compact" "compact" "compact" "compact" ...

#One Discreate Parameters
b <- ggplot(mpg, aes(fl))
b <- b + geom_bar() 
b

#One Continous Parameters
c <- ggplot(mpg, aes(cyl))
c <- c +  geom_histogram()
c

d <- ggplot(mpg, aes(cty))
d <- d +  geom_histogram()
d

#----------------------------------------------------------
# Two Variables
#----------------------------------------------------------

#continuous x , continuous y 
e <- ggplot(mpg, aes(cty, hwy))

e + geom_point()
e + geom_jitter() 

e + geom_label(aes(label = cty)) 
e + geom_label(aes(label = hwy)) 

e + geom_text(aes(label = cty))

#discrete x , continuous y
f <- ggplot(mpg, aes(class, hwy))

f + geom_boxplot()

f + geom_violin(scale = "area")

#discrete x , discrete y 
g <- ggplot(mpg, aes(class, drv))
g + geom_count()

#----------------------------------------------------------
# Two Variables (x and y), more variebles as gropuing
#----------------------------------------------------------

e <- ggplot(mpg, aes(cty, hwy))
e + geom_text(aes(label = cty))
e + geom_text(aes(label = cty,colour = factor(manufacturer)))  

e + geom_point(aes(colour = factor(cyl)))
e + geom_point(aes(colour = factor(manufacturer)))
e + geom_point(aes(colour = factor(manufacturer),shape = factor(cyl)))
e + geom_jitter(aes(colour = factor(manufacturer), shape = factor(cyl), size = displ))

#----------------------------------------------------------
# Practical Data Plotting - Covid 19
#----------------------------------------------------------
#https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide
library(readxl)
COVID_19 <- read_excel("C:/Users/Brandon_yeo/Desktop/COVID-19-geographic-disbtribution-worldwide-2020-04-19.xlsx")

#1. Comparison between different countries, using a line plot (x = time, y=number of cases in log10). 
#2. Total new cases in the world in a stack column plot, with each country as its own color (x = MOnth, y = number of cases in log10)

dim(COVID_19)
#11768    10

str(COVID_19)
#tibble [11,768 x 10] (S3: tbl_df/tbl/data.frame)
#$ dateRep                : POSIXct[1:11768], format: "2020-04-19" "2020-04-18" "2020-04-17" "2020-04-16" ...
#$ day                    : num [1:11768] 19 18 17 16 15 14 13 12 11 10 ...
#$ month                  : num [1:11768] 4 4 4 4 4 4 4 4 4 4 ...
#$ year                   : num [1:11768] 2020 2020 2020 2020 2020 2020 2020 2020 2020 2020 ...
#$ cases                  : num [1:11768] 63 51 10 70 49 58 52 34 37 61 ...
#$ deaths                 : num [1:11768] 0 1 4 2 2 3 0 3 0 1 ...
#$ countriesAndTerritories: chr [1:11768] "Afghanistan" "Afghanistan" "Afghanistan" "Afghanistan" ...
#$ geoId                  : chr [1:11768] "AF" "AF" "AF" "AF" ...
#$ countryterritoryCode   : chr [1:11768] "AFG" "AFG" "AFG" "AFG" ...
#$ popData2018            : num [1:11768] 37172386 37172386 37172386 37172386 37172386 ...
#########################################################################################################
library(dplyr)
Totalcases_in_All_Countries <- COVID_19 %>% group_by(countriesAndTerritories) %>% summarise(Cases = sum(cases))

#########################################################################################################
#1. Comparison between different countries, using a line plot (x = time, y=number of cases in log10). 

cv <- ggplot(COVID_19, aes(x = dateRep, y= cases)) 
cv + geom_line()

cv + geom_line() + scale_y_log10()


#2. Total cases in the world in a stack column plot, with each country as its own color (x = MOnth, y = number of cases in log10)
cv + geom_col(aes(color=countryterritoryCode)) 

cv + geom_col(aes(color=countryterritoryCode))  +  theme(legend.position = "none")

cv + geom_col(aes(color=countryterritoryCode)) + scale_y_log10() +  theme(legend.position = "none")

COVID_19s <-  COVID_19 %>% group_by(countryterritoryCode) %>% filter(sum(cases)>30000)

cv2 <- ggplot(COVID_19s, aes(x = dateRep, y= cases)) 
cv2 + geom_col(aes(fill=countryterritoryCode)) 
cv2 + geom_col(aes(fill=countryterritoryCode)) + scale_y_log10()


