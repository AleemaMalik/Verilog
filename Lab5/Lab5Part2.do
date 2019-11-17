# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog Lab5Part2.v

#load simulation using mux as the top level simulation module
vsim Lab5Part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# test cases

force {CLOCK_50} 0

#testing reset#

force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0

run 10ns

force {CLOCK_50} 1

run 10ns

force {CLOCK_50} 0 

run 10 ns

force {CLOCK_50} 1

run 10 ns

force {CLOCK_50} 0
#testing case 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 0


run 10ns

force {CLOCK_50} 1

run 10ns

force {CLOCK_50} 0

run 10ns

force {CLOCK_50} 1

run 10ns

force {CLOCK_50} 0

run 10ns

force {CLOCK_50} 1

run 10ns

force {CLOCK_50} 0

run 10ns

force {CLOCK_50} 1

run 10ns


#testing case 2hz
force {SW[1]} 1
force {SW[0]} 0

force {CLOCK_50} 0 0ns, 1 {10ns} -r 20ns

run 1000000000 ns
