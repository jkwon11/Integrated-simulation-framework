#!/bin/bash
hot_base= #your_hotspot_IF_directory

output_dir=${hot_base}/output

FREQ=("4GHz")
temp=("320" "330" "340" "350" "360" "370")
BENCHMARK=("gcc" "hmmer" "lbm" "mcf" "povray" "sjeng" "soplex")
freq_i=0
bench_i=0
temp_i=0

while [ ${freq_i} -ne 1 ]
do
while [ ${bench_i} -ne 7 ]
do
while [ ${temp_i} -ne 6 ]
do

awk -v a="${BENCHMARK[$[bench_i]]}" -v b="${temp[$[temp_i]]}" -v c="${FREQ[$[freq_i]]}" 'NR==38{ print c, a,"aa",b,$2 >> "temp_result_2D.txt" }' ${output_dir}/${FREQ[$[freq_i]]}/${BENCHMARK[$[bench_i]]}/cpu_aa_2D_${BENCHMARK[$[bench_i]]}_${temp[$[temp_i]]}.steady

awk -v a="${BENCHMARK[$[bench_i]]}" -v b="${temp[$[temp_i]]}" -v c="${FREQ[$[freq_i]]}" 'NR==38{ print c, a,"l",b,$2 >> "temp_result_2D.txt" }' ${output_dir}/${FREQ[$[freq_i]]}/${BENCHMARK[$[bench_i]]}/cpu_l_2D_${BENCHMARK[$[bench_i]]}_${temp[$[temp_i]]}.steady

awk -v a="${BENCHMARK[$[bench_i]]}" -v b="${temp[$[temp_i]]}" -v c="${FREQ[$[freq_i]]}" 'NR==38{ print c, a,"pv",b,$2 >> "temp_result_2D.txt" }' ${output_dir}/${FREQ[$[freq_i]]}/${BENCHMARK[$[bench_i]]}/cpu_pv_2D_${BENCHMARK[$[bench_i]]}_${temp[$[temp_i]]}.steady

awk -v a="${BENCHMARK[$[bench_i]]}" -v b="${temp[$[temp_i]]}" -v c="${FREQ[$[freq_i]]}" 'NR==38{ print c, a,"av",b,$2 >> "temp_result_2D.txt" }' ${output_dir}/${FREQ[$[freq_i]]}/${BENCHMARK[$[bench_i]]}/cpu_av_2D_${BENCHMARK[$[bench_i]]}_${temp[$[temp_i]]}.steady

temp_i=$((temp_i+1))
done
temp_i=0
bench_i=$((bench_i+1))
done
bench_i=0
freq_i=$((freq_i+1))
done


