#!/bin/bash
gem5_base= #your_gem5_IF_directory
hot_base= #your_HotSpot_IF_directory

HotSpot_dir=${hot_base}/output
gem5_dir=${gem5_base}/output
PowerTrace_File=${gem5_base}/example_template

FREQ=4GHz
BENCHMARK=("gcc" "hmmer" "lbm" "mcf" "povray" "sjeng" "soplex")
TEMP=("320" "330" "340" "350" "360" "370") 
bench_i=0
temp_i=0

while [ ${bench_i} -ne 7 ]
do
	echo "${BENCHMARK[$[bench_i]]} creating Ptrace started"
	mkdir ${HotSpot_dir}/${FREQ}/${BENCHMARK[$[bench_i]]}
	temp_i=0
	while [ ${temp_i} -ne 6 ]
	do
		python ${PowerTrace_File}/PowerTrace_2D.py ${gem5_dir}/${FREQ}/${BENCHMARK[$[bench_i]]}_${FREQ}/ScaledPower_2D_${BENCHMARK[$[bench_i]]}_${TEMP[$[temp_i]]}.txt ${HotSpot_dir}/${FREQ}/${BENCHMARK[$[bench_i]]}/${TEMP[$[temp_i]]}_2D.ptrace
		temp_i=$((temp_i+1))
	done
	echo "${BENCHMARK[$[bench_i]]} creating Ptrace finished"
	bench_i=$((bench_i+1))
done
