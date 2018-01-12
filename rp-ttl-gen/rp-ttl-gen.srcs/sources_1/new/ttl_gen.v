`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Plasma Science and Fusion Center, Massachusetts Institute of Technology
// Engineer: T. Golfinopoulos
// 
// Create Date: 01/05/2018 10:53:39 AM
// Design Name: 
// Module Name: ttl_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ttl_gen #
(
  parameter integer AXIS_TDATA_WIDTH = 32,
  parameter integer BRAM_DATA_WIDTH = 32, //BRAM_DATA_WIDTH=2^LOG2_DATA_WIDTH
  parameter integer LOG2_DATA_WIDTH = 5, //BRAM_DATA_WIDTH=2^LOG2_DATA_WIDTH
  parameter integer BRAM_ADDR_WIDTH = 16,  // 2^15 = 32768 positions
  parameter integer AVERAGES_WIDTH = 32
)
(
    // TTL-Gen-specific ports
    input clk,
    //input aresetn,//Don't need this 
    input arm,
    input trig,
    input [BRAM_DATA_WIDTH-1:0] num_cycles, //Number of cycles 
    input [BRAM_DATA_WIDTH-1:0] num_reps, //Number of repetitions of pattern - i.e. total number of cycles=num_cycles*num_reps
    input init_val,
    output out,
    output [1:0] state,
    output error_flag,
    
    // Slave side
//    output wire                        s_axis_tready,
//    input  wire [AXIS_TDATA_WIDTH-1:0] s_axis_tdata,
//    input  wire                        s_axis_tvalid,
  
//    // BRAM PORT A
//    output wire                        bram_porta_clk,
//    output wire                        bram_porta_rst,
//    output wire [BRAM_ADDR_WIDTH-1:0]  bram_porta_addr,
//    output wire [BRAM_DATA_WIDTH-1:0]  bram_porta_wrdata,
//    input  wire [BRAM_DATA_WIDTH-1:0]  bram_porta_rddata,
//    output wire                        bram_porta_we,
    
    // BRAM PORT B
    output wire                        bram_portb_clk,
    output wire                        bram_portb_rst,
    output wire [BRAM_ADDR_WIDTH-1:0]  bram_portb_addr,
    output wire [BRAM_DATA_WIDTH-1:0]  bram_portb_wrdata,
    input  wire [BRAM_DATA_WIDTH-1:0]  bram_portb_rddata, //Read transition time data through this input
    output wire                        bram_portb_we
);
    
    reg [BRAM_DATA_WIDTH-1:0] clk_cntr; //32 bits means ~34.4 s at 125 MHz
    reg [BRAM_DATA_WIDTH-1:0] wait_reg; //Register the wait time before state change
    reg [BRAM_ADDR_WIDTH-1:0] mem_ptr; //Pointer into memory
    reg [BRAM_DATA_WIDTH-1:0] next_wait; //Value of the memory at current address
    reg [1:0] state_reg; //Register the state for stability
    reg [BRAM_DATA_WIDTH-1:0] cycle_cntr; //Register to count how many edges have been completed - this bit-shifted left LOG2_DATA_WIDTH times is the memory location.
    reg [BRAM_DATA_WIDTH-1:0] rep_cntr; //Register to count how many repetitions of pattern have been completed.
    reg out_reg; //Register output
    reg [BRAM_DATA_WIDTH-1:0] num_cycles_reg; //Register this during init.
    reg [BRAM_DATA_WIDTH-1:0] num_reps_reg; //Register this during init.

    reg error_flag_reg; //Error flag register
    
//    assign s_axis_tready = 1;
     
//    assign bram_porta_clk = clk;
//    assign bram_porta_addr = mem_ptr;
//    assign bram_porta_wrdata = mem_val;//int_data_reg;
//    assign bram_porta_we = int_wren_reg;

    //Read data, only      
    assign bram_portb_clk = clk;
    assign bram_portb_rst = 0; //Don't reset memory
    assign bram_portb_addr = mem_ptr;
    assign bram_portb_wrdata = {(BRAM_DATA_WIDTH){1'b0}};
    assign bram_portb_we = 1'b0;

    initial begin
        //Initialize registers (for simulations)
        #0 //At first simulated clock cycle 
        clk_cntr=0; //Initialize counter to 0.
    end
    
    assign state=state_reg; //Connect state to corresponding register
    assign out=out_reg; //Connect output register to output wire.
    assign error_flag=error_flag_reg;
    
    //When the arm signal has a rising edge, change the board state accordingly,
    //but only do so when when the board is in an "off"="complete" state
    always @(posedge arm) begin
        //if (state==0) state_reg<=1;    
        state_reg<=1; //state is initially at an undefined state - need to force a state at some point.
    end

    //When the trig (trigger) signal has a rising edge, change the board state accordingly,
    //triggering the board behavior
    always @(posedge trig) begin
        if (state==1) state_reg<=2;
    end
    
    always @(posedge clk) begin
        if(~clk_cntr == 0) begin //If clock counter saturates, force the board off
            state_reg=3;
            out_reg=0;
        end 
        
        case(state_reg)
            0: //"Off" or "complete" state - force output low
            begin
                out_reg=0; //
                //mem_ptr=0; //Initialize memory position pointer.
                $display("off");
            end
            
            1: //Board is armed - initialize board and wait for trigger 
            begin
                //Note: Verilog doesn't have sign extension - it has zero extension (i.e. when number of bits on LHS is greater than on RHS, all unspecified bits are set to 0).
                clk_cntr=0; //Initialize the clock counter
                cycle_cntr=0; //Initialize the cycle counter
                rep_cntr=0; //Initialize repetition counter
                
                //Memory:
                //Get operation parameters from memory
//                if(mem_ptr==0) begin
//                    //address 0 = num_reps - number of repeititions
//                    num_reps_reg = mem_val;
//                    mem_ptr = mem_ptr+1;
//                end else if(mem_ptr==1) begin
//                    //address 1 = number of cycles per repetition
//                    num_cycles_reg = mem_val;
//                    mem_ptr = mem_ptr+1;
//                end else if(mem_ptr==2) begin
//                    //address 2 = init value
//                    out_reg=mem_val; //change output to initial value
//                    mem_ptr=mem_ptr+1; //Advance memory pointer after assignment
//                end
                //addresses 3 to 3+number of cycles - 1 = transition times
                out_reg=init_val; //Set output at initial value
                mem_ptr=0; //Initialize memory pointer.
                num_cycles_reg=num_cycles; //Register the total number of cycles per repetition (period)
                num_reps_reg=num_reps; //Register the total number of repetitions
                error_flag_reg=0; //Set error_flag to zero
                next_wait=bram_portb_rddata; //Register wait time
                $display("armed");
            end
            
            2: //Board is triggered - output waveform until done, then return to State 0 ("Complete" or "off" state)
            begin
                if(clk_cntr>=next_wait && num_cycles_reg!=0 && num_reps_reg!=0) begin
                    $monitor("%d: just waited %d",$time, next_wait);
                    out_reg=~out_reg; //Invert output state
                    //Fetch next wait time
                    cycle_cntr=cycle_cntr+1; //Increment cycle counter by one.
                    mem_ptr=cycle_cntr; //Looks like don't have to have absolute mem address - only integer.
                    next_wait=bram_portb_rddata; //Register wait time
                    clk_cntr=1; //Restart clock counter - set to be time at NEXT clock cycle - i.e. the next time it will be queried.
                end else begin
                    $monitor("%d: clk_cntr=%d, this_wait=%d, mem_ptr=%d",$time, clk_cntr, next_wait,mem_ptr);
                    clk_cntr=clk_cntr+1; //Increment clock counter                
                end
                
                if(cycle_cntr>=num_cycles_reg) begin
                    $monitor("%d: Finished rep #%d",$time, rep_cntr);
                    rep_cntr=rep_cntr+1; //Increment repetition counter
                    cycle_cntr=0; //Restart cycle counter
                    mem_ptr=cycle_cntr; //Looks like don't have to have absolute mem address - only integer.
                    next_wait=bram_portb_rddata; //Register wait time
                    out_reg=init_val; //Re-initialize output for another repetition.
                    clk_cntr=1; //Restart clock counter - set to be time at NEXT clock cycle, since it won't be checked again until then.
                end 
                
                if(rep_cntr>=num_reps_reg) begin  //Completed all repetitions - exit this state
                    out_reg=0; //Reset output
                    state_reg=0; //Reset state
                    $display("done!");
                end 
            end
            
            3: //Error state
            begin
                error_flag_reg=1; //Assert error flag
                $display("error!");
            end
        endcase
    end
    
    
endmodule
