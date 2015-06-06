module towerordinality(clk, signal, etas, phis, ets, es, numtowers, etasout, phisout, etsout, esout);
   input clk, signal, etas, phis, ets, es, numtowers;
   output etasout, phisout, etsout, esout;
   
   integer i;
   reg [7:0] temp_et;
   reg [7:0] temp_e;
   reg [7:0] temp_eta;
   reg [7:0] temp_phi;
   reg [7:0] found;
   reg 	     found_flag;
   
   reg [7:0] temp_ets [numtowers:0];
   reg [7:0] temp_es [numtowers:0];
   reg [7:0] temp_etas [numtowers:0];
   reg [7:0] temp_phis [numtowers:0];
   reg [7:0] previously_found [numtowers:0];
   
   localparam order = 1, True = 1, False = 0;
   
   always @(posedge signal) begin
      case (signal)
	order:
	  begin
	     // Initialize all elements in previously_found to 0 incase of VooDoo
	     for (i=0; i<numtowers; i=i+1) begin
		previously_found[i] <= 1024;
	     end
	     // Find numtowers maxima 
	     for (i=0; i<numtowers; i=i+1) begin
		for (j=0; j<1023; j=j+1) begin		
		   if (et[j] > temp_et) begin
		      found_flag <= False;
		      for (k=0; k<numtowers; k=k+1) begin
			 found_flag = True;
		      end
		      if (found_flag == False) begin
			 temp_et <= et[j];
			 temp_e <= es[j];
			 temp_eta <= etas[j];
			 temp_phi <= phis[j];
			 found <= j;
		      end
		   end			
		end
		previously_found[i] <= j;
		temp_ets[i] <= temp_et;
		temp_es[i] <= temp_e;
		temp_etas[i] <= temp_eta;
		temp_phis[i] <= temp_phi;
	     end 
	  end
      endcase
   end // always @ (posedge signal)
   etasout <= temp_etas;
   phisout <= temp_phis;
   etsout <= temp_ets;
   esout <= temp_es;
endmodule
