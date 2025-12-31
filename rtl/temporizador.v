module temporizador #(
parameter BIT_fin=26, fin = 26'd50000000 //1 seg
)(
input wire clk,
input wire init,
output reg out,
output reg done
);

reg [BIT_fin-1:0]con = 0;
reg status = 0;
parameter START=0, COUNT=1;

always @(posedge clk) begin

	case(status)
		START: begin
			if(init)begin
				out <= 1'b0; 
				con <= 1'b0;
				done <=1'b0;
				status = COUNT;
			end
		end
		COUNT: begin
			out <= 1'b1;
			con <= con+1;
			if(con == fin-1)begin
				done <= 1'b1;
				out <= 1'b0; 
				status = START;
			end
		end
		default:
			status= START;
	endcase
end

endmodule