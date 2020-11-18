#!/bin/bash
gem5_base= #your_gem5_IF_directory

gem5_dir=${gem5_base}/output
Scaling_File_2D=${gem5_base}/example_template/SCALING_McPAT.py

FREQ=4GHz
BENCHMARK_1=("hmmer" "lbm" "mcf" "sjeng" "soplex")
BENCHMARK_2=("gcc" "povray")
SCALING_FACTOR_1=("1.042875" "1.282823" "1.146262" "1.23586" "1.051933")
SCALING_FACTOR_2=("1.203617" "1.187621")
PCIE_SCALING_1=23.59995
PCIE_SCALING_2=23.43191
bench_i=0
TEMP=("320" "330" "340" "350" "360" "370")

while [ ${bench_i} -ne 5 ]
do
	echo "${BENCHMARK[$[bench_i]]} scaling started"
	temp_i=0
	while [ ${temp_i} -ne 6 ]
	do
	python ${Scaling_File_2D} ${gem5_dir}/${FREQ}/${BENCHMARK_1[$[bench_i]]}_${FREQ}/2D_power_${BENCHMARK_1[$[bench_i]]}_${TEMP[$[temp_i]]}.txt ${gem5_dir}/${FREQ}/${BENCHMARK_1[$[bench_i]]}_${FREQ}/ScaledPower_2D_${BENCHMARK_1[$[bench_i]]}_${TEMP[$[temp_i]]}.txt ${SCALING_FACTOR_1[$[bench_i]]} $PCIE_SCALING_1
	temp_i=$((temp_i+1))
	done
	echo "${BENCHMARK_1[$[bench_i]]} scaling finished"
	bench_i=$((bench_i+1))
done
bench_i=0

while [ ${bench_i} -ne 2 ]
do
	echo "${BENCHMARK[$[bench_i]]} scaling started"
	temp_i=0
	while [ ${temp_i} -ne 6 ]
	do
	python ${Scaling_File_2D} ${gem5_dir}/${FREQ}/${BENCHMARK_2[$[bench_i]]}_${FREQ}/2D_power_${BENCHMARK_2[$[bench_i]]}_${TEMP[$[temp_i]]}.txt ${gem5_dir}/${FREQ}/${BENCHMARK_2[$[bench_i]]}_${FREQ}/ScaledPower_2D_${BENCHMARK_2[$[bench_i]]}_${TEMP[$[temp_i]]}.txt ${SCALING_FACTOR_2[$[bench_i]]} $PCIE_SCALING_2
	temp_i=$((temp_i+1))
	done
	echo "${BENCHMARK_2[$[bench_i]]} scaling finished"
	bench_i=$((bench_i+1))
done
