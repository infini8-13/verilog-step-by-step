module ram_tb;

  wire [7:0] data;
  reg  [3:0] addr;
  reg  we,enable;
  reg  [7:0] tempd;

  integer l;

// Step 1. Instantiate the RAM module and connect the ports
  ram r1 (.data(data), .we(we), .enable(enable), .addr(addr));
 
  assign data= (we && !enable) ? tempd : 8'hzz;

  task initialize();
  begin
    we=1'b0; enable=1'b0; tempd=8'h00;
  end
  endtask

  // Step 2. Define body for the task named stimulus to initialize the
  //         "addr" and "tempd" inputs through i and j variables.
  //         use i for initialization of "addr" and j for initialization of "tempd".

  task stimulus(input [3:0]i, input [7:0]j);
  begin	
    addr = i;
    tempd = j;		// ------ Define the body here ------
  end
  endtask

// Step 3. Understand the various tasks defined in this testbench
  task write();
  begin
    we=1'b1;
    enable=1'b0;
  end
  endtask

  task read();
  begin
    we=1'b0;
    enable=1'b1;
  end
  endtask

  task delay;
  begin
    #10;
  end
  endtask

  initial
  begin
    initialize;
    delay;
    write;
    for(l=0;l<16;l=l+1)
    begin
      stimulus(l,l);
      delay;
    end
    initialize;
    delay;
    read;
    for(l=0;l<16;l=l+1)
    begin
      stimulus(l,l);
      delay;
    end
    delay;
    $finish;
   end

endmodule
