//this seems to get inferred as a dual port ebr due to the mask logic requiring a read back of the current contents in a single clk cycle
module ram (i_clk, i_reset, din, mask, addr, write_en, dout);
	parameter addr_width = 8;
	parameter data_width = 8;
	input [addr_width-1:0] addr;
	input [data_width-1:0] din;
	input [data_width-1:0] mask;
	input wire write_en;
	input wire i_clk;
	input wire i_reset;
	output wire [data_width-1:0] dout;
	reg [data_width-1:0] mem [(1<<addr_width)-1:0];
		// Define RAM as an indexed memory array.

	//integer i;
	always @(posedge i_clk) // Control with a clock edge.
	begin
		if (i_reset == 1'b1)
			//for (i=0; i<(1<<addr_width); i=i+1) mem[i] <= {data_width{1'b0}};
			;
		else if (write_en) // And control with a write enable.
			mem[(addr)] <= (din & mask) | (mem[(addr)]&~mask);
	end
	assign dout = mem[addr];

	integer i;
	initial
	begin

		for (i=0; i<(1<<addr_width); i=i+1) mem[i] <= {data_width{1'b0}};
	end
endmodule
