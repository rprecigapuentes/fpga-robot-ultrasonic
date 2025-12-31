module ultra(
input wire clk,
input wire init,
input wire echo,
output reg trigger,
output reg done,
output reg [15:0] dist
);

parameter START=3'd0, TRIGGER =3'd1, ECHO =3'd2, END =3'd4,
BIT_echo= 22; //Tomando los bits necesarios para los ciclos correspondientes a la distancia de 5m

reg [1:0]status = 0;
reg doneEchoreg;
reg [31:0]perEchoreg;
reg doneTriggerreg;
reg auxreg;
wire doneEcho;
wire [31:0]perEcho;
wire doneTrigger;
wire aux;
wire triggerw;

assign doneEcho = doneEchoreg;
assign perEcho [31:0] = perEchoreg [31:0];
assign doneTrigger = doneTriggerreg;
assign aux = auxreg;

contador #(.BIT_periodo(BIT_echo))(.clk(clk), .enable(echo), .periodo(perEcho), .done(doneEcho));
temporizador #(.BIT_fin(11), .fin(11'd1250))(.clk(clk), .init(aux), .out(triggerw), .done(doneTrigger));

always @(posedge clk)begin
trigger <= triggerw;

	case(status)
		//Estado de espera
		START: begin
		done <= 1'b0;
			if(init)begin
				auxreg <= 1'b1;
				status <=TRIGGER;
			end
		end
		//Envia una señal de trigger en alto por 10ns 
		TRIGGER: begin
		
			if(doneTrigger)begin
				auxreg <= 1'b0;
				status <= ECHO;
			end
		end
		//Recibe una señal Echo cuyo ancho en alto es proporcional a la distancia medida
		ECHO: begin
		done <= 1'b1;
		dist <= perEcho*17/12500;
		if(init)begin
				status <= START;
			end
		end
		default:
			status <= START;
	endcase
end

endmodule
