# Setup
1. Make sure you have git installed (Learn how to do that [here](https://github.com/git-guides/install-git)).
2. Clone the repository (Learn how to do that [here](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)).
3. Install [R Studio](https://www.rstudio.com/products/rstudio/download/)

# How to Generate the Merged Data CSV (HMSAll.csv)
If you already have the HMSAll.csv, then just move the file to the parent directory of the repository folder (directions below)

1. Move the original HMS data CSVs (HMS17.csv, HMS18.csv, HMS19.csv, HMS20_better.csv) to the parent directory of the cloned repository (eg. if you clone the folder in ~/Documents/Project, then put the four years of HMS CSVs in ~/Documents/Project. Cloning the repo should result in another folder within the Project folder called wellbeing, ~/Documents/Project/wellbeing).
2. Open R Studio
3. Set your working directory to the Dashboard folder within the repository folder (eg. ~/Documents/Project/wellbeing/Dashboard). Learn how to change your working directory [here](https://support.rstudio.com/hc/en-us/articles/200711843-Working-Directories-and-Workspaces-in-the-RStudio-IDE).
4. Open the merged.R file
5. Run the whole merged.R file (this can be done on Mac by using command + r or by selecting all of the code with command + a or ctrl + a then using command + enter or ctrl + enter).
6. You should now have a file called HMSAll.csv in the parent directory of the repsitory folder (~/Documents/Project)

# How to run the app on your local machine
1. Open R Studio
2. Set your working directory to the Dashboard folder within the repository folder (eg. ~/Documents/Project/wellbeing/Dashboard). Learn how to change your working directory [here](https://support.rstudio.com/hc/en-us/articles/200711843-Working-Directories-and-Workspaces-in-the-RStudio-IDE).
3. Click the Run App button in the top right of the text editor within R Studio
