// May 28 2015
// Nathan Pointer

module unpack(clk, rst, io, eta, phi, et, e);
	input clk;
	input rst;
	input eta; // 32
	input phi; // 32
	input et;   // 0-1000
	input e;
	input io;

	reg[0:31] index;
	integer i;

	reg [4:0] etas [4:0]; // 32 blocks of 32
	reg [4:0] phis [4:0]; // 32 blocks of 32
	reg [10:0] ets [4:0];
	reg [10:0] es [4:0];

	reg et_temp[10:0];
	reg e_temp[10:0];

	localparam gets = 0, puts = 1;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			index <=0;
			for (i=0; i<8; i=i+1) begin
				etas[i] <= 0;
				phis[i] <= 0;
				ets[i] <= 0;
				es[i] <= 0;
			end
		end
		else begin
			case(io)
				puts:
					begin
						index = index + 1;
						etas[index] = eta;
						phis[index] = phi;
						ets[index] = et;
						es[index] = e;
					end
				gets:
					begin
						i = eta + (phi*8);
						et_temp = ets[i];
						e_temp = es[i];	
					end
			endcase
		end
	end

	// Outputs
	assign et = et_temp;
	assign e = e_temp;

endmodule

