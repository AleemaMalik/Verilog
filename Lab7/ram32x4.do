# set the working dir, where all compiled verilog goes
vlib  work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog Lab7Part1.v
vlog ram32x4.v

#load simulation using mux as the top level simulation module
vsim -L altera_mf_ver lab7part1

#log all signals and add some signals to waveform window
log {/*}

# add wave {/*} would add all items in top level simulation module
add wave {/*}

# SW[3:0] is the data
# SW[8:4] is the address
# SW[9] is the write enable signal
# KEY[0] is the clock

# case 1 - inputting the data 6 into address 00001

#setting the data input
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
# setting the address input
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
# setting the write enable signal to 1, this implies writing data
force {SW[9]} 1
# setting the clock to OFF
force {KEY[0]} 0
run 5ns
# setting the clock to ON
force {KEY[0]} 1
run 5ns

# case 2 - inputting the data 10 into address 00100

#setting the data input
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
# setting the address input
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 0
force {SW[8]} 0
# setting the write enable signal to 1, this implies writing data
force {SW[9]} 1
# setting the clock to OFF
force {KEY[0]} 0
run 5ns 
# setting the clock to ON
force {KEY[0]} 1
run 5ns

# case 3 - inputting the data F into address 10000

#setting the data input
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
# setting the address input
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 1
# setting the write enable signal to 1, this implies writing data
force {SW[9]} 1
# setting the clock to OFF
force {KEY[0]} 0
run 5ns 
# setting the clock to ON
force {KEY[0]} 1
run 5ns

# case 4 - reading the data from address 00001

#setting the data input
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
# setting the address input
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
# setting the write enable signal to 0, this implies reading data
force {SW[9]} 0
# setting the clock to OFF
force {KEY[0]} 0
run 5ns 
# setting the clock to ON
force {KEY[0]} 1
run 5ns

# case 5 - reading the data from address 00100

#setting the data input
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
# setting the address input
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 0
force {SW[8]} 0
# setting the write enable signal to 0, this implies reading data
force {SW[9]} 0
# setting the clock to OFF
force {KEY[0]} 0
run 5ns 
# setting the clock to ON
force {KEY[0]} 1
run 5ns

# case 6 - reading the data from address 10000

#setting the data input
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
# setting the address input
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 1
# setting the write enable signal to 0, this implies reading data
force {SW[9]} 0
# setting the clock to OFF
force {KEY[0]} 0
run 5ns 
# setting the clock to ON
force {KEY[0]} 1
run 5ns

# case 7 - writing data to a already set address 00001

#setting the data input
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
# setting the address input - to a random location
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
# setting the write enable signal to 1, this implies writing data
force {SW[9]} 1
# setting the clock to OFF
force {KEY[0]} 0
run 5ns 
# setting the clock to ON
force {KEY[0]} 1
run 5ns

# case 8 - reading the data from location 00001

#setting the data input
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
# setting the address input
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
# setting the write enable signal to 0, this implies reading data
force {SW[9]} 0
# setting the clock to OFF
force {KEY[0]} 0
run 5ns 
# setting the clock to ON
force {KEY[0]} 1
run 5ns

# case 9 - reading the data from unknown loaction

#setting the data input
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
# setting the address input - to a random location
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
# setting the write enable signal to 0, this implies reading data
force {SW[9]} 0
# setting the clock to OFF
force {KEY[0]} 0
run 5ns 
# setting the clock to ON
force {KEY[0]} 1
run 5ns