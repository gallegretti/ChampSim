for trace in ./dpc3_traces/*; do
	for bin in ./bin/*; do
		# 50 million warmup, 200 million simulation
		echo "Running $bin with trace $trace"
		${bin} -warmup_instructions 50000000 -simulation_instructions 200000000 -traces ${trace} &> ./results/$(basename $bin)_TRACE_$(basename $trace).txt
	done
done
