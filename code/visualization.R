rm(list = ls())
setwd("~/Desktop/STAT628")
require("ggplot2")
library("leaps")
library("grid")
library(gridExtra)
library(car)
library(MASS)
library(rms)
library(glmnet)
fat = read.csv("BodyFat.csv", header = T)
bmi=fat$WEIGHT/(fat$HEIGHT^2)
outlier.test.m3 = lm(fat$ADIPOSITY[-42]~bmi[-42])
summary(outlier.test.m3)
fat$HEIGHT[42] = sqrt(outlier.test.m3$coefficients[2]*(fat$WEIGHT[42])/(fat$ADIPOSITY[42]-outlier.test.m3$coefficients[1]))
fat.rm = fat[-c(182,76,96,48,221,163),]


# visualization
## raw bodyfat
x <- seq(0, 50, length.out=500)
df.fat <- with(fat, data.frame(x = x, y = dnorm(x, mean(BODYFAT), sd(BODYFAT))))
ggplot(fat)+
  geom_histogram(aes(x = BODYFAT, y = ..density..),binwidth = 1)+
  xlab("BodyFat")+
  ylab("Density")+
  geom_line(data = df.fat, aes(x = x, y = y), color = "red")+
  scale_colour_manual(breaks = "normal")+
  ggtitle("Density Plot of Bodyfat Data")+
  theme(plot.title = element_text(hjust = 0.5),legend.position="bottom")
ggsave("raw_bodyfat_density_plot.jpeg")
  

# normal QQ-plot of full model
test.rmoutlier.first = lm(BODYFAT~.,fat.rm[,-c(1,3)])
summary(test.rmoutlier.first)
qqplot.data <- function (vec) # argument: vector of numbers
{
  # following four lines from base R's qqline()
  y <- quantile(vec[!is.na(vec)], c(0.25, 0.75))
  x <- qnorm(c(0.25, 0.75))
  slope <- diff(y)/diff(x)
  int <- y[1L] - slope * x[1L]
  d <- data.frame(resids = vec)
  ggplot(d, aes(sample = resids))+
    stat_qq()+
    geom_abline(slope = slope, intercept = int)+
    ggtitle("Normal QQ plot of Bodyfat Data without Outliers")+
    theme(plot.title = element_text(hjust = 0.5))
}
qqplot.data(fat.rm$BODYFAT)
shapiro.test(fat.rm$BODYFAT)
ggsave("../figure/fatrm_qq_plot.jpeg")


## hitogram plots of variables
g = list()
df = list()
for (i in 2:17) {
  fat.var = data.frame(x = fat.rm[,i])
  diff = max(fat.var$x)-min(fat.var$x)
  g[[i-1]] = print(ggplot(fat.var)+
                   geom_histogram(aes(x = x, y = ..density..),binwidth = diff/round(sqrt(length(fat.var$x))))+
                   xlab(colnames(fat.rm[i]))+
                   ylab("Density"))
}
do.call(grid.arrange,g)
ggsave("var_density_plot.jpeg")


# correlation plot
library(corrplot)
cor.data <- fat.rm[,-c(1)]
corr <- cor(cor.data)
corrplot(corr, method="shade")
corrplot.mixed(corr,number.cex = .7 )
library(RColorBrewer)
par(mfrow=c(1,1))
corrplot(corr,order = "hclust",addrect = 10,
         col = brewer.pal(n = 8, name = "RdYlBu"),tl.col = "black",tl.cex = 0.7)


g = list()
g = lapply(1:16, function(i) {
  ggplot(fat.rm, aes(x="",y=fat.rm[,i])) +
    geom_boxplot(outlier.colour="red",
                 outlier.shape=4,outlier.size=2)+
    xlab(colnames(fat.rm)[i])+
    ylab("Value")}
  )
do.call(grid.arrange,g)


