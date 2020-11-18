#!/usr/bin/python

import sys
import string
import operator
import re
import numpy as np

file_name = sys.argv[1]
output_file_2D = sys.argv[2]

core_power = float("0")
LLC_power = float("0")
SA_power = float("0")

f = open(file_name, 'r')
lines = [line.strip() for line in f.readlines()]
for i, line in enumerate(lines):
# Calculate Core Power
	if i == 9 :
		item = line.split(" ")
		core_power = float(item[2])
# Calculate LLC Power
	if i == 10 :
		item = line.split(" ")
		LLC_power = float(item[2])
# Calculate SA Power
	if i == 11 :
		item = line.split(" ")
		SA_power = float(item[2])
f.close()

o_2D = open(output_file_2D, 'w')
o_2D.write('GPU\tCORE_0\tCORE_1\tCORE_2\tCORE_3\tL3_CACHE_0\tL3_CACHE_1\tL3_CACHE_2\tL3_CACHE_3\tBUS_0\tBUS_1\tSA\n')
o_2D.write("0" + '\t' + str(float(core_power)/4) + '\t' + str(float(core_power)/4) + '\t' + str(float(core_power)/4) + '\t' + str(float(core_power)/4) + '\t' + str(float(LLC_power)*0.174) + '\t' + str(float(LLC_power)*0.174) + '\t' + str(float(LLC_power)*0.174) + '\t' + str(float(LLC_power)*0.174) + '\t' + str(float(LLC_power)*0.152) + '\t' + str(float(LLC_power)*0.152) + '\t' + str(float(SA_power)) + '\n') 
o_2D.close()

