// May 28 2015
// Nathan Pointer

module unpack(clk, rst, io, eta, phi, et, e, eout, etout, phiout, etaout);
	input clk;
	input rst;
	input eta; // 32
	input phi; // 32
	input et;   // 0-1000
	input e;
	input io;
	output eout;
	output etout;
	output phiout;
	output etaout;

	reg[0:31] index;
	integer i;

	reg [9:0] etas [1023:0]; // 32 blocks of 32
	reg [9:0] phis [1023:0]; // 32 blocks of 32
	reg [9:0] ets [1023:0];
	reg [9:0] es [1023:0];

	reg[9:0] et_temp;
	reg[9:0] e_temp;
	reg[9:0] eta_temp;
	reg[9:0] phi_temp;
	
	localparam gets = 0, puts = 1;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			index <=0;
			for (i=0; i<1023; i=i+1) begin
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
						// In Gets mode, using eta as an integer
						i = eta;
						et_temp = ets[i];
						e_temp = es[i];	
						eta_temp = etas[i];
						phi_temp = phis[i];
					end
			endcase
		end
	end

	// Outputs
	assign etout = et_temp;
	assign eout = e_temp;
	assign etaout = eta_temp;
	assign phiout = phi_temp;

endmodule
