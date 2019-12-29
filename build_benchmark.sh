#./build_champsim.sh [branch_pred] [l1i_pref] [l1d_pref] [l2c_pref] [llc_pref] [llc_repl] [num_core]"
# Baseline
./build_champsim.sh bimodal no no no no lru 1
./build_champsim.sh bimodal next_line next_line ip_stride no lru 1
./build_champsim.sh hashed_perceptron next_line next_line kpcp next_line drrip 1

# Custom components

# Prefetcher
./build_champsim.sh bimodal next_line next_line 1_way_l2c_stride no lru 1
./build_champsim.sh bimodal next_line next_line 2_way_l2c_stride no lru 1
./build_champsim.sh bimodal next_line next_line 4_way_l2c_stride no lru 1
./build_champsim.sh bimodal next_line next_line 8_way_l2c_stride no lru 1
