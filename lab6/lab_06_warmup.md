---
title: "lab_06_warmup"
output: 
  html_document: 
    keep_md: true
date: "2024-01-30"
---



### Lab 06 Warmup
#### Load any required packages

```r
library("tidyverse")
```

```
## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
## ✔ dplyr     1.1.3     ✔ readr     2.1.4
## ✔ forcats   1.0.0     ✔ stringr   1.5.0
## ✔ ggplot2   3.4.3     ✔ tibble    3.2.1
## ✔ lubridate 1.9.2     ✔ tidyr     1.3.0
## ✔ purrr     1.0.2     
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```
#### 1 Load the 'bison.csv' data.

```r
bison <- read_csv("data/bison.csv")
```

```
## Rows: 8325 Columns: 8
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (3): data_code, animal_code, animal_sex
## dbl (5): rec_year, rec_month, rec_day, animal_weight, animal_yob
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

#### 2 What are the dimesions and structure of the data?

```r
dim(bison)
```

```
## [1] 8325    8
```

```r
str(bison)
```

```
## spc_tbl_ [8,325 × 8] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
##  $ data_code    : chr [1:8325] "CBH01" "CBH01" "CBH01" "CBH01" ...
##  $ rec_year     : num [1:8325] 1994 1994 1994 1994 1994 ...
##  $ rec_month    : num [1:8325] 11 11 11 11 11 11 11 11 11 11 ...
##  $ rec_day      : num [1:8325] 8 8 8 8 8 8 8 8 8 8 ...
##  $ animal_code  : chr [1:8325] "813" "834" "B-301" "B-402" ...
##  $ animal_sex   : chr [1:8325] "F" "F" "F" "F" ...
##  $ animal_weight: num [1:8325] 890 1074 1060 989 1062 ...
##  $ animal_yob   : num [1:8325] 1981 1983 1983 1984 1984 ...
##  - attr(*, "spec")=
##   .. cols(
##   ..   data_code = col_character(),
##   ..   rec_year = col_double(),
##   ..   rec_month = col_double(),
##   ..   rec_day = col_double(),
##   ..   animal_code = col_character(),
##   ..   animal_sex = col_character(),
##   ..   animal_weight = col_double(),
##   ..   animal_yob = col_double()
##   .. )
##  - attr(*, "problems")=<externalptr>
```

#### 3 We are only interested in code, sex, weight, year of birth. Restrict the data to these variables and store the dataframe as a new object.


```r
bison_subset <- select(bison, "data_code", "animal_code", "animal_sex", "animal_weight", "animal_yob")
```


#### 4 Pull out the animals born between 1980-1990.

```r
bison_1980_to_1990 <- filter(bison_subset, between(animal_yob, 1980, 1990))
```

#### 5 How many male and female bison are represented between 1980-1990?

```r
table(bison_1980_to_1990$animal_sex)
```

```
## 
##   F   M 
## 414  21
```

#### 6 Between 1980-1990, were males or females larger on average? Males

```r
males <- filter(bison_1980_to_1990, animal_sex=="M")
  mean(males$animal_weight, na.rm = T)
```

```
## [1] 1543.333
```

```r
females <- filter(bison_1980_to_1990, animal_sex=="F")
  mean(females$animal_weight, na.rm = T)
```

```
## [1] 1017.314
```

