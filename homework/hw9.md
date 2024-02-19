---
title: "Homework 9"
author: "Jaskaran Halait"
date: "2024-02-18"
output:
  html_document: 
    theme: spacelab
    keep_md: true
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
library(here)
library(naniar)
```

For this homework, we will take a departure from biological data and use data about California colleges. These data are a subset of the national college scorecard (https://collegescorecard.ed.gov/data/). Load the `ca_college_data.csv` as a new object called `colleges`.

```r
colleges <- read_csv("../lab10/data/ca_college_data.csv") %>% clean_names()
```

```
## Rows: 341 Columns: 10
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (4): INSTNM, CITY, STABBR, ZIP
## dbl (6): ADM_RATE, SAT_AVG, PCIP26, COSTT4_A, C150_4_POOLED, PFTFTUG1_EF
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

The variables are a bit hard to decipher, here is a key:  

INSTNM: Institution name  
CITY: California city  
STABBR: Location state  
ZIP: Zip code  
ADM_RATE: Admission rate  
SAT_AVG: SAT average score  
PCIP26: Percentage of degrees awarded in Biological And Biomedical Sciences  
COSTT4_A: Annual cost of attendance  
C150_4_POOLED: 4-year completion rate  
PFTFTUG1_EF: Percentage of undergraduate students who are first-time, full-time degree/certificate-seeking undergraduate students  

1. Use your preferred function(s) to have a look at the data and get an idea of its structure. Make sure you summarize NA's and determine whether or not the data are tidy. You may also consider dealing with any naming issues.


```r
summary(colleges)
```

```
##     instnm              city              stabbr              zip           
##  Length:341         Length:341         Length:341         Length:341        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##     adm_rate         sat_avg         pcip26           costt4_a    
##  Min.   :0.0807   Min.   : 870   Min.   :0.00000   Min.   : 7956  
##  1st Qu.:0.4581   1st Qu.: 985   1st Qu.:0.00000   1st Qu.:12578  
##  Median :0.6370   Median :1078   Median :0.00000   Median :16591  
##  Mean   :0.5901   Mean   :1112   Mean   :0.01981   Mean   :26685  
##  3rd Qu.:0.7461   3rd Qu.:1237   3rd Qu.:0.02457   3rd Qu.:39289  
##  Max.   :1.0000   Max.   :1555   Max.   :0.21650   Max.   :69355  
##  NA's   :240      NA's   :276    NA's   :35        NA's   :124    
##  c150_4_pooled     pftftug1_ef    
##  Min.   :0.0625   Min.   :0.0064  
##  1st Qu.:0.4265   1st Qu.:0.3212  
##  Median :0.5845   Median :0.5016  
##  Mean   :0.5705   Mean   :0.5577  
##  3rd Qu.:0.7162   3rd Qu.:0.8117  
##  Max.   :0.9569   Max.   :1.0000  
##  NA's   :221      NA's   :53
```


```r
miss_var_summary(colleges)
```

```
## # A tibble: 10 × 3
##    variable      n_miss pct_miss
##    <chr>          <int>    <dbl>
##  1 sat_avg          276     80.9
##  2 adm_rate         240     70.4
##  3 c150_4_pooled    221     64.8
##  4 costt4_a         124     36.4
##  5 pftftug1_ef       53     15.5
##  6 pcip26            35     10.3
##  7 instnm             0      0  
##  8 city               0      0  
##  9 stabbr             0      0  
## 10 zip                0      0
```

The data appears quite tidy, as all variables correspond to a single column, and missing values are appropriately labeled as "NA".

2. Which cities in California have the highest number of colleges?


```r
colleges %>%
  group_by(city) %>%
  summarize(n_colleges = n()) %>%
  arrange(desc(n_colleges))
```

```
## # A tibble: 161 × 2
##    city          n_colleges
##    <chr>              <int>
##  1 Los Angeles           24
##  2 San Diego             18
##  3 San Francisco         15
##  4 Sacramento            10
##  5 Berkeley               9
##  6 Oakland                9
##  7 Claremont              7
##  8 Pasadena               6
##  9 Fresno                 5
## 10 Irvine                 5
## # ℹ 151 more rows
```


3. Based on your answer to #2, make a plot that shows the number of colleges in the top 10 cities.


```r
colleges %>%
  group_by(city) %>%
  summarize(n_colleges = n()) %>%
  top_n(10, n_colleges) %>%
  ggplot(mapping=aes(x=city, y=n_colleges))+
  geom_col()+
  coord_flip()
```

![](hw9_files/figure-html/unnamed-chunk-6-1.png)<!-- -->


4. The column `COSTT4_A` is the annual cost of each institution. Which city has the highest average cost? Where is it located?


```r
colleges %>%
  group_by(city) %>%
  summarize(mean_yearly_tuition = mean(costt4_a, na.rm = T)) %>%
  arrange(desc(mean_yearly_tuition))
```

```
## # A tibble: 161 × 2
##    city                mean_yearly_tuition
##    <chr>                             <dbl>
##  1 Claremont                         66498
##  2 Malibu                            66152
##  3 Valencia                          64686
##  4 Orange                            64501
##  5 Redlands                          61542
##  6 Moraga                            61095
##  7 Atherton                          56035
##  8 Thousand Oaks                     54373
##  9 Rancho Palos Verdes               50758
## 10 La Verne                          50603
## # ℹ 151 more rows
```

5. Based on your answer to #4, make a plot that compares the cost of the individual colleges in the most expensive city. Bonus! Add UC Davis here to see how it compares :>).


```r
colleges %>%
  filter(city=="Claremont" | instnm=="University of California-Davis") %>%
  ggplot(mapping=aes(x=instnm, y=costt4_a))+
  geom_col()+
  coord_flip()
```

```
## Warning: Removed 2 rows containing missing values (`position_stack()`).
```

![](hw9_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

6. The column `ADM_RATE` is the admissions rate by college and `C150_4_POOLED` is the four-year completion rate. Use a scatterplot to show the relationship between these two variables. What do you think this means?


```r
colleges %>%
  ggplot(mapping=aes(x=adm_rate, y=c150_4_pooled))+
  geom_point()
```

```
## Warning: Removed 251 rows containing missing values (`geom_point()`).
```

![](hw9_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

It appears that, on average, schools with lower admissions rates tend to have a higher four-year degree completion rates.

7. Is there a relationship between cost and four-year completion rate? (You don't need to do the stats, just produce a plot). What do you think this means?


```r
colleges %>%
  ggplot(mapping=aes(x=costt4_a, y=c150_4_pooled))+
  geom_point()
```

```
## Warning: Removed 225 rows containing missing values (`geom_point()`).
```

![](hw9_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

Yes, these variables appear to be postively correlated but not strongly.

8. The column titled `INSTNM` is the institution name. We are only interested in the University of California colleges. Make a new data frame that is restricted to UC institutions. You can remove `Hastings College of Law` and `UC San Francisco` as we are only interested in undergraduate institutions.


```r
uc_ug_only <- colleges %>%
  filter(instnm %in% c("University of California-San Diego", 
                       "University of California-Irvine",
                       "University of California-Riverside",
                       "University of California-Los Angeles",
                       "University of California-Davis",
                       "University of California-Santa Cruz",
                       "University of California-Berkeley",
                       "University of California-Santa Barbara")) %>%
  separate(instnm, into=c("univ", "campus"), sep = "-")
```


Remove `Hastings College of Law` and `UC San Francisco` and store the final data frame as a new object `univ_calif_final`.

Use `separate()` to separate institution name into two new columns "UNIV" and "CAMPUS".

9. The column `ADM_RATE` is the admissions rate by campus. Which UC has the lowest and highest admissions rates? Produce a numerical summary and an appropriate plot.


```r
uc_ug_only %>%
  select(campus, adm_rate) %>%
  arrange(desc(adm_rate))
```

```
## # A tibble: 8 × 2
##   campus        adm_rate
##   <chr>            <dbl>
## 1 Riverside        0.663
## 2 Santa Cruz       0.578
## 3 Davis            0.423
## 4 Irvine           0.406
## 5 Santa Barbara    0.358
## 6 San Diego        0.357
## 7 Los Angeles      0.180
## 8 Berkeley         0.169
```



```r
uc_ug_only %>%
  select(campus, adm_rate) %>%
  ggplot(mapping = aes(x=campus, y=adm_rate))+
  geom_col()+
  coord_flip()
```

![](hw9_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

10. If you wanted to get a degree in biological or biomedical sciences, which campus confers the majority of these degrees? Produce a numerical summary and an appropriate plot.


```r
uc_ug_only %>%
  select(campus, pcip26) %>%
  arrange(desc(pcip26))
```

```
## # A tibble: 8 × 2
##   campus        pcip26
##   <chr>          <dbl>
## 1 San Diego      0.216
## 2 Davis          0.198
## 3 Santa Cruz     0.193
## 4 Los Angeles    0.155
## 5 Riverside      0.149
## 6 Santa Barbara  0.108
## 7 Irvine         0.107
## 8 Berkeley       0.105
```


```r
uc_ug_only %>%
  select(campus, pcip26) %>%
  ggplot(mapping = aes(x=campus, y=pcip26))+
  geom_col()+
  coord_flip()
```

![](hw9_files/figure-html/unnamed-chunk-15-1.png)<!-- -->

## Knit Your Output and Post to [GitHub](https://github.com/FRS417-DataScienceBiologists)
