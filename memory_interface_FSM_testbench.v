// Author: Ha How Ung
// Written on: 2 June 2022 (Thursday)
// Title: testbench - Memory Interface Controller (Book 1 pg. 184)

`timescale 10ns/1ns

module memory_interface_FSM_tb ();

	reg clk, reset, rdy, rw;
	wire oe, we;
	wire [1:0] present_state;

memory_interface_FSM DUT (.clk(clk), .reset(reset), .rdy(rdy), .rw(rw), .oe(oe), .we(we), .present_state(present_state));

	initial
      begin
        $monitor($time, " reset=%b, rdy=%b, rw=%b, oe=%b, we=%b, present_state=%d", reset, rdy, rw, oe, we, present_state);
      end

  	integer i = 0;

	initial
      begin
        $dumpfile("memory_interface_FSM.vcd");
        $dumpvars(1, memory_interface_FSM_tb);

        #0 clk=0; reset=1; rdy=0; rw=0;
        #50 clk=~clk; reset=0;

        for (i=0; i<30; i=i+1)
          begin
            #50 clk=~clk; rdy = (i > 5 && i < 20) ? 1 : 0; rw = (i > 2) ? 1 : 0;
          end

        #50 clk=~clk; rdy=0;

        for (i=0; i<50; i=i+1)
          begin
            #50 clk=~clk; rdy = (i > 5 && i < 20) ? 1 : 0; rw = (i > 2) ? 0 : 1;
          end

      end

endmodule
