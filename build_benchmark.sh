#./build_champsim.sh [branch_pred] [l1i_pref] [l1d_pref] [l2c_pref] [llc_pref] [llc_repl] [num_core]"
# Baseline
./build_champsim.sh bimodal no no no no lru 1
./build_champsim.sh bimodal next_line next_line ip_stride no lru 1
./build_champsim.sh hashed_perceptron next_line next_line kpcp next_line drrip 1

# Custom components

# Prefetcher

# No l2c prefetcher
./build_champsim.sh bimodal next_line next_line no no lru 1

# n-way config
./build_champsim.sh bimodal next_line next_line 1_way_l2c_stride no lru 1
./build_champsim.sh bimodal next_line next_line 4_way_l2c_stride no lru 1
./build_champsim.sh bimodal next_line next_line 16_way_l2c_stride no lru 1
./build_champsim.sh bimodal next_line next_line 64_way_l2c_stride no lru 1
./build_champsim.sh bimodal next_line next_line 256_way_l2c_stride no lru 1
./build_champsim.sh bimodal next_line next_line 1024_way_l2c_stride no lru 1

# table size config
./build_champsim.sh bimodal next_line next_line ipt_2_entries_stride no lru 1
./build_champsim.sh bimodal next_line next_line ipt_8_entries_stride no lru 1
./build_champsim.sh bimodal next_line next_line ipt_32_entries_stride no lru 1
./build_champsim.sh bimodal next_line next_line ipt_128_entries_stride no lru 1
./build_champsim.sh bimodal next_line next_line ipt_512_entries_stride no lru 1
./build_champsim.sh bimodal next_line next_line ipt_1024_entries_stride no lru 1
./build_champsim.sh bimodal next_line next_line ipt_2048_entries_stride no lru 1
./build_champsim.sh bimodal next_line next_line ipt_4096_entries_stride no lru 1
