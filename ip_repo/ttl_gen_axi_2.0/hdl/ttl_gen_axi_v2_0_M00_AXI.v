
`timescale 1 ns / 1 ps

	module ttl_gen_axi_v2_0_M00_AXI #
	(
		// Users to add parameters here
        parameter integer AXIS_TDATA_WIDTH = 32,
        parameter integer BRAM_DATA_WIDTH = 32, //BRAM_DATA_WIDTH=2^LOG2_DATA_WIDTH
        parameter integer LOG2_DATA_WIDTH = 5, //BRAM_DATA_WIDTH=2^LOG2_DATA_WIDTH
        parameter integer BRAM_ADDR_WIDTH = 16  // 2^15 = 32768 positions
        
		// User parameters ends
		// Do not modify the parameters beyond this line

		// The master will start generating data from the C_M_START_DATA_VALUE value
		parameter  C_M_START_DATA_VALUE	= 32'hAA000000,
		// The master requires a target slave base address.
    // The master will initiate read and write transactions on the slave with base address specified here as a parameter.
		parameter  C_M_TARGET_SLAVE_BASE_ADDR	= 32'h40000000,
		// Width of M_AXI address bus. 
    // The master generates the read and write addresses of width specified as C_M_AXI_ADDR_WIDTH.
		parameter integer C_M_AXI_ADDR_WIDTH	= 32,
		// Width of M_AXI data bus. 
    // The master issues write data and accept read data where the width of the data bus is C_M_AXI_DATA_WIDTH
		parameter integer C_M_AXI_DATA_WIDTH	= 32,
		// Transaction number is the number of write 
    // and read transactions the master will perform as a part of this example memory test.
		parameter integer C_M_TRANSACTIONS_NUM	= 4
	)
	(
		// Users to add ports here
        input clk, arm, trig,
        input [BRAM_DATA_WIDTH-1:0] num_cycles, //Number of cycles 
        input [BRAM_DATA_WIDTH-1:0] num_reps, //Number of repetitions of pattern - i.e. total number of cycles=num_cycles*num_reps
        input init_val,
        output out,
        output [1:0] state,
        output error_flag,
		// User ports ends
		// Do not modify the ports beyond this line

		// Initiate AXI transactions
		input wire  INIT_AXI_TXN,
		// Asserts when ERROR is detected
		output reg  ERROR,
		// Asserts when AXI transactions is complete
		output wire  TXN_DONE,
		// AXI clock signal
		input wire  M_AXI_ACLK,
		// AXI active low reset signal
		input wire  M_AXI_ARESETN,
		// Master Interface Write Address Channel ports. Write address (issued by master)
		output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_AWADDR,
		// Write channel Protection type.
    // This signal indicates the privilege and security level of the transaction,
    // and whether the transaction is a data access or an instruction access.
		output wire [2 : 0] M_AXI_AWPROT,
		// Write address valid. 
    // This signal indicates that the master signaling valid write address and control information.
		output wire  M_AXI_AWVALID,
		// Write address ready. 
    // This signal indicates that the slave is ready to accept an address and associated control signals.
		input wire  M_AXI_AWREADY,
		// Master Interface Write Data Channel ports. Write data (issued by master)
		output wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_WDATA,
		// Write strobes. 
    // This signal indicates which byte lanes hold valid data.
    // There is one write strobe bit for each eight bits of the write data bus.
		output wire [C_M_AXI_DATA_WIDTH/8-1 : 0] M_AXI_WSTRB,
		// Write valid. This signal indicates that valid write data and strobes are available.
		output wire  M_AXI_WVALID,
		// Write ready. This signal indicates that the slave can accept the write data.
		input wire  M_AXI_WREADY,
		// Master Interface Write Response Channel ports. 
    // This signal indicates the status of the write transaction.
		input wire [1 : 0] M_AXI_BRESP,
		// Write response valid. 
    // This signal indicates that the channel is signaling a valid write response
		input wire  M_AXI_BVALID,
		// Response ready. This signal indicates that the master can accept a write response.
		output wire  M_AXI_BREADY,
		// Master Interface Read Address Channel ports. Read address (issued by master)
		output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_ARADDR,
		// Protection type. 
    // This signal indicates the privilege and security level of the transaction, 
    // and whether the transaction is a data access or an instruction access.
		output wire [2 : 0] M_AXI_ARPROT,
		// Read address valid. 
    // This signal indicates that the channel is signaling valid read address and control information.
		output wire  M_AXI_ARVALID,
		// Read address ready. 
    // This signal indicates that the slave is ready to accept an address and associated control signals.
		input wire  M_AXI_ARREADY,
		// Master Interface Read Data Channel ports. Read data (issued by slave)
		input wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_RDATA,
		// Read response. This signal indicates the status of the read transfer.
		input wire [1 : 0] M_AXI_RRESP,
		// Read valid. This signal indicates that the channel is signaling the required read data.
		input wire  M_AXI_RVALID,
		// Read ready. This signal indicates that the master can accept the read data and response information.
		output wire  M_AXI_RREADY
	);

	// function called clogb2 that returns an integer which has the
	// value of the ceiling of the log base 2

	 function integer clogb2 (input integer bit_depth);
		 begin
		 for(clogb2=0; bit_depth>0; clogb2=clogb2+1)
			 bit_depth = bit_depth >> 1;
		 end
	 endfunction

	// TRANS_NUM_BITS is the width of the index counter for 
	// number of write or read transaction.
	 localparam integer TRANS_NUM_BITS = clogb2(C_M_TRANSACTIONS_NUM-1);

	// Example State machine to initialize counter, initialize write transactions, 
	// initialize read transactions and comparison of read data with the 
	// written data words.
	parameter [1:0] IDLE = 2'b00, // This state initiates AXI4Lite transaction 
			// after the state machine changes state to INIT_WRITE   
			// when there is 0 to 1 transition on INIT_AXI_TXN
		INIT_WRITE   = 2'b01, // This state initializes write transaction,
			// once writes are done, the state machine 
			// changes state to INIT_READ 
		INIT_READ = 2'b10, // This state initializes read transaction
			// once reads are done, the state machine 
			// changes state to INIT_COMPARE 
		INIT_COMPARE = 2'b11; // This state issues the status of comparison 
			// of the written data with the read data	

	 reg [1:0] mst_exec_state;

	// AXI4LITE signals
	//write address valid
	reg  	axi_awvalid;
	//write data valid
	reg  	axi_wvalid;
	//read address valid
	reg  	axi_arvalid;
	//read data acceptance
	reg  	axi_rready;
	//write response acceptance
	reg  	axi_bready;
	//write address
	reg [C_M_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	//write data
	reg [C_M_AXI_DATA_WIDTH-1 : 0] 	axi_wdata;
	//read addresss
	reg [C_M_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
	//Asserts when there is a write response error
	wire  	write_resp_error;
	//Asserts when there is a read response error
	wire  	read_resp_error;
	//A pulse to initiate a write transaction
	reg  	start_single_write;
	//A pulse to initiate a read transaction
	reg  	start_single_read;
	//Asserts when a single beat write transaction is issued and remains asserted till the completion of write trasaction.
	reg  	write_issued;
	//Asserts when a single beat read transaction is issued and remains asserted till the completion of read trasaction.
	reg  	read_issued;
	//flag that marks the completion of write trasactions. The number of write transaction is user selected by the parameter C_M_TRANSACTIONS_NUM.
	reg  	writes_done;
	//flag that marks the completion of read trasactions. The number of read transaction is user selected by the parameter C_M_TRANSACTIONS_NUM
	reg  	reads_done;
	//The error register is asserted when any of the write response error, read response error or the data mismatch flags are asserted.
	reg  	error_reg;
	//index counter to track the number of write transaction issued
	reg [TRANS_NUM_BITS : 0] 	write_index;
	//index counter to track the number of read transaction issued
	reg [TRANS_NUM_BITS : 0] 	read_index;
	//Expected read data used to compare with the read data.
	reg [C_M_AXI_DATA_WIDTH-1 : 0] 	expected_rdata;
	//Flag marks the completion of comparison of the read data with the expected read data
	reg  	compare_done;
	//This flag is asserted when there is a mismatch of the read data with the expected read data.
	reg  	read_mismatch;
	//Flag is asserted when the write index reaches the last write transction number
	reg  	last_write;
	//Flag is asserted when the read index reaches the last read transction number
	reg  	last_read;
	reg  	init_txn_ff;
	reg  	init_txn_ff2;
	reg  	init_txn_edge;
	wire  	init_txn_pulse;


	// I/O Connections assignments

	//Adding the offset address to the base addr of the slave
	assign M_AXI_AWADDR	= C_M_TARGET_SLAVE_BASE_ADDR + axi_awaddr;
	//AXI 4 write data
	assign M_AXI_WDATA	= axi_wdata;
	assign M_AXI_AWPROT	= 3'b000;
	assign M_AXI_AWVALID	= axi_awvalid;
	//Write Data(W)
	assign M_AXI_WVALID	= axi_wvalid;
	//Set all byte strobes in this example
	assign M_AXI_WSTRB	= 4'b1111;
	//Write Response (B)
	assign M_AXI_BREADY	= axi_bready;
	//Read Address (AR)
	assign M_AXI_ARADDR	= C_M_TARGET_SLAVE_BASE_ADDR + axi_araddr;
	assign M_AXI_ARVALID	= axi_arvalid;
	assign M_AXI_ARPROT	= 3'b001;
	//Read and Read Response (R)
	assign M_AXI_RREADY	= axi_rready;
	//Example design I/O
	assign TXN_DONE	= compare_done;
	assign init_txn_pulse	= (!init_txn_ff2) && init_txn_ff;


	//Generate a pulse to initiate AXI transaction.
	always @(posedge M_AXI_ACLK)										      
	  begin                                                                        
	    // Initiates AXI transaction delay    
	    if (M_AXI_ARESETN == 0 )                                                   
	      begin                                                                    
	        init_txn_ff <= 1'b0;                                                   
	        init_txn_ff2 <= 1'b0;                                                   
	      end                                                                               
	    else                                                                       
	      begin  
	        init_txn_ff <= INIT_AXI_TXN;
	        init_txn_ff2 <= init_txn_ff;                                                                 
	      end                                                                      
	  end     


    //----------------------------
	//Read Address Channel
	//----------------------------

	//start_single_read triggers a new read transaction. read_index is a counter to
	//keep track with number of read transaction issued/initiated

	  always @(posedge M_AXI_ACLK)                                                     
	  begin                                                                            
	    if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1)                                                       
	      begin                                                                        
	        read_index <= 0;                                                           
	      end                                                                          
	    // Signals a new read address is                                               
	    // available by user logic                                                     
	    else if (start_single_read)                                                    
	      begin                                                                        
	        read_index <= read_index + 1;                                              
	      end                                                                          
	  end                                                                              
	                                                                                   
	  // A new axi_arvalid is asserted when there is a valid read address              
	  // available by the master. start_single_read triggers a new read                
	  // transaction                                                                   
	  always @(posedge M_AXI_ACLK)                                                     
	  begin                                                                            
	    if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1)                                                       
	      begin                                                                        
	        axi_arvalid <= 1'b0;                                                       
	      end                                                                          
	    //Signal a new read address command is available by user logic                 
	    else if (start_single_read)                                                    
	      begin                                                                        
	        axi_arvalid <= 1'b1;                                                       
	      end                                                                          
	    //RAddress accepted by interconnect/slave (issue of M_AXI_ARREADY by slave)    
	    else if (M_AXI_ARREADY && axi_arvalid)                                         
	      begin                                                                        
	        axi_arvalid <= 1'b0;                                                       
	      end                                                                          
	    // retain the previous value                                                   
	  end                                                                              


	//--------------------------------
	//Read Data (and Response) Channel
	//--------------------------------

	//The Read Data channel returns the results of the read request 
	//The master will accept the read data by asserting axi_rready
	//when there is a valid read data available.
	//While not necessary per spec, it is advisable to reset READY signals in
	//case of differing reset latencies between master/slave.

	  always @(posedge M_AXI_ACLK)                                    
	  begin                                                                 
	    if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1)                                            
	      begin                                                             
	        axi_rready <= 1'b0;                                             
	      end                                                               
	    // accept/acknowledge rdata/rresp with axi_rready by the master     
	    // when M_AXI_RVALID is asserted by slave                           
	    else if (M_AXI_RVALID && ~axi_rready)                               
	      begin                                                             
	        axi_rready <= 1'b1;                                             
	      end                                                               
	    // deassert after one clock cycle                                   
	    else if (axi_rready)                                                
	      begin                                                             
	        axi_rready <= 1'b0;                                             
	      end                                                               
	    // retain the previous value                                        
	  end                                                                   
	                                                                        
	//Flag write errors                                                     
	assign read_resp_error = (axi_rready & M_AXI_RVALID & M_AXI_RRESP[1]);  


	//--------------------------------
	//User Logic
	//--------------------------------

	//------------------                                                                
	//Read example                                                                      
	//------------------                                                                
	                                                                                    
	//Terminal Read Count                                                               
	                                                                                    
	  always @(posedge M_AXI_ACLK)                                                      
	  begin                                                                             
	    if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1)                                                         
	      last_read <= 1'b0;                                                            
	                                                                                    
	    //The last read should be associated with a read address ready response         
	    else if ((read_index == C_M_TRANSACTIONS_NUM) && (M_AXI_ARREADY) )              
	      last_read <= 1'b1;                                                            
	    else                                                                            
	      last_read <= last_read;                                                       
	  end                                                                               
	                                                                                    
	/*                                                                                  
	 Check for last read completion.                                                    
	                                                                                    
	 This logic is to qualify the last read count with the final read                   
	 response/data.                                                                     
	 */                                                                                 
	  always @(posedge M_AXI_ACLK)                                                      
	  begin                                                                             
	    if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1)                                                         
	      reads_done <= 1'b0;                                                           
	                                                                                    
	    //The reads_done should be associated with a read ready response                
	    else if (last_read && M_AXI_RVALID && axi_rready)                               
	      reads_done <= 1'b1;                                                           
	    else                                                                            
	      reads_done <= reads_done;                                                     
	    end                                                                                                                                 
	// Add user logic here

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
	// User logic ends

	endmodule
