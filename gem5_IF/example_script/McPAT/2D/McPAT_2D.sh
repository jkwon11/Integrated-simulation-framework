#!/bin/bash
gem5_base= #your_gem5_IF_directory
mcpat_base= #your_mcpat_IF_directory
mcpat_leakage_base= #your_mcpat_leakage_IF_directory

Parser_home=${gem5_base}/example_template
McPat_home=${mcpat_base}/obj_opt
McPat_leakage=${mepat_leakage_base}/obj_opt
gem5_dir=${gem5_base}/output

template_dir=${gem5_base}/example_template/2D
FREQ=("4GHz")
BENCHMARK=("povray")
TEMP=("320" "330" "340" "350" "360" "370")

bench_i=0
freq_i=0
temp_i=0

while [ ${freq_i} -ne 1 ] 
do
while [ ${temp_i} -ne 6 ] 
do
while [ ${bench_i} -ne 7 ] 
do
	echo "Start Parsing the Gem5 Result"
   sed -i 's/switch_cpus_10/cpu0/g' ${gem5_dir}/${FREQ[$[freq_i]]}/${BENCHMARK[$[bench_i]]}_${FREQ[$[freq_i]]}/stats.txt
   sed -i 's/switch_cpus_11/cpu1/g' ${gem5_dir}/${FREQ[$[freq_i]]}/${BENCHMARK[$[bench_i]]}_${FREQ[$[freq_i]]}/stats.txt
   sed -i 's/switch_cpus_12/cpu2/g' ${gem5_dir}/${FREQ[$[freq_i]]}/${BENCHMARK[$[bench_i]]}_${FREQ[$[freq_i]]}/stats.txt
   sed -i 's/switch_cpus_13/cpu3/g' ${gem5_dir}/${FREQ[$[freq_i]]}/${BENCHMARK[$[bench_i]]}_${FREQ[$[freq_i]]}/stats.txt

python ${Parser_home}/Gem5ToMcPAT-Parser.py -c ${gem5_dir}/${FREQ[$[freq_i]]}/config.json -s ${gem5_dir}/${FREQ[$[freq_i]]}/${BENCHMARK[$[bench_i]]}_${FREQ[$[freq_i]]}/stats.txt -t ${template_dir}/template_${FREQ[$[freq_i]]}_${TEMP[$[temp_i]]}.xml -o ${gem5_dir}/${FREQ[$[freq_i]]}/${BENCHMARK[$[bench_i]]}_${FREQ[$[freq_i]]}/2D_mcpat_input_${BENCHMARK[$[bench_i]]}_${TEMP[$[temp_i]]}.xml

	$McPat_home/mcpat -infile ${gem5_dir}/${FREQ[$[freq_i]]}/${BENCHMARK[$[bench_i]]}_${FREQ[$[freq_i]]}/2D_mcpat_input_${BENCHMARK[$[bench_i]]}_${TEMP[$[temp_i]]}.xml -print_level 5 -opt_for_clk 1 >  $gem5_dir/${FREQ[$[freq_i]]}/${BENCHMARK[$[bench_i]]}_${FREQ[$[freq_i]]}/2D_power_${BENCHMARK[$[bench_i]]}_${TEMP[$[temp_i]]}.txt

	bench_i=$((bench_i+1))
done
	bench_i=0
	temp_i=$((temp_i+1))
done
	temp_i=0
	freq_i=$((freq_i+1))
done
	
