`timescale 1 ns / 1 ps

	module ttl_gen_axi_v2_0_M00_AXI #
	(
		// Users to add parameters here
        parameter integer LOG2_DATA_WIDTH = 5, //C_M_AXI_DATA_WIDTH=2^LOG2_DATA_WIDTH
        
		// User parameters ends
		// Do not modify the parameters beyond this line

		// The master will start generating data from the C_M_START_DATA_VALUE value
		parameter  C_M_START_DATA_VALUE	= 32'hAA000000,
		// The master requires a target slave base address.
    // The master will initiate read and write transactions on the slave with base address specified here as a parameter.
		parameter  C_M_TARGET_SLAVE_BASE_ADDR	= 32'h42000000,
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
        // ////////////////////////////////////////	
		// Users to add ports here
        input clk, arm, trig, //Note: arm is connected to FPGA Pin H16 (that's GPIO Pin DIO1_P, and trig to FPGA Pin G17 (that's GPIO Pin DIO0_P)
        input [C_M_AXI_DATA_WIDTH-1:0] num_cycles, //Number of cycles 
        input [C_M_AXI_DATA_WIDTH-1:0] num_reps, //Number of repetitions of pattern - i.e. total number of cycles=num_cycles*num_reps
        input init_val,
        output v_out,
        output [1:0] state,
        output error_flag,
		// User ports ends
		// ////////////////////////////////////////
		// Do not modify the ports beyond this line

		// Initiate AXI transactions
		//input wire  INIT_AXI_TXN,
		// Asserts when ERROR is detected
		//output reg  ERROR,
		// Asserts when AXI transactions is complete
		//output wire  TXN_DONE,
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

	parameter [1:0] IDLE_STATE = 2'b00, // Here, the device is waiting for an arm state.
		ARM_STATE   = 2'b01, // The device loads initial operating parameters from memory and waits for a trigger
		TRIGGERED_STATE = 2'b10, // The device runs through its programmed sequence of values
		ERROR_STATE = 2'b11; // The device is in an error state	

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
	reg [TRANS_NUM_BITS : 0] 	read_index, last_read; //Last read caches previous value of read_index to identify whether a new read has occurred.
	//Expected read data used to compare with the read data.
	reg [C_M_AXI_DATA_WIDTH-1 : 0] 	expected_rdata;
	//Flag marks the completion of comparison of the read data with the expected read data
	//reg  	compare_done;
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

    //Turn OFF all write outputs - not doing so may cause problems that pass logic test, but fail implementation 
	//Adding the offset address to the base addr of the slave
	assign M_AXI_AWADDR	= 0;//C_M_TARGET_SLAVE_BASE_ADDR + axi_awaddr;
	//AXI 4 write data
	assign M_AXI_WDATA	= 0;//axi_wdata;
	assign M_AXI_AWPROT	= 3'b000;
	assign M_AXI_AWVALID	= 0;//axi_awvalid;
	//Write Data(W)
	assign M_AXI_WVALID	= 0;//axi_wvalid;
	//Set all byte strobes in this example
	assign M_AXI_WSTRB	= 4'b1111;
	//Write Response (B)
	assign M_AXI_BREADY	= 0;//axi_bready;
	//Read Address (AR)
	assign M_AXI_ARADDR	= C_M_TARGET_SLAVE_BASE_ADDR + axi_araddr;
	assign M_AXI_ARVALID	= axi_arvalid;
	assign M_AXI_ARPROT	= 3'b001;
	//Read and Read Response (R)
	assign M_AXI_RREADY	= axi_rready;
	//Example design I/O
	//assign TXN_DONE	= compare_done;
//	assign init_txn_pulse	= (!init_txn_ff2) && init_txn_ff;


//	//Generate a pulse to initiate AXI transaction.
//	always @(posedge M_AXI_ACLK)										      
//	  begin                                                                        
//	    // Initiates AXI transaction delay    
//	    if (M_AXI_ARESETN == 0 )                                                   
//	      begin                                                                    
//	        init_txn_ff <= 1'b0;                                                   
//	        init_txn_ff2 <= 1'b0;                                                   
//	      end                                                                               
//	    else                                                                       
//	      begin  
//	        init_txn_ff <= INIT_AXI_TXN;
//	        init_txn_ff2 <= init_txn_ff;                                                                 
//	      end                                                                      
//	  end     


    //----------------------------
	//Read Address Channel
	//----------------------------

	//start_single_read triggers a new read transaction. read_index is a counter to
	//keep track with number of read transaction issued/initiated

	  always @(posedge M_AXI_ACLK)                                                     
	  begin                                                                            
	    if (M_AXI_ARESETN == 0 )//|| init_txn_pulse == 1'b1)                                                       
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
	    if (M_AXI_ARESETN == 0)// || init_txn_pulse == 1'b1)                                                       
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
	    if (M_AXI_ARESETN == 0)// || init_txn_pulse == 1'b1)                                            
	      begin                                                             
	        axi_rready <= 1'b0;                                             
	      end                                                               
	    // accept/acknowledge rdata/rresp with axi_rready by the master     
	    // when M_AXI_RVALID is asserted by slave                           
	    else if (M_AXI_RVALID && ~axi_rready)                               
	      begin                                                             
	        axi_rready <= 1'b1;
	        next_wait <=M_AXI_RDATA; //Register wait time - TG
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

	// Add user logic here

    reg [C_M_AXI_DATA_WIDTH-1:0] clk_cntr; //32 bits means ~34.4 s at 125 MHz
    reg [C_M_AXI_DATA_WIDTH-1:0] wait_reg; //Register the wait time before state change
    //reg [C_M_AXI_ADDR_WIDTH-1:0] axi_araddr; //Pointer into memory //This is superseded by axi_araddr
    reg [C_M_AXI_DATA_WIDTH-1:0] first_wait, this_wait, next_wait; //Value of the memory at current and next addresses - cache ahead of time for memory I/O latency
    reg [1:0] state_reg; //Register the state for stability
    reg [C_M_AXI_DATA_WIDTH-1:0] cycle_cntr; //Register to count how many edges have been completed - this bit-shifted left LOG2_DATA_WIDTH times is the memory location.
    reg [C_M_AXI_DATA_WIDTH-1:0] rep_cntr; //Register to count how many repetitions of pattern have been completed.
    reg out_reg; //Register output
    reg [C_M_AXI_DATA_WIDTH-1:0] num_cycles_reg; //Register this during init.
    reg [C_M_AXI_DATA_WIDTH-1:0] num_reps_reg; //Register this during init.
    
    reg trig_last, arm_last; //Register previous states of trigger and arm to identify rising edges.
    
    reg complete_flag; //Flag to indicate that a whole set of repetitions is complete, and the board may reenter the IDLE_STATE.
    
    reg error_flag_reg; //Error flag register
    
    initial begin
        //Initialize registers (for simulations)
        #0 //At first simulated clock cycle 
        clk_cntr=0; //Initialize counter to 0.
    end
    
    assign state=state_reg; //Connect state to corresponding register
    assign vout=out_reg; //Connect output register to output wire.
    assign error_flag=error_flag_reg;
    
//    //When the arm signal has a rising edge, change the board state accordingly,
//    //but only do so when when the board is in an "off"="complete" state
//    always @(posedge arm) begin
//        //if (state==0) state_reg<=1;    
//        state_reg<=1; //state is initially at an undefined state - need to force a state at some point.
//    end

//    //When the trig (trigger) signal has a rising edge, change the board state accordingly,
//    //triggering the board behavior
//    always @(posedge trig) begin
//        if (state==1) state_reg<=2;
//    end
    
    //Manage state register with non-blocking assignments.
    always @(posedge clk or posedge complete_flag or posedge trig or posedge arm) begin
        if(state_reg==IDLE_STATE && !arm_last && arm) begin
            state_reg<=ARM_STATE; //Rising trigger edge - board has been triggered - start waveform
        end else if(state_reg==ARM_STATE && !trig_last && trig) begin
            state_reg<=TRIGGERED_STATE; //Rising trigger edge - board has been triggered - start waveform
        end else if(state_reg==TRIGGERED_STATE && complete_flag) begin
            state_reg<=IDLE_STATE; //
        end 
    end
    
    always @(posedge clk) begin
//        if(~clk_cntr == 0) begin //If clock counter saturates, force the board off
//            state_reg=3;
//            out_reg=0;
//        end
        
        case(state_reg)
            IDLE_STATE: //"Off" or "complete" state - force output low
            begin
                out_reg=0; //
                last_read=read_index; //Cache read_index - can't reset read index in this block unless enforce clocks to be the same
                //axi_araddr=0; //Initialize memory position pointer.
                start_single_read=0;
                complete_flag=0; //Reset complete flag.
                $display("off");
            end
            
            ARM_STATE: //Board is armed - initialize board and wait for trigger 
            begin
                //Note: Verilog doesn't have sign extension - it has zero extension (i.e. when number of bits on LHS is greater than on RHS, all unspecified bits are set to 0).
                clk_cntr=0; //Initialize the clock counter
                cycle_cntr=0; //Initialize the cycle counter
                rep_cntr=0; //Initialize repetition counter
                
                //Memory:
                //Get operation parameters from memory
//                if(axi_araddr==0) begin
//                    //address 0 = num_reps - number of repeititions
//                    num_reps_reg = mem_val;
//                    axi_araddr = axi_araddr+1;
//                end else if(axi_araddr==1) begin
//                    //address 1 = number of cycles per repetition
//                    num_cycles_reg = mem_val;
//                    axi_araddr = axi_araddr+1;
//                end else if(axi_araddr==2) begin
//                    //address 2 = init value
//                    out_reg=mem_val; //change output to initial value
//                    axi_araddr=axi_araddr+1; //Advance memory pointer after assignment
//                end
                //addresses 3 to 3+number of cycles - 1 = transition times
                out_reg=init_val; //Set output at initial value

                num_cycles_reg=num_cycles; //Register the total number of cycles per repetition (period)
                num_reps_reg=num_reps; //Register the total number of repetitions

                start_single_read=1; //Trigger read operation to pull first wait time from memory.
                if(read_index==last_read) begin
                    axi_araddr=0; //Initialize memory pointer.
                end else if(read_index==last_read+1) begin
                    this_wait=next_wait; //This is the first wait-time - store it and advance the 
                    first_wait=next_wait; //Cache the first wait time for convenience at transitions from one repetition to the next.
                    //Look ahead one memory address, if there is more than one wait time stored in memory
                    if(num_cycles_reg>1) begin
                        axi_araddr=C_M_AXI_DATA_WIDTH; //Initialize memory pointer at second memory location - already cached first value in first_wait.
                        start_single_read=1; //Trigger read operation to pull second wait time from memory.
                    end
                end

                error_flag_reg=0; //Set error_flag to zero
                //first_wait=M_AXI_RDATA; //Cache first wait time
                //if(axi_rready) begin
                //    next_wait=M_AXI_RDATA; //Register wait time
                //end
                
                $display("armed");
            end
            
            TRIGGERED_STATE: //Board is triggered - output waveform until done, then return to State 0 ("Complete" or "off" state)
            begin
                if(start_single_read && axi_rready) begin
                    start_single_read=0; //Zero read if it has been completed.
                end
                
                if(clk_cntr>=this_wait && num_cycles_reg!=0 && num_reps_reg!=0) begin
                    //This cycle is complete - change state and update wait time
                    $monitor("%d: just waited %d",$time, next_wait);
                    out_reg=~out_reg; //Invert output state
                    this_wait=next_wait; //Fetch next wait time (already read from memory thanks to look-ahead scheme)
                    cycle_cntr=cycle_cntr+1; //Increment cycle counter by one.
                    axi_araddr=axi_araddr+C_M_AXI_DATA_WIDTH; //Advance the address by one data width.
                    start_single_read=1; //Trigger read operation to pull next wait time from memory.

                    //next_wait=M_AXI_RDATA; //Register wait time
                    clk_cntr=1; //Restart clock counter - set to be time at NEXT clock cycle - i.e. the next time it will be queried.
                end else begin
                    $monitor("%d: clk_cntr=%d, this_wait=%d, axi_araddr=%d",$time, clk_cntr, next_wait,axi_araddr);
                    clk_cntr=clk_cntr+1; //Increment clock counter                
                end
                
                if(cycle_cntr>=num_cycles_reg) begin
                    //Completed all cycles in this repetition - restart from beginning of wait time sequence
                    $monitor("%d: Finished rep #%d",$time, rep_cntr);
                    rep_cntr=rep_cntr+1; //Increment repetition counter
                    cycle_cntr=0; //Restart cycle counter
                    this_wait=first_wait; //Restart wait time from beginning of sequence
                    axi_araddr=C_M_AXI_DATA_WIDTH; //Look ahead wait time by one address in memory
                    start_single_read=1; //Trigger read operation to pull first wait time from memory.
                    //next_wait=M_AXI_RDATA; //Register wait time
                    out_reg=init_val; //Re-initialize output for another repetition.
                    clk_cntr=1; //Restart clock counter - set to be time at NEXT clock cycle, since it won't be checked again until then.
                end 
                
                if(rep_cntr>=num_reps_reg) begin
                    //Completed all repetitions - exit this state
                    out_reg=0; //Reset output
                    complete_flag=1; //Set complete flag.
                    //state_reg=IDLE_STATE; //Reset state
                    $display("done!");
                end 
            end
            
            ERROR_STATE: //Error state
            begin
                error_flag_reg=1; //Assert error flag
                $display("error!");
            end
        endcase
        
        //Register trigger and arm inputs for comparison
        trig_last=trig;
        arm_last=arm;
    end
	// User logic ends

	endmodule
