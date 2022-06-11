// Author: Ha How Ung
// Written on: 2 June 2022 (Thursday)
// Title: Memory Interface Controller (Book 1 pg. 184)

module memory_interface_FSM (
	input clk, reset, rdy, rw,
	output reg oe, we,
	output reg [1:0] present_state	// For checking purpose
);

	reg [1:0] NS, PS;						// Next State, Present State
	

	localparam IDLE = 2'b00,			// State encoding
					CHKRW = 2'b01,
					READ = 2'b10,
					WRITE = 2'b11;

	always @ (posedge clk or posedge reset)
	begin
		if (reset)
			PS <= IDLE;
		else
			PS <= NS;
	end

	always @ (*)
	begin
	
		NS = PS;
		
		case(PS)
		
			IDLE:
				begin
					NS = (rdy == 1) ? CHKRW : IDLE;
					oe = 0;
					we = 0;
				end
			
			CHKRW:
				begin
					if (rw == 1)
					begin
						oe = rw;
						NS = READ;
					end
					else
					begin
						we = ~rw;
						NS = WRITE;
					end
				end
			
			READ:
				NS = (rdy == 1) ? READ : IDLE;
			
			WRITE:
				NS = (rdy == 1) ? WRITE : IDLE;
			
			default:
				NS = PS;
				
		endcase
		
		present_state = PS;
		
	end
endmodule