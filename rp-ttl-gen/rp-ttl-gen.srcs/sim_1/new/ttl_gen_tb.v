`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/09/2018 07:09:45 PM
// Design Name: 
// Module Name: ttl_gen_tb
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


module ttl_gen_tb();

    parameter integer BRAM_DATA_WIDTH=32;
    parameter integer BRAM_ADDR_WIDTH=16;
    
    parameter integer num_cyc=4;
    parameter integer num_rep=2;
    parameter integer num_sim_steps=500;
    
    reg clk, arm, trig;
    wire out, error_flag;
    wire [1:0] state;

    //Configuration data
    reg [BRAM_DATA_WIDTH-1:0] num_cycles; //Number of cycles 
    reg [BRAM_DATA_WIDTH-1:0] num_reps; //Number of repetitions of pattern - i.e. total number of cycles=num_cycles*num_reps
    reg init_val; //Initial value of output

    wire                        bram_portb_clk;
    wire                        bram_portb_rst;
    wire [BRAM_ADDR_WIDTH-1:0]  bram_portb_addr;
    wire [BRAM_DATA_WIDTH-1:0]  bram_portb_wrdata;
    reg [BRAM_DATA_WIDTH-1:0]  bram_portb_rddata; //Read transition time data through this input
    wire                        bram_portb_we;
    
    //Instantiate ttl_gen_tb
    ttl_gen my_ttl(clk,arm, trig, num_cycles, num_reps, init_val, out, state, error_flag,
          bram_portb_clk, bram_portb_rst, bram_portb_addr, bram_portb_wrdata, bram_portb_rddata,
          bram_portb_we      
    );
    
    initial begin
        $display("Starting simulation");
        num_cycles=num_cyc;
        num_reps=num_rep;
        clk=0; //Initializeclock
        arm=0;
        trig=0;
        init_val=0;
        
        #10
        arm=1;
                
        #10
        trig=1;
                
        #10
        arm=0;
                
        #10
        trig=0;
        
        #num_sim_steps $display("Ending simulation"); //Terminate simulation after num_sim_steps
        $finish;
    end
    
    //Oscillate clock
    always begin        //Make clock
        #1
        clk=!clk; //Invert clock    
    end

    always @(posedge clk) begin
        //$monitor("time=%d, bram_portb_addr=%d, num_cycles=%d",$time,bram_portb_addr,num_cycles);
        //if(bram_portb_addr+1<=num_cycles) begin
        //bram_portb_rddata=(bram_portb_addr+1)**2; //Compute number of clock cycles in transition time as power of two of address.//This fails
        bram_portb_rddata=(bram_portb_addr+1)*10;//bram_portb_addr+bram_portb_addr+bram_portb_addr+bram_portb_addr+bram_portb_addr+5; //This fails also
        
        //bram_portb_rddata=20; //This doesn't fail - address is failing to get assigned
        //$monitor("time=%d: Setting wait time: bram_portb_rddata=%d, bram_portb_addr=%d",$time,bram_portb_rddata,bram_portb_addr);
        if(bram_portb_addr==0) begin
            $display("bram_portb_addr=0");        
        end else if(bram_portb_addr==1) begin
            $display("bram_portb_addr=1");
        end
        //end else begin
        //    $display("wait time never gets set.");        
        //end
    end

endmodule
