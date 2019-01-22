---
title: "EE283_Lab2"
author: "Josh Crapser"
date: "January 17, 2019"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Lab 2: Python (and some comparison to R)

## File processing in Python

_1. How do you ask if a file exists?_

```{python file_exists}

import os

file = input("Enter absolute path to file you want to check: ")
if file == '': #if no path specified use default
    file = "C:/Users/Josh/Documents/EE283/Lab2/EE283_Lab2.Rmd"

print("Check if file '{0}' exists\n".format(file))

if os.path.exists(file):
    print("Yes, '{0}' exists".format(file))
else:
    print("'{0}' does not exist".format(file))
    
```

_2. How do you ask if a file is a directory?_

```{python file_dir}

import os

file = input("Enter absolute path to file you want to check: ")
if file == '': #if no path specified use default
    file = "C:/Users/Josh/Documents/EE283/Lab2/EE283_Lab2.Rmd"

print("Check if file '{0}' is a directory\n".format(file))

if os.path.isdir(file):
    print("Yes, '{0}' is a directory".format(file))
else:
    print("'{0}' is not a directory".format(file))
```

_3. How do you remove (delete) a file?_

```{python rm_file}


import os

file = input("Enter absolute path to file you want to delete: ")
if file == '': #if no path specified use default
    file = "C:/Users/Josh/Documents/EE283/Lab2/delete.txt"

print("Removing file '{0}'".format(file))

if os.path.isdir(file):
    os.rmdir(file)
    print("Directory '{0}' was deleted.".format(file))
elif os.path.exists(file):
    os.remove(file)
    print("File '{0}' was deleted.".format(file))
else:
    print("File '{0}' does not exist".format(file))

if file == "C:/Users/Josh/Documents/EE283/Lab2/delete.txt":
    os.chdir("C:/Users/Josh/Documents/EE283/Lab2/")
    deletedfile = open("delete.txt", "w")
    deletedfile.close()
```

_4. How do you get the size of a file?_

```{python file_size}

import os

file = input("Enter absolute path to file you want to check: ")
if file == '': #if no path specified use default
    file = "C:/Users/Josh/Documents/EE283/Lab2/delete.txt"

print("Checking size of {0}\n".format(file))

if os.path.exists(file): 
    if os.path.getsize(file) >= 1E9:
        print("{0} is {1} (decimal) or {2} (binary) GB large".format(file, os.path.getsize(file)/1E9, os.path.getsize(file)/2**30))
    elif os.path.getsize(file) >= 1E6 and os.path.getsize(file) < 1E9:
        print("{0} is {1} (decimal) or {2} (binary) MB large".format(file, os.path.getsize(file)/1E6, os.path.getsize(file)/2**20))
    elif os.path.getsize(file) < 1E6:
        print("{0} is {1} (decimal) or {2} (binary) KB large".format(file, os.path.getsize(file)/1E3, os.path.getsize(file)/2**10))
else:
    print("{0} does not exist".format(file))
```

_5. How do you get all the file names matching a pattern?_

```{python file_Pattern}

import os
import glob

path = input("Enter the directory you would like to check: ")
if path == '': #if no path specified use default
    path = "C:/Users/Josh/Documents/EE283/Lab2/"

os.chdir(path)

inputpattern = input("Enter the file search pattern: ")
searchpattern = glob.glob(inputpattern)

if len(searchpattern) > 0:
    for i in searchpattern:
        print(i)
else:
    print("{0} does not exist".format(inputpattern))
```

_6. How do you get all the file names matching a pattern recursively?_

```{python recursive_pattern}

import os
import glob

path = input("Enter the directory you would like to check: ")
if path == '': #if no path specified use default
    path = "C:/Users/Josh/Documents/EE283/Lab2/"

os.chdir(path)

inputpattern = input("Enter the file search pattern: ")
searchpattern = glob.glob(inputpattern, recursive = True)

if len(searchpattern) > 0:
    for i in searchpattern:
        print(i)
else:
    print("{0} does not exist".format(inputpattern))

```

_7. How do you get an iterator to all files matching a pattern, as opposed to returning a potentially huge list?_

```{python file_iterator}
import os
import glob

path = input("Enter the directory you would like to check: ")
if path == '': #if no path specified use default
    path = "C:/Users/Josh/Documents/EE283/Lab2/"

os.chdir(path)

inputpattern = input("Enter the file search pattern: ")
searchpattern = glob.glob(inputpattern)
iterpattern = iter(searchpattern)

if len(searchpattern) > 0:
    for i in searchpattern:
        print(next(iterpattern))
        if input("Press enter for next match"):
            print(next(iterpattern))
else:
    print("{0} does not exist".format(inputpattern))
```

_8. How do you open gzip-compressed files for reading and for writing?_

```{python gzip}

import gzip 
import os
import glob

path = input("Enter the directory you would like to check: ")
if path == '': #if no path specified use default
    path = "C:/Users/Josh/Documents/EE283/Lab2/"

os.chdir(path)

rw = input("Enter 'r' to read or 'w' to write a gzipped file: ")

if rw == "r":
    print(gzip.open(input("Enter the gzip file: "), rw).read())
    
elif rw == "w":
    written = input("What would you like to write? ")
    file = input("Enter the gzip file: ")
    gzip.open(file, "wt").write(written)
    print("\nYou wrote '{0}' to {1}".format((gzip.open(file,"rt")).read(), file))

```

_9. Download "lab2data.tar.gz" and expand it. It contains input (data) files and output (result) files. But, something went wrong and not all the output files were created. Generate a list of those output files that were not created in Python._

```{python missing_output}

import urllib.request
import os
import glob
import gzip
import io
import tarfile

path = input("Enter the directory you would like to operate in: ")
if path == '': #if no path specified use default
    path = "C:/Users/Josh/Documents/EE283/Lab2/"

os.chdir(path)

url="http://www.molpopgen.org/EE283Winter2019/"
filename="lab2data.tar.gz"
out=filename[:-3]

filecon=urllib.request.urlopen(url + filename)
compressed = io.BytesIO(filecon.read())
decompressed = gzip.GzipFile(fileobj=compressed)

with open(out, 'wb') as outfile:
    outfile.write(decompressed.read())
    
tar = tarfile.open(out)
tar.extractall()
tar.close()

#datafile.#.a.txt > outfile.#.a.out.txt
print("Confirming input files have equivalent ouput files...")

os.chdir(os.path.join(path,'./lab2data/data'))
infiles = glob.glob('./*')
os.chdir(os.path.join(path,'./lab2data/output'))
outfiles = glob.glob('./*')

infiles=[infiles[i].replace("datafile", "outfile") for i in range(len(infiles))]
infiles=[infiles[i].replace("txt", "out") for i in range(len(infiles))]
missing=[]

for i in infiles:
    if i not in outfiles:
        missing.append(i)

print("You are missing {0} output files contained in the list 'missing':".format(len(missing)))
for i in missing:
    print(i.replace(".\\",""))

```

## File processing in R

_1. How do you ask if a file exists?_

```{r file_exists}

file <- readline(prompt = "Enter absolute path to file you want to check: ")
if (file == ""){ #if no path specified use default
    file = "C:/Users/Josh/Documents/EE283/Lab2/EE283_Lab2.Rmd"
}

if (file.exists(file)){
  cat("The file",file,"exists.")
} else {
  cat("The file",file,"does not exist.")
}
```


_2. How do you ask if a file is a directory?_

```{r file_dir}

file <- readline(prompt = "Enter absolute path to file you want to check: ")
if (file == ""){ #if no path specified use default
    file = "C:/Users/Josh/Documents/EE283/Lab2/EE283_Lab2.Rmd"
}

if (dir.exists(file)){
  cat("The file",file,"is a directory.")
} else if (file.exists(file)){
  cat("The file",file,"exists and is not a directory.")
} else {
  cat("The file",file,"does not exist.")
}
```


_3. How do you remove (delete) a file?_

```{r rm_file}

file <- readline(prompt = "Enter absolute path to file you want to delete: ")
if (file == ""){ #if no path specified use default
    file = "C:/Users/Josh/Documents/EE283/Lab2/delete.txt"
}
filename <- file
if (file.exists(file)){
  rm(file)
  cat("The file",filename,"has been deleted.")
} else {
  cat("The file",filename,"does not exist.")
}
undelete <- file("delete.txt")
close(undelete)

```


_4. How do you get the size of a file?_

```{r file_size}

file <- readline(prompt = "Enter absolute path to file you want to check: ")
if (file == ""){ #if no path specified use default
    file = "C:/Users/Josh/Documents/EE283/Lab2/lab2data.tar.gz"
}
filename <- file
if (file.exists(file)){
  cat("The file",filename,"is",file.info(filename)$size ,"bytes large.")
} else {
  cat("The file",filename,"does not exist.")
}

```


_5. How do you get all the file names matching a pattern?_

```{r file_Pattern}

file <- readline(prompt = "Enter the directory you would like to check: ")
pattern <- readline(prompt = "Enter the regular expression/pattern you would like to match with: ")

if (file == ""){ #if no path specified use default
  file = "C:/Users/Josh/Documents/EE283/Lab2/"
} 


if (length(list.files(file, pattern))>0 & pattern != "") {
  cat("The files matching you pattern are:",sapply(list.files(file, pattern), print))
} else {
  print("No files match that directory/pattern combination")
}

```


_6. How do you get all the file names matching a pattern recursively?_

```{r recursive_pattern}


file <- readline(prompt = "Enter the directory you would like to check: ")
pattern <- readline(prompt = "Enter the regular expression/pattern you would like to match with: ")

if (file == ""){ #if no path specified use default
  file = "C:/Users/Josh/Documents/EE283/Lab2/"
} 


if (length(list.files(file, pattern))>0 & pattern != "") {
  cat("The files matching you pattern are:",sapply(list.files(file, pattern, recursive=TRUE), print))
} else {
  print("No files match that directory/pattern combination")
}
```

_7. No equivalent in R._

_8. How do you open gzip-compressed files for reading and for writing?_

```{r gzip}

file <- readline(prompt = "Enter the absolute path to the gzip file you would like to check: ")
if (file == ""){ #if no path specified use default
    file = "C:/Users/Josh/Documents/EE283/Lab2/lab2data.tar.gz"
}

rw <- readline(prompt = "Enter 'r' to read or 'w' to write a gzipped file: ")
if (rw == "w"){
  written <- readline(prompt = "What would you like to write? ")
} else if (rw == "r") {
    lines <- readline(prompt = "How many lines would you like to read? ")
}

if (file.exists(file)==TRUE){
  if (rw == "w"){
    gzip <- gzfile(file, open = "wb")
    write(written, file = gzip, append = TRUE)
    close(gzip)
    cat("The file",file,"exists and has been appended.")
} else if (rw == "r") {
    gzip <- gzfile(file, open = "rb")
    readLines(gzip, n=as.integer(lines))
    close(gzip)
}
} else {
    cat("The file",file,"does not exist.")
}

```


_9. Download "lab2data.tar.gz" and expand it. It contains input (data) files and output (result) files. But, something went wrong and not all the output files were created. Generate a list of those output files that were not created in R._

```{r missing_files}

path <- readline(prompt = "Enter the directory you would like to operate in: ")
if (path == ""){ #if no path specified use default
    path = "C:/Users/Josh/Documents/EE283/Lab2/"
}

temp <- tempfile()
download.file("http://www.molpopgen.org/EE283Winter2019/lab2data.tar.gz", temp)
untar(temp)

infiles1 <- gsub("datafile", "outfile", list.files("C:/Users/Josh/Documents/EE283/Lab2/lab2data/data/"))
outfiles1 <- list.files("C:/Users/Josh/Documents/EE283/Lab2/lab2data/output")

infiles2 <- gsub("txt","out",infiles1)
missing <- list()
missing <- infiles2[!infiles2%in%outfiles1]
print(missing)
```

__The solution for identifying missing output files seems to be easier with R - at the very least it requires fewer lines of code for the same solution. This may be due to (what appears to me) to be a more versatile subsetting in R that bypasses a number of explicit for-loops and conditionals that have to be written out in Python.__
