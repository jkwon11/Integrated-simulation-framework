#!/usr/bin/python

import sys
import string
import operator
import re
import numpy as np

file_name = sys.argv[1]
output_file = sys.argv[2]
core_dynamic = float("0")
LLC_dynamic = float("0")
SA_dynamic = float("0")
PCIe_dynamic = float("0")

f = open(file_name, 'r')
search = "Total Cores: 4 cores"
lines = [line.strip() for line in f.readlines()]
#lines = f.readlines() 
#print ([line.rstrip() for line in lines if line.find('Total cores')])
#		if line.find("Total Cores: 4 cores") != -1:
for i, line in enumerate(lines):
	if i == 25 :
		item = line.split(" ")
		core_dynamic += float(item[3])

# Calculate LLC Leakage
	if i == 33 :
		item = line.split(" ")
		LLC_dynamic += float(item[3])
# Calculate SA Leakage w/o PCIe
	if i == 41 :
		item = line.split(" ")
		SA_dynamic += float(item[3])
	if i == 49 :
		item = line.split(" ")
		SA_dynamic += float(item[3])
# Calculate PCIe Leakage
	if i == 57 :
		item = line.split(" ")
		PCIe_dynamic += float(item[3])

f.close()

o = open(output_file, 'w')

o.write('Leakage ' + '\n')
o.write('******** Layer 0 ********' +'\n')
o.write('LLC : ' + str(LLC_dynamic) + '\n')
o.write('SA(w/oPCIe) : ' + str(SA_dynamic) + '\n')
o.write('PCIe : ' + str(PCIe_dynamic) + '\n')
o.write('******** Layer 1 ********' + '\n')
o.write('core : '+ str(core_dynamic / 2) + '\n')
o.write('******** Layer 2 ********' + '\n')
o.write('core : '+ str(core_dynamic / 2) +'\n')
o.close()
