#!/usr/bin/python

import sys
import string
import operator
import re
import numpy as np

file_name = sys.argv[1]
output_file = sys.argv[2]
scaling_factor = sys.argv[3]
pcie_factor = sys.argv[4]

core_power = float("0")
LLC_power = float("0")
SA_power = float("0")
PCIe_power = float("0")

f = open(file_name, 'r')
search = "Total Cores: 4 cores"
lines = [line.strip() for line in f.readlines()]
#lines = f.readlines() 
#print ([line.rstrip() for line in lines if line.find('Total cores')])
#		if line.find("Total Cores: 4 cores") != -1:
for i, line in enumerate(lines):
# Calculate Core Power
	if 22 < i <26 :
		item = line.split(" ")
		core_power += float(item[3])
# Calculate LLC Power
	if 30 < i < 34 :
		item = line.split(" ")
		LLC_power += float(item[3])
# Calculate SA Power w/o PCIe
	if 38 < i < 42 :
		item = line.split(" ")
		SA_power += float(item[3])
	if 46 < i < 50 :
		item = line.split(" ")
		SA_power += float(item[3])
# Calculate PCIe Power
	if 54 < i < 58 :
		item = line.split(" ")
		PCIe_power += float(item[3])

f.close()
print "Before Scaling"
print "Core : " + str(core_power)
print "LLC : " + str(LLC_power)
print "SA : " + str(SA_power)
print "PCIe : " + str(PCIe_power)

o = open(output_file, 'w')
o.write('Input File : ' + sys.argv[1] + '\n\n')
o.write('Before Scaling \n')
o.write('Core : ' + str(core_power) + '\n')
o.write('LLC : ' + str(LLC_power) + '\n')
o.write('SA w/o PCIe : ' + str(SA_power) + '\n')
o.write('PCIe : ' + str(PCIe_power) +'\n\n')


core_power *= float(scaling_factor)
LLC_power *= float(scaling_factor)
PCIe_power *= float(pcie_factor)
SA_power = float(scaling_factor) * SA_power + PCIe_power

print "After Scaling"
print "Core : " + str(core_power)
print "LLC : " + str(LLC_power)
print "SA w/ PCIe : " + str(SA_power)

o.write('Scale With Sacling Factor ' + str(scaling_factor) + '\n')
o.write('Core : ' + str(core_power) + '\n')
o.write('LLC : ' + str(LLC_power) + '\n')
o.write('SA(w/PCIe) : ' + str(SA_power) + '\n')
o.write('Total Power : ' + str(core_power + LLC_power + SA_power) + '\n\n')

o.close()
