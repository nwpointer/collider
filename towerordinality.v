module towerordinality(clk, signal, etas, phis, ets, es, numtowers, etasout, phisout, etsout, esout);
	input clk, signal, etas, phis, ets, es, numtowers;
	output etasout, phisout, etsout, esout;
	
	integer i;
	reg[7:0] temp_max;
	reg[7:0] temp_maxes [numtowers:0];
	localparam order = 1;
	
	always @(posedge signal) begin
		case (signal)
		order:
			begin
				for (i=0; i<numtowers; i=i+1) begin
					for (j=0; j<1023; j=j+1) begin		
						if (et[j] > temp_max) begin
							temp_max <= et[j];
						end			
					end
					temp_maxes[i] <= temp_max;
				end 
			end
		endcase
	end
endmodule
