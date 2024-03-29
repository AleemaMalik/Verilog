# set the working dir, where all compiled verilog goes
vlib  work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog Lab4Part2.v

#load simulation using mux as the top level simulation module
vsim lab4part2

#log all signals and add some signals to waveform window
log {/*}

# add wave {/*} would add all items in top level simulation module
add wave {/*}

#load reset condition
force {SW[9]} 0
force {KEY[0]} 0

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0

force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1

run 10ns

#trigger reset position, can now start case testing 
force {KEY[0]} 1
run 10ns

# loading test case 0/1: Addition 
force {SW[9]} 1
force {KEY[0]} 0
#A = 8
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
#Adding A and B
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1

run 10ns

#Expected regout = 8
force {KEY[0]} 1
run 10ns

# load for case 2
force {SW[9]} 1
force {KEY[0]} 0
#A = 9 and B = 8 from prev. output
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
#NAND in lower and NOR in above of A and B
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 1

run 10ns

#run case 2
force {KEY[0]} 1
run 10ns

# load case 4
force {SW[9]} 1
force {KEY[0]} 0
#A = 6 amd B = from prev. output
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
#exactly 2 A and 3 B
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 0

run 10ns

#run case 4
force {KEY[0]} 1
run 10ns

# load case 3
force {SW[9]} 0
force {KEY[0]} 0
#A = 8 and B = 15
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
#Atleast 1 in any 8 bits of A and B
force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 1

run 10ns

#run case 3
force {KEY[0]} 1
run 10ns


#load case 5 
force {SW[9]} 1
force {KEY[0]} 0
#A = 8 and B = 0
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
#Atleast 1 in any 8 bits of A and B
force {KEY[1]} 0
force {KEY[2]} 1
force {KEY[3]} 0

run 10ns

#run case 5
force {KEY[0]} 1
run 10ns


#load case 6
force {SW[9]} 1
force {KEY[0]} 0
#A = 12 and B = 7
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1
#A XNOR B and A XOR B
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 0

run 10ns

#run case 6
force {KEY[0]} 1
run 10ns


#load case 7
force {SW[9]} 1
force {KEY[0]} 0

force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1

force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 0

run 10ns

#run case 7
force {KEY[0]} 1
run 10ns
