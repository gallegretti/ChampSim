DIR="./results/"

IFS=+
[ ! -d $DIR ] && mkdir -p $DIR

BINARGS="-warmup_instructions 50000000 -simulation_instructions 200000000 -traces "

#Generate all commands to be run
COMMANDS=()
for trace in ./dpc3_traces/*; do
	for bin in ./bin/*; do
		COMMANDS+=("$bin $BINARGS $trace &> $DIR$(basename $bin)_TRACE_$(basename $trace).txt+")
	done
done

parallel -j 8 eval {} ::: ${COMMANDS[@]}
