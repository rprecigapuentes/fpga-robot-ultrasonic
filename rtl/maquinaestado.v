module maquinaestado (
    input wire on,
	input wire LF,
	input wire RF,
	input wire LB,
	input wire RB,
	input wire U,
	input wire clk,
	
	output reg [3:0] estado
);

reg [30:0]con;
reg lastD;
parameter QUIETO=4'd0, DERECHA=4'd1, IZQUIERDA=4'd2, ADELANTE=4'd3, SETUP=4'd4, OFF=4'd8;

always @(posedge clk) begin 
	case (estado)
	    SETUP: begin
	       con <= con+1;
	       if(on==1'b0) estado <= OFF;
	       else if(con[30]==1'b1)begin
	           estado <= QUIETO;
	       end
	    end
		QUIETO: begin 
			// aquí van las salidas del estado 
			if(on==1'b0) estado = OFF;
            else if ((U==1'b0 & lastD==1'b0) | (RF | RB)==1'b1) estado <= DERECHA;
            else if ((U==1'b0 & lastD==1'b1) | (LF | LB)==1'b1) estado <= IZQUIERDA;
            else if (U==1'b1 | (LB & RB)==1'b1) estado <= ADELANTE;
		end
	
		DERECHA: begin
            if(on==1'b0) estado <= OFF;
            else if (U==1'b1) estado <= ADELANTE;
            else if ((RF | RB)==1'b0)begin
                estado <= QUIETO; lastD <= 1'b1;
            end 
		end

		IZQUIERDA: begin
            if(on==1'b0) estado <= OFF;
            else if (U==1'b1) estado <= ADELANTE;
            else if ((LF | LB)==1'b0)begin
                estado <= QUIETO; lastD <= 1'b0;
            end
		end
		

		ADELANTE: begin
            if(on==1'b0) estado <= OFF;
            else if ((LF & RF)==1'b0 | U==1'b0) estado <= QUIETO;
		end

		default: begin
		estado <= SETUP; lastD <= 1'b0; con <= 1'b0;
		end
	endcase 
end
 



endmodule 