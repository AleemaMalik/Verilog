# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog Lab4Part3.v

#load simulation using mux as the top level simulation module
vsim lab4part3

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}


#set input values using the force command, signal names need to be in {} brackets

#reset
force {SW[9]} 1

force {SW[7]} 1
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0

force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 0

#clock is 0
force {KEY[0]} 0
run 10ns

#clock is one (should change on positive edge)
force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
force {SW[9]} 0
run 10ns

force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns

force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1

force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns

force {KEY[3]} 1
force {KEY[2]} 0
force {KEY[1]} 1
force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns

force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns

force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns

force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns

force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns

force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns

force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns

force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns

force {KEY[0]} 1
run 10ns