# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog Lab6Part2.v

#load simulation using mux as the top level simulation module
vsim part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
#set input values using the force command, signal names need to be in {} brackets

force clk 0 0ns, 1 {5ns} -r 10ns

#TEST1 
#reset
force resetn 0
force go 0
force data_in 0
run 10ns

force resetn 1
force go 1
force data_in 8'd5
run 10ns

force go 0

run 10ns

force go 1
force data_in 8'd4
run 10ns

force go 0

run 10ns

force go 1
force data_in 8'd3
run 10ns

force go 0

run 10ns

force go 1
force data_in 8'd2
run 10ns

force go 0

run 60ns

#TEST2
#reset
force resetn 0
force go 0
force data_in 0
run 10ns

force resetn 1
force go 1
force data_in 8'd5
run 10ns

force go 0

run 10ns

force go 1
force data_in 8'd4
run 10ns

force go 0

run 10ns

force go 1
force data_in 8'd3
run 10ns

force go 0

run 10ns

force go 1
force data_in 8'd0
run 10ns

force go 0

run 60ns

#TEST3
#reset
force resetn 0
force go 0
force data_in 0
run 10ns

force resetn 1
force go 1
force data_in 8'd5
run 10ns

force go 0

run 10ns

force go 1
force data_in 8'd4
run 10ns

force go 0

run 10ns

force go 1
force data_in 8'd3
run 10ns

force go 0

run 10ns

force go 1
force data_in 8'd1
run 10ns

force go 0

run 60ns