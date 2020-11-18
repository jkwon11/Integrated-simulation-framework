#!/bin/bash
hot_base= #your_hotspot_IF_directory

output_dir=${hot_base}/output
config_dir=${hot_base}/config
hotspot_home=${hot_base}

FREQ=("4GHz")
TEMP=("320" "330" "340" "350" "360" "370")
BENCHMARK=("povray" "gcc" "hmmer" "lbm" "mcf" "sjeng" "soplex")
bench_i=0
temp_i=0
freq_i=0

while [ ${temp_i} -ne 6 ]
do
while [ ${freq_i} -ne 1 ]
do
 while [ ${bench_i} -ne 7 ]
 do
	$hotspot_home/hotspot -c ${config_dir}/${BENCHMARK[$[bench_i]]}/${BENCHMARK[$[bench_i]]}_aa.config -f $hotspot_home/D_2D_CPU.flp -p ${output_dir}/${FREQ[$[freq_i]]}/${BENCHMARK[$[bench_i]]}/${TEMP[$[temp_i]]}_2D.ptrace -model_type grid -steady_file ${output_dir}/${FREQ[$[freq_i]]}/${BENCHMARK[$[bench_i]]}/cpu_aa_2D_${BENCHMARK[$[bench_i]]}_${TEMP[$[temp_i]]}.steady
	$hotspot_home/hotspot -c ${config_dir}/${BENCHMARK[$[bench_i]]}/${BENCHMARK[$[bench_i]]}_pv.config -f $hotspot_home/D_2D_CPU.flp -p ${output_dir}/${FREQ[$[freq_i]]}/${BENCHMARK[$[bench_i]]}/${TEMP[$[temp_i]]}_2D.ptrace -model_type grid -steady_file ${output_dir}/${FREQ[$[freq_i]]}/${BENCHMARK[$[bench_i]]}/cpu_pv_2D_${BENCHMARK[$[bench_i]]}_${TEMP[$[temp_i]]}.steady
	$hotspot_home/hotspot -c ${config_dir}/${BENCHMARK[$[bench_i]]}/${BENCHMARK[$[bench_i]]}_av.config -f $hotspot_home/D_2D_CPU.flp -p ${output_dir}/${FREQ[$[freq_i]]}/${BENCHMARK[$[bench_i]]}/${TEMP[$[temp_i]]}_2D.ptrace -model_type grid -steady_file ${output_dir}/${FREQ[$[freq_i]]}/${BENCHMARK[$[bench_i]]}/cpu_av_2D_${BENCHMARK[$[bench_i]]}_${TEMP[$[temp_i]]}.steady
	$hotspot_home/hotspot -c ${config_dir}/${BENCHMARK[$[bench_i]]}/${BENCHMARK[$[bench_i]]}_l.config -f $hotspot_home/D_2D_CPU.flp -p ${output_dir}/${FREQ[$[freq_i]]}/${BENCHMARK[$[bench_i]]}/${TEMP[$[temp_i]]}_2D.ptrace -model_type grid -steady_file ${output_dir}/${FREQ[$[freq_i]]}/${BENCHMARK[$[bench_i]]}/cpu_l_2D_${BENCHMARK[$[bench_i]]}_${TEMP[$[temp_i]]}.steady

	bench_i=$((bench_i+1))
done
bench_i=0
freq_i=$((freq_i+1))
done
freq_i=0
temp_i=$((temp_i+1))
done





