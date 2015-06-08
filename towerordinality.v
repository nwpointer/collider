module towerordinality(clk, signal, numtowers, etasout, phisout, etsout, esout);
   input clk, signal, numtowers;
   output etasout, phisout, etsout, esout;
   
   integer i;
	integer j;
	integer k;
	integer h;
	integer m;
   reg [9:0] temp_et;
   reg [9:0] temp_e;
   reg [9:0] temp_eta;
   reg [9:0] temp_phi;
   reg [9:0] found [1023:0];
   reg 	     found_flag;
	
   reg [9:0] temp_ets [1023:0];
   reg [9:0] temp_es [1023:0];
   reg [9:0] temp_etas [1023:0];
   reg [9:0] temp_phis [1023:0];
   reg [9:0] previously_found [1023:0];
	
	reg [9:0] ets [1023:0];
   reg [9:0] es [1023:0];
   reg [9:0] etas [1023:0];
   reg [9:0] phis [1023:0];
	
	reg io;
	reg index;
	reg zero;
	reg zero1;
	reg zero2;
	reg[9:0] epulled;
	reg[9:0] etpulled;
	reg[9:0] etapulled;
	reg[9:0] phipulled;
	
   localparam order = 1, True = 1, False = 0;
   
   always @(posedge signal) begin
      case (signal)
			order:
				begin
					io <= 0;
					zero <= 0;
					zero1 <= 0;
					zero2 <= 0;
					// Get All the data
					//unpack dataunpack(clk, rst, io, index, zero, zero1, zero2, epulled, etpulled, phipulled, etapulled);
					
					for (i=0; i<numtowers; i=i+1) begin
						assign ets[i] = etpulled;
						assign es[i] = epulled;
						assign phis[i] = phipulled;
						assign etas[i] = etapulled;
					end
					
					// Initialize all elements in previously_found to 0 incase of VooDoo
				for (i=0; i<numtowers; i=i+1) begin
					previously_found[i] <= 1024;
				end
				// Find arraySize maxima 
				for (i=0; i<numtowers; i=i+1) begin
					for (j=0; j<1023; j=j+1) begin		
						if (ets[j] > temp_et) begin
							found_flag <= False;
							for (k=0; k<numtowers; k=k+1) begin
								if (ets[j] == found[k]) begin
									found_flag = True;
								end
							end
							if (found_flag == False) begin
								temp_et <= ets[j];
								temp_e <= es[j];
								temp_eta <= etas[j];
								temp_phi <= phis[j];
								found[j] <= j;
							end
						end			
					end
					previously_found[i] <= j;
					temp_ets[i] <= temp_et;
					temp_es[i] <= temp_e;
					temp_etas[i] <= temp_eta;
					temp_phis[i] <= temp_phi;
				end 
				for (i=0; i<numtowers; i=i+1) begin
					h = 32*(i-1);
					m = 32*i;
					etasout[5:0] <= temp_etas[i];
					phisout[h:m] <= temp_phis[i];
					etsout[h:m] <= temp_ets[i];
					esout[h:m] <= temp_es[i];
				end
			end	
      endcase
   end // always @ (posedge signal)
	// Cannot have entire array as output. Need to flatten array first.
endmodule
