module JetSelectorI(clk, etas, phis, ets, es, numtowers, seedEtas, seedPhis, seedEts, seedEs);
	input clk, etas, phis, ets, es;
	output seedEtas, seedPhis, seedEts, seedEs;
	
	// Tnathan_FuNcTi0N;
	
	integer i;
	integer j;
	reg [9:0] temp_ets [1023:0];
   reg [9:0] temp_es [1023:0];
   reg [9:0] temp_etas [1023:0];
   reg [9:0] temp_phis [1023:0];
	reg [9:0] myEta2;
	reg [9:0] myPhi2;
	
	always@(posedge clk) begin
		for (i=0; i<numtowers; i=i+1) begin 	
			if (i == 0) begin
				assign etas[0] = temp_etas[0];
				assign phis[0] = temp_phis[0];
				assign ets[0] = temp_ets[0];
				assign es[0] = temp_es[0];
			end
			else begin
				for (j=0; j<numtowers; j=j+1) begin
					assign myEta2 = (etas[i] - etas[j])*(etas[i] - etas[j]);
					assign myPhi2 = phis[i] - phis[j];
					if (myPhi2 < 0) begin
						assign myPhi2 = myPhi2*-1;
					end
					if (myPhi2 > 31) begin
						if (phis[i]<phis[j]) begin
							assign myPhi2 = ((phis[i]+62)-(phis[j]))*((phis[i]+62)-(phis[j]));
						end
						if (phis[j] < phis[i]) begin
							assign myPhi2 = ((phis[j]+62)-(phis[i]))*((phis[j]+62)-(phis[i]));
						end
					end
					deltaR2 = myEta2+myPhi2;
					if (deltaR2 < 100) begin
						assign temp_etas[i] = 0;
						assign temp_phis[i] = 0;
						assign temp_ets[i] = 0;
						assign temp_es[i] = 0;		
					end
					else begin
						assign temp_etas[i] = etas[i];
						assign temp_phis[i] = phis[i];
						assign temp_ets[i] = ets[i];
						assign temp_es[i] = es[i];	
					end	
				end	
			end
		end
		// TOtherFunctionNathan 
	end
endmodule
	
