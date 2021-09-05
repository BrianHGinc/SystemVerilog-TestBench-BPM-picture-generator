vlib work
vmap work work
setactivelib work
vlog -sv2k12 -dbg -work work {ellipse_generator.sv}
vlog -sv2k12 -dbg -work work {ellipse_generator_tb.sv}
vsim -O5 +access +r ellipse_generator_tb

restart
# This line shows only the varible name instead of the full path and which module it was in
# config wave -signalnamewidth 1

add wave -divider "RST/ENA/RUN"

add wave -binary   /ellipse_generator_tb/reset
add wave -binary   /ellipse_generator_tb/enable
add wave -binary   /ellipse_generator_tb/ena_pause
add wave -binary   /ellipse_generator_tb/run

add wave -divider "Fill/Quad/Coord"

add wave -binary   /ellipse_generator_tb/ellipse_filled
add wave -unsigned /ellipse_generator_tb/quadrant
add wave -decimal  /ellipse_generator_tb/Xc
add wave -decimal  /ellipse_generator_tb/Yc
add wave -decimal  /ellipse_generator_tb/Xr
add wave -decimal  /ellipse_generator_tb/Yr

add wave -divider "CLOCK"

add wave -binary   /ellipse_generator_tb/clk

add wave -divider "OUTPUT"

add wave -binary   /ellipse_generator_tb/pixel_data_rdy
add wave -decimal  /ellipse_generator_tb/X_coord
add wave -decimal  /ellipse_generator_tb/Y_coord
add wave -binary   /ellipse_generator_tb/busy
add wave -binary   /ellipse_generator_tb/ellipse_complete 


add wave -divider "CORE REGS"

add wave -decimal  /ellipse_generator_tb/DUT/filled
add wave -decimal  /ellipse_generator_tb/DUT/quadrant_latch

add wave -decimal  /ellipse_generator_tb/DUT/xcr
add wave -decimal  /ellipse_generator_tb/DUT/ycr

add wave -decimal  /ellipse_generator_tb/DUT/sub_function
add wave -decimal  /ellipse_generator_tb/DUT/inv
add wave -decimal  /ellipse_generator_tb/DUT/draw_flat

add wave -decimal  /ellipse_generator_tb/DUT/x
add wave -decimal  /ellipse_generator_tb/DUT/y

add wave -decimal  /ellipse_generator_tb/DUT/xrr
add wave -decimal  /ellipse_generator_tb/DUT/yrr

add wave -decimal  /ellipse_generator_tb/DUT/p
add wave -decimal  /ellipse_generator_tb/DUT/px
add wave -decimal  /ellipse_generator_tb/DUT/py
add wave -decimal  /ellipse_generator_tb/DUT/rx2
add wave -decimal  /ellipse_generator_tb/DUT/ry2

add wave -decimal  /ellipse_generator_tb/DUT/pixel_data_rdy_int
add wave -decimal  /ellipse_generator_tb/DUT/busy_int
add wave -decimal  /ellipse_generator_tb/DUT/ena_process
add wave -decimal  /ellipse_generator_tb/DUT/freeze

add wave -divider "Consolidated Multiplier"

add wave -decimal  /ellipse_generator_tb/DUT/alu_mult_a
add wave -decimal  /ellipse_generator_tb/DUT/alu_mult_b
add wave -decimal  /ellipse_generator_tb/DUT/alu_mult_y 

run
