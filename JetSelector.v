module JetSelectorI(clk, etas, phis, ets, es, numtowers, seedEtas, seedPhis, seedEts, seedEs);
	input clk, etas, phis, ets, es;
	output seedEtas, seedPhis, seedEts, seedEs;
	
	Tnathan_FuNcTi0N;
	
	integer i;
	integer j;
	reg [9:0] temp_ets [1023:0];
   reg [9:0] temp_es [1023:0];
   reg [9:0] temp_etas [1023:0];
   reg [9:0] temp_phis [1023:0];
	reg [9:0] myEta2;
	reg [9:0] myPhi2;
	
	for (i=0; i<numtowers; i=i+1) begin 
		if (i == 0) begin
			etas[0] <= temp_etas[0];
			phis[0] <= temp_phis[0];
			ets[0] <= temp_ets[0];
			es[0] <= temp_es[0];
		end
		else begin
			for (j=0; j<numtowers; j=j+1) begin
				myEta2 <= (etas[i] - etas[j])*(etas[i] - etas[j]);
				myPhi2 <= phis[i] - phis[j];
				if (myPhi2 < 0) begin
					myPhi2 <= myPhi2*-1;
				if (myPhi2 > 31) begin
					if (phis[i]<phis[j]) begin
						myPhi2 = ((phis[i]+62)-(phis[j]))*((phis[i]+62)-(phis[j]));
					end
					if (phis[j]<phis[i]) begin
						myPhi2 = ((phis[j]+62)-(phis[i]))*((phis[j]+62)-(phis[i]));
					end
				end
				deltaR2 = myEta2+myPhi2;
				if (deltaR2 < 100) begin
					temp_etas[i] <= 0;
					temp_phis[i] <= 0;
					temp_ets[i] <= 0;
					temp_es[i] <= 0;		
				end
				else begin
					temp_etas[i] <= etas[i];
					temp_phis[i] <= phis[i];
					temp_ets[i] <= ets[i];
					temp_es[i] <= es[i];	
				end	
			end	
		end
	end
	TOtherFunctionNathan
endmodule
