---
title: "EE283_Lab3"
author: "Josh Crapser"
date: "January 24, 2019"
output:
  html_document: default
  pdf_document: default
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```


```{r}
library(tidyverse)
library(ggplot2)
library(datasets)
head(mtcars)
```


##Plot to be fixed

```{r,echo=F,fig.width=8,fig.height=8,fig.align='center'}
mg <- ggplot(mtcars, aes(x = mpg, y = wt)) + geom_point() + facet_grid(vs + am ~ gear)

suppressMessages(suppressWarnings(print(mg)))
```

##Fix:

```{r fix_plot1, echo=F,fig.width=12,fig.height=12,fig.align='center'}

mtcars_mod <- mtcars %>% mutate(Weight=mtcars$wt*1000) %>% mutate(Gear=ifelse(gear == 3, "3 gears", ifelse(gear==4, "4 gears", "5 gears"))) %>% mutate(Transmission=ifelse(am == 0, "Automatic transmission", "Manual transmission")) %>% mutate(Engine=ifelse(vs == 0, "V-shaped Engine", "Straight Engine"))

mg <- ggplot(mtcars_mod, aes(x = mpg, y = Weight, color=Transmission)) + geom_point()

mg <- mg + facet_grid(Engine ~ Gear) + theme_bw(base_size=14) + labs(x="Miles/(US) Gallon", y="Weight (lbs)", color="Transmission") + theme(legend.position=c(0.86,0.861), legend.text=element_text(size=8))

suppressMessages(suppressWarnings(print(mg)))

suppressMessages(ggsave("fixed_plot1.pdf", mg))

```


##Plot 2 be fixed

```{r,echo=F,fig.width=7,fig.height=7,fig.align='center'}
ds <- ggplot(mpg, aes(displ, hwy, colour = class)) +
  geom_point() +
  geom_smooth()

suppressMessages(suppressWarnings(print(ds)))
```

##Fix:

```{r fix_plot2,echo=F,fig.width=11,fig.height=11,fig.align='center'}

#color blind-friendly palette
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")


ds <- ggplot(mpg, aes(displ, hwy, colour = class, fill = class)) +
  geom_point() +
  geom_smooth() +
  scale_colour_manual(values=cbPalette) +
  scale_fill_manual(values=cbPalette) +
  #scale_fill_manual(values=cbPalette) +
  theme_bw(base_size=12) + 
  labs(x="Engine Displacement (Liters)", y="Highway Miles/(US) Gallon") +
  theme(legend.position=c(0.74,0.87), legend.text=element_text(size=8)) + 
  guides(col = guide_legend(nrow = 2))

suppressMessages(suppressWarnings(print(ds)))

suppressMessages(ggsave("fixed_plot2.pdf", ds))

```

