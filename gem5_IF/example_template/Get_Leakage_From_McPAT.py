#!/usr/bin/python

import sys
import string
import operator
import re
import numpy as np

file_name = sys.argv[1]
output_file = sys.argv[2]
file_leakage_1 = sys.argv[3]
file_leakage_2 = sys.argv[4]

core_leakage_1 = float("0")
core_leakage_2 = float("0")
LLC_Leakage = float("0")
SA_Leakage = float("0")
PCIe_Leakage = float("0")

f = open(file_name, 'r')
search = "Total Cores: 4 cores"
lines = [line.strip() for line in f.readlines()]
#lines = f.readlines() 
#print ([line.rstrip() for line in lines if line.find('Total cores')])
#		if line.find("Total Cores: 4 cores") != -1:
for i, line in enumerate(lines):
# Calculate LLC Leakage
	if 30 < i < 33 :
		item = line.split(" ")
		LLC_Leakage += float(item[3])
# Calculate SA Leakage w/o PCIe
	if 38 < i < 41 :
		item = line.split(" ")
		SA_Leakage += float(item[3])
	if 46 < i < 49 :
		item = line.split(" ")
		SA_Leakage += float(item[3])
# Calculate PCIe Leakage
	if 54 < i < 57 :
		item = line.split(" ")
		PCIe_Leakage += float(item[3])

f.close()

# Calculate Core Leakage
f = open(file_leakage_1, 'r')
lines = [line.strip() for line in f.readlines()]
for i, line in enumerate(lines):
	if 22 < i < 25 :
		item = line.split(" ")
		core_leakage_1 += float(item[3])
f.close()
f = open(file_leakage_2, 'r')
lines = [line.strip() for line in f.readlines()]
for i, line in enumerate(lines):
	if 22 < i < 25 :
		item = line.split(" ")
		core_leakage_2 += float(item[3])
f.close()

o = open(output_file, 'w')

o.write('Leakage ' + '\n')
o.write('******** Layer 0 ********' +'\n')
o.write('LLC : ' + str(LLC_Leakage) + '\n')
o.write('SA(w/oPCIe) : ' + str(SA_Leakage) + '\n')
o.write('PCIe : ' + str(PCIe_Leakage) + '\n')
o.write('******** Layer 1 ********' + '\n')
o.write('core : '+ str(core_leakage_1) + '\n')
o.write('******** Layer 2 ********' + '\n')
o.write('core : '+ str(core_leakage_2) +'\n')
o.close()
