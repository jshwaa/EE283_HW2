# -*- coding: utf-8 -*-
"""
Created on Mon Feb  4 23:39:34 2019

@author: Josh
"""

import pandas as pd
data = [["A", 0.151252],["A", 0.1351351235215],["B", 1.35125125],["B", 2.1251251253],["C", 1.1]]
pydf = pd.DataFrame(data, columns=["experiment","result"])

pydf.to_csv(path_or_buf="./data3.txt", sep="\t", index=False)