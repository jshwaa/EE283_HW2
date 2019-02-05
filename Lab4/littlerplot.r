#!/usr/bin/env r

library(ggplot2)
library(readr)
library(optparse)

option_list <- list( 
  make_option("--file", default="diamonds.txt", 
              help="Input file name"),
  make_option("--out", default="diamondsagain.pdf",
              help="Output file name")
)

opt <- parse_args(OptionParser(option_list=option_list))

x <- read_delim(opt$file, delim="\t")


plot.diamonds <- ggplot(x, aes(clarity, fill = cut)) + geom_bar() +
  theme(axis.text.x = element_text(angle=70, vjust=0.5))

ggsave(opt$out,device="pdf", dpi = 600)


