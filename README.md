# Setup
1. Make sure you have git installed (Learn how to do that [here](https://github.com/git-guides/install-git)).
2. Clone the repository (Learn how to do that [here](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)).
3. Install [R Studio](https://www.rstudio.com/products/rstudio/download/)
4. Open R Studio
5. Install the packages we used(Learn how to do that [here](https://support.rstudio.com/hc/en-us/articles/201057987-Quick-list-of-useful-R-packages)):
  1. shiny
  2. shinydashboard
  3. dashboardthemes
  4. ggplot2
  5. ggthemes
  6. rlang
  7. readr
  8. tidyverse
  9. RColorBrewer
  10. plotly
  11. shinyalert

# How to Generate the Merged Data CSV (HMSAll.csv)
If you already have the HMSAll.csv, then just move the file to the parent directory of the repository folder (directions below)

1. Move the original HMS data CSVs (HMS17.csv, HMS18.csv, HMS19.csv, HMS20_better.csv) to the parent directory of the cloned repository (eg. if you clone the folder in ~/Documents/Project, then put the four years of HMS CSVs in ~/Documents/Project. Cloning the repo should result in another folder within the Project folder called wellbeing, ~/Documents/Project/wellbeing).
2. Open R Studio
3. Set your working directory to the Dashboard folder within the repository folder (eg. ~/Documents/Project/wellbeing/Dashboard). Learn how to change your working directory [here](https://support.rstudio.com/hc/en-us/articles/200711843-Working-Directories-and-Workspaces-in-the-RStudio-IDE).
4. Open the merged.R file
5. Run the whole merged.R file (this can be done on Mac by using command + r or by selecting all of the code with command + a or ctrl + a then using command + enter or ctrl + enter).
6. You should now have a file called HMSAll.csv in the parent directory of the repsitory folder (~/Documents/Project)

# How to Run the App
1. Open R Studio
2. Set your working directory to the Dashboard folder within the repository folder (eg. ~/Documents/Project/wellbeing/Dashboard). Learn how to change your working directory [here](https://support.rstudio.com/hc/en-us/articles/200711843-Working-Directories-and-Workspaces-in-the-RStudio-IDE).
3. Click the Run App button in the top right of the text editor within R Studio

# Notes:
- The format and content of the data varies from year to year so we had to clean each year separately before merging it (this was also done in merged.R)
- The data we received was anonymised in different ways before being given to us, so it varied even more than HMS data normally would have from year to year.
- The years we had were from the school years 2017/2018, 2018/2019, 2019/2020, & 2020/2021, so our code only cleans and merges those years due to the inconsistency in formatting and content.
- To add more, you would need to add code to clean and format the data into the format we chose (use the merged.R file as an example of how to get it in the proper format). 
- After cleaning and formatting the data within merged.R, you can easily add it to the code that merges the data frames.
- So long as the new data matches the format, it should merge properly, and no other code should need to be changed (app.R should not need to be changed to add new years of data).
