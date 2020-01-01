DIR="./results/"

[ ! -d $DIR ] && mkdir -p $DIR

for trace in ./dpc3_traces/*; do
	for bin in ./bin/*; do
		# 50 million warmup, 200 million simulation
		echo "Running $bin with trace $trace"
		gnome-terminal -- bash -c "$bin -warmup_instructions 50000000 -simulation_instructions 200000000 -traces $trace &> $DIR$(basename $bin)_TRACE_$(basename $trace).txt; bash" &
	done
done
