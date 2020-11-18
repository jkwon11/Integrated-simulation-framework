#!/bin/bash
gem5_dir= #your_gem5_directory
bmk_home= #your_SPECCPU2006_bin_directory

out_dir=${gem5_dir}/output
FREQ=4GHz #set to desired clock frequency
MAXINST=50

echo "povray STARTED!!!"
${gem5_dir}/build/X86/gem5.opt \
	--outdir=${out_dir}/${FREQ} \
${gem5_dir}/configs/example/se.py \
	--num-cpus=4 \
	--cpu-clock=${FREQ} \
	--mem-size=16GB \
	--mem-type=DDR4_2133_8x8 \
	--cpu-type=DerivO3CPU \
	--caches \
	--l2cache \
	--l3cache \
	--cacheline_size=64 \
	--maxinsts=${MAXINST} \
    -c "${bmk_home}/povray_base.amd64-m64-gcc43-nn;${bmk_home}/povray_base.amd64-m64-gcc43-nn;${bmk_home}/povray_base.amd64-m64-gcc43-nn;${bmk_home}/povray_base.amd64-m64-gcc43-nn"\
	-o "${bmk_home}/SPEC-benchmark-ref.ini Library_Path=${bmk_home};${bmk_home}/SPEC-benchmark-ref.ini Library_Path=${bmk_home};${bmk_home}/SPEC-benchmark-ref.ini Library_Path=${bmk_home};${bmk_home}/SPEC-benchmark-ref.ini Library_Path=${bmk_home}"\
	| gzip -c > ${out_dir}/${FREQ}/stdout_povray.gz
echo "povray FINISHED!!!"
