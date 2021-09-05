Hi Everyone,

- Once again, a new project for those who are a step above beginner.  The attached .zip SystemVerilog test-bench was tested in Altera ModelSim 10 & 20, but contains no Altera specific code.  It should work in any ModelSim.

See original project page listing from Jan 28m 2021 located here:

https://www.eevblog.com/forum/fpga/systemverilog-example-testbench-which-saves-a-bmp-picture-and-executes-a-script/

- This example .BMP generator and ASCII script file reader can be adapted to test code such as pixel drawing algorithms, picture filters, and make use of a source ascii file to drive the inputs of your .sv DUT module while offering logging of the results, and executing the list of commands in order.


    How to setup:
1.  Unzip files into their own folder.
2.  Open ModelSim.
3.  Select 'File - Change directory', select the directory with the source files.
4.  In the transcript, type 'do setup_modelsim.do' to setup ModelSim's environment.
5.  In the transcript, type 'do run.do' to re-compile and run the test-bench.

The test-bench source 'ellipse_generator_tb.sv' contains the relevant code example while it drives and responds to the DUT 'ellipse_generator.sv'.

Inside 'ellipse_generator_tb.sv', there are 2 main 'task' calls.
execute_ascii_file("source_file_name.txt");                // Executes the command ascii file, searches for each '@' and executes the command string listed right after.
save_bmp_256( "bmp_file_name.bmp" , <bw_nocolor> );        // saves a 256 color BMP picture.


The 'save_bmp_256' requires 2 parameters setup at the beginning of the test-bench, plus one 8 bit 2 dimensional logic array called bitmap.

// ***********************************************************************************************************
// ***********************************************************************************************************
// Setup global bitmap size and logic memory array.
//
// localparam BMP_WIDTH  = 1024;
// localparam BMP_HEIGHT = 1024;
// logic [7:0] bitmap [0:BMP_WIDTH-1][0:BMP_HEIGHT-1];
//
// ***********************************************************************************************************
// ***********************************************************************************************************


When writing to the bitmap, use this line #441:

if (X_coord>=0 && Y_coord>=0 && X_coord<1024 && Y_coord<1024) bitmap[X_coord][Y_coord] = draw_color;

The 'if' command prevents pixel writes outside the allocated logic array size.

Next, executing an ascii file with a list of commands:

Line #110 calls the 'execute_ascii_file("ellipse_commands_in.txt")' task which opens and reads the .txt file in the quotes.
The command names are executed by the 'case' statement on line #285.

Example command '@DRAW_ELLI' on line #287 calls the draw_ellipse() task:
Line #396 begins the 'task draw_ellipse(integer src, integer dest);' task.
Inside, line #414 reads the 7 decimal parameters & sets the 'ellipse_generator.sv' DUT inputs.

Lines #438-447 waits while the 'ellipse_generator.sv' busy output is high while inside, line #439 waits for the (pixel_data_rdy) before it logs and writes a pixel into the bitmap.  Crucially line #446,  '@(negedge clk);' prevents the writing of infinite entries into the log file the moment the first pixel data is ready.  (Basically, waits 1 clock per acknowledged write.)


Finals:
Line #115 is what keeps the 'clk' line always oscillating.
While lines 120&121 create a dumb watchdog timer which stops the simulation after 15 clocks of no activity from the DUT ellipse_generator module.


Enjoy.
Plus, if anyone gets this project working in other vendor's version of ModelSim other than the free Altera version, please let us know.
