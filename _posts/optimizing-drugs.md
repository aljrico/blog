------------------------------------------------------------------------

layout: post title: Optimizing drugs distribution in a developing
country categories: - blog output: md\_document: variant:
markdown\_github

In this post I will try exemplify how **Data Science** can be of great
help when trying to address real-world problems. Today we'll optimize
drugs distribution of some uknown place, just looking at the raw data
provided by the medical services in place.

Even though we are not trying to usurpe the role of Physicians in their
field, we'll try to show how useful can be the application of Data
Science techniques in order to *cooperate* with Medical Services.
Especially in scenarios of scarcity or emergency, where medical
specialists are having a hard time dealing with huge loads of people in
need of their help. In this extreme situations, decision-making
processes are more critical than ever.

Getting the Data
================

First of all, let's grab all data we can put our hands on. For the sake
of the example, I came with three different .csv files with medical
records and patients information. Disorganized, untidy, messy and
imperfect. As it always is.

    library(data.table)
    library(tidyverse)

    sit <- as_tibble(fread('dataset1.csv'))
    dem <- as_tibble(fread('dataset2.csv'))
    con <- as_tibble(fread('dataset3.csv'))

    sit

    ## # A tibble: 33,019 x 6
    ##    ID_Patient_Care_Situat… Diagnosed_Conditi… ID_Patient Treated_with_dru…
    ##                      <int>              <int>      <int> <chr>            
    ##  1                       1                  1       5327 DX6              
    ##  2                       2                 32      12157 DX2 DX3          
    ##  3                       3                  3       9024 DX2              
    ##  4                       4                 50       7574 DX6              
    ##  5                       5                 20      10218 DX2              
    ##  6                       6                 50      11470 DX1              
    ##  7                       7                 34       6976 DX6              
    ##  8                       8                 41      12030 DX2              
    ##  9                       9                  6       6767 DX2 DX5          
    ## 10                      10                 50      10571 DX2              
    ## # ... with 33,009 more rows, and 2 more variables: Survived_1_year <chr>,
    ## #   `Train/ Test/ Score` <chr>

    dem

    ## # A tibble: 12,500 x 5
    ##    Patient_ID Patient_Age Patient_Body_Ma… Patient_Smoker Patient_Rural_U…
    ##         <int>       <int>            <dbl> <chr>          <chr>           
    ##  1          1          30             25.9 NO             RURAL           
    ##  2          2          39             29.9 NO             RURAL           
    ##  3          3          19             25.2 YES            RURAL           
    ##  4          4          30             26.2 YES            RURAL           
    ##  5          5          31             17.1 NO             RURAL           
    ##  6          6          12             19.8 NO             URBAN           
    ##  7          7           4             18.3 NO             RURAL           
    ##  8          8          40             19.7 YES            RURAL           
    ##  9          9          58             21.3 YES            URBAN           
    ## 10         10          53             17.3 YES            URBAN           
    ## # ... with 12,490 more rows

    con

    ## # A tibble: 20,775 x 2
    ##    Patient_ID Previous_Condition
    ##         <int> <chr>             
    ##  1       9728 D                 
    ##  2       3527 A                 
    ##  3       7260 A                 
    ##  4      10200 B                 
    ##  5       1244 C                 
    ##  6       6179 A                 
    ##  7       1928 E                 
    ##  8       6000 A                 
    ##  9      12186 E                 
    ## 10       8361 E                 
    ## # ... with 20,765 more rows

    glimpse(sit)

    ## Observations: 33,019
    ## Variables: 6
    ## $ ID_Patient_Care_Situation <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 1...
    ## $ Diagnosed_Condition       <int> 1, 32, 3, 50, 20, 50, 34, 41, 6, 50,...
    ## $ ID_Patient                <int> 5327, 12157, 9024, 7574, 10218, 1147...
    ## $ Treated_with_drugs        <chr> "DX6", "DX2 DX3", "DX2", "DX6", "DX2...
    ## $ Survived_1_year           <chr> "1", "0", "1", "1", "0", "1", "0", "...
    ## $ `Train/ Test/ Score`      <chr> "Train", "Train", "Train", "Train", ...

    glimpse(dem)

    ## Observations: 12,500
    ## Variables: 5
    ## $ Patient_ID              <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,...
    ## $ Patient_Age             <int> 30, 39, 19, 30, 31, 12, 4, 40, 58, 53,...
    ## $ Patient_Body_Mass_Index <dbl> 25.9, 29.9, 25.2, 26.2, 17.1, 19.8, 18...
    ## $ Patient_Smoker          <chr> "NO", "NO", "YES", "YES", "NO", "NO", ...
    ## $ Patient_Rural_Urban     <chr> "RURAL", "RURAL", "RURAL", "RURAL", "R...

    glimpse(con)

    ## Observations: 20,775
    ## Variables: 2
    ## $ Patient_ID         <int> 9728, 3527, 7260, 10200, 1244, 6179, 1928, ...
    ## $ Previous_Condition <chr> "D", "A", "A", "B", "C", "A", "E", "A", "E"...

First of all, we will start putting some order in this datasets.

All three files the same variable in common, which is the *Patient ID*.
But, weirdly enough, it is named differently in one of the files. Let's
fix that:

    colnames(sit)[3] <- "Patient_ID"
    sit

    ## # A tibble: 33,019 x 6
    ##    ID_Patient_Care_Situat… Diagnosed_Conditi… Patient_ID Treated_with_dru…
    ##                      <int>              <int>      <int> <chr>            
    ##  1                       1                  1       5327 DX6              
    ##  2                       2                 32      12157 DX2 DX3          
    ##  3                       3                  3       9024 DX2              
    ##  4                       4                 50       7574 DX6              
    ##  5                       5                 20      10218 DX2              
    ##  6                       6                 50      11470 DX1              
    ##  7                       7                 34       6976 DX6              
    ##  8                       8                 41      12030 DX2              
    ##  9                       9                  6       6767 DX2 DX5          
    ## 10                      10                 50      10571 DX2              
    ## # ... with 33,009 more rows, and 2 more variables: Survived_1_year <chr>,
    ## #   `Train/ Test/ Score` <chr>
