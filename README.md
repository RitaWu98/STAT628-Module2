
# Body Fat Calculator

## Table of Contents

- [Background](#background)
- [Description](#description)
- [Usage](#usage)
- [Contributors](#contributors)
- [License](#license)

## Background

The body fat percentage (BFP) of a human is defined as the total mass of fat divided by total body mass, multiplied by 100. <br/>
BFP is of great importance in measuring the well-being of individuals and predicting the risk of illness. <br/>
However, the measurement of BFP has faced a trade-off problem between measurement accuracy and approach flexibility for a long time. Some methods that involve underwater measuring may not be generalized to people's daily life, while other methods which must consider a large number of variables neither is an idealized choice. <br/>
Therefore finding a method that achieves both simplicity and exactitude in calculating BFP is our ultimate goal in conducting this project.<br/>

## Description

**data** folder:<br/>
BodyFat.csv is the raw data file.<br/>
clean_fat.csv is the dataset after clean.<br/>

**code** folder:<br/>
DataPreprocessing.ipynb is the jupyter notebook file to preclean the data to get the file clean_fat.csv.<br/>
variable selection.ipynb is the jupyter notebook file to select the variables for the final model .<br/>
Final Model & Outliers.ipynb is the jupyter notebook file to show the final model we select and the diagnosis for the model.<br/>
bodyfatapp.R is the Shiny file to show a webpage for users.<br/>

**figure** folder:<br/>
All the figures we get from the whole process.<br/>

**summary** folder:<br/>
summary.ipynb is the jupyter notebook file to provide a concise, replicable, and clear description of our statistical analysis and findings.<br/>


## Usage

Run the bodyfatapp.R,on the Shiny page,input your abdomen and weight to get your body fat result.

### Contributors
This project exists thanks to all the people who contribute.<br/>
Github id: Daohai04 Name:Haifeng Liu E-mail:hliu524@wisc.edu<br/>
Github id: RitaWu98 Name:Yue Wu E-mail:ywu494@wisc.edu<br/>
Github id: hpan55 Name:Hongwei Pan E-mail:hpan55@wisc.edu<br/>
